import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:fl_clash/common/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Milestone days that trigger celebratory notifications.
const List<int> streakMilestones = [
  10, 30, 50, 100, 200, 300, 365, 400, 500, 600, 700, 800, 900, 1000
];

/// Encapsulates the verified persistent streak state.
class StreakState {
  final int count;
  final String lastActiveDateMsk; // YYYY-MM-DD
  final String lastCheckDateMsk;  // YYYY-MM-DD
  final int restoresUsedThisMonth;
  final String currentMonthMsk;   // YYYY-MM
  final int lastMilestoneDismissed;
  final bool isActiveToday;
  final bool canRestore;

  const StreakState({
    required this.count,
    required this.lastActiveDateMsk,
    required this.lastCheckDateMsk,
    required this.restoresUsedThisMonth,
    required this.currentMonthMsk,
    required this.lastMilestoneDismissed,
    required this.isActiveToday,
    required this.canRestore,
  });

  StreakState copyWith({
    int? count,
    String? lastActiveDateMsk,
    String? lastCheckDateMsk,
    int? restoresUsedThisMonth,
    String? currentMonthMsk,
    int? lastMilestoneDismissed,
    bool? isActiveToday,
    bool? canRestore,
  }) {
    return StreakState(
      count: count ?? this.count,
      lastActiveDateMsk: lastActiveDateMsk ?? this.lastActiveDateMsk,
      lastCheckDateMsk: lastCheckDateMsk ?? this.lastCheckDateMsk,
      restoresUsedThisMonth: restoresUsedThisMonth ?? this.restoresUsedThisMonth,
      currentMonthMsk: currentMonthMsk ?? this.currentMonthMsk,
      lastMilestoneDismissed: lastMilestoneDismissed ?? this.lastMilestoneDismissed,
      isActiveToday: isActiveToday ?? this.isActiveToday,
      canRestore: canRestore ?? this.canRestore,
    );
  }

  Map<String, dynamic> toJson() => {
    'count': count,
    'lastActiveDateMsk': lastActiveDateMsk,
    'lastCheckDateMsk': lastCheckDateMsk,
    'restoresUsedThisMonth': restoresUsedThisMonth,
    'currentMonthMsk': currentMonthMsk,
    'lastMilestoneDismissed': lastMilestoneDismissed,
  };

  factory StreakState.fromJson(Map<String, dynamic> json, {required String todayMsk}) {
    final count = (json['count'] as num?)?.toInt() ?? 0;
    final lastActiveDateMsk = (json['lastActiveDateMsk'] as String?) ?? '';
    final lastCheckDateMsk = (json['lastCheckDateMsk'] as String?) ?? '';
    var restoresUsed = (json['restoresUsedThisMonth'] as num?)?.toInt() ?? 0;
    var currentMonth = (json['currentMonthMsk'] as String?) ?? '';
    final lastMilestone = (json['lastMilestoneDismissed'] as num?)?.toInt() ?? 0;

    final thisMonthMsk = todayMsk.length >= 7 ? todayMsk.substring(0, 7) : '';
    if (currentMonth != thisMonthMsk) {
      currentMonth = thisMonthMsk;
      restoresUsed = 0;
    }

    final isActiveToday = lastActiveDateMsk == todayMsk;
    // Streak is restorable if it was broken (count > 0 or previously active, but not active today and not yesterday)
    final canRestore = !isActiveToday && restoresUsed < 3 && count > 0;

    return StreakState(
      count: count,
      lastActiveDateMsk: lastActiveDateMsk,
      lastCheckDateMsk: lastCheckDateMsk,
      restoresUsedThisMonth: restoresUsed,
      currentMonthMsk: currentMonth,
      lastMilestoneDismissed: lastMilestone,
      isActiveToday: isActiveToday,
      canRestore: canRestore,
    );
  }

  static const StreakState initial = StreakState(
    count: 0,
    lastActiveDateMsk: '',
    lastCheckDateMsk: '',
    restoresUsedThisMonth: 0,
    currentMonthMsk: '',
    lastMilestoneDismissed: 0,
    isActiveToday: false,
    canRestore: false,
  );
}

/// Global manager for Streak calculation, tamper-evident storage, and MSK synchronization.
class StreakManager {
  static StreakManager? _instance;
  static StreakManager get instance => _instance ??= StreakManager._();

  final ValueNotifier<StreakState> streakNotifier = ValueNotifier(StreakState.initial);
  final ValueNotifier<int?> pendingMilestoneNotifier = ValueNotifier(null);

  Duration _networkTimeOffset = Duration.zero;
  bool _isInitialized = false;
  Timer? _midnightCheckTimer;
  Timer? _reminderTimer;
  String _deviceSalt = '';

  StreakManager._();

  /// Current network-adjusted Moscow Time (MSK = UTC+3)
  DateTime get nowMsk {
    final utc = DateTime.now().toUtc().add(_networkTimeOffset);
    return utc.add(const Duration(hours: 3));
  }

  String get todayMskDateString {
    final d = nowMsk;
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$y-$m-$day';
  }

  String get yesterdayMskDateString {
    final d = nowMsk.subtract(const Duration(days: 1));
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$y-$m-$day';
  }

  /// Initialize manager, sync time, load and verify streak data.
  Future<void> init() async {
    if (_isInitialized) return;
    _isInitialized = true;

    await _initDeviceSalt();
    await _syncNetworkTime();
    await _loadStreakData();

    _setupMidnightTimer();
    _checkDailyReminder();
  }

  /// Generate or retrieve an obfuscated per-installation device salt
  Future<void> _initDeviceSalt() async {
    final sp = await preferences.sharedPreferencesCompleter.future;
    var salt = sp?.getString('lie_sec_ds');
    if (salt == null || salt.isEmpty) {
      final random = Random.secure();
      final bytes = List<int>.generate(32, (_) => random.nextInt(256));
      salt = sha256.convert(bytes).toString();
      await sp?.setString('lie_sec_ds', salt);
    }
    _deviceSalt = salt;
  }

  /// Synchronize network time from our server or world time API to prevent clock spoofing
  Future<void> _syncNetworkTime() async {
    try {
      final dio = Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 4),
          receiveTimeout: const Duration(seconds: 4),
        ),
      );
      final response = await dio.head('https://clck.lie2srvv.com/files/version.json');
      final dateHeader = response.headers.value('date');
      if (dateHeader != null && dateHeader.isNotEmpty) {
        final serverUtc = HttpDate.parse(dateHeader).toUtc();
        final localUtc = DateTime.now().toUtc();
        _networkTimeOffset = serverUtc.difference(localUtc);
      }
    } catch (_) {
      // Fallback: system time with offset 0
    }
  }

  /// File path in app persistent storage (homeDirPath)
  Future<File> _getStorageFile() async {
    final homePath = await appPath.homeDirPath;
    return File('$homePath/streak_secure.dat');
  }

  /// HMAC signature computation
  String _computeSignature(Map<String, dynamic> data) {
    final payload = '${data['count']}|${data['lastActiveDateMsk']}|${data['restoresUsedThisMonth']}|${data['currentMonthMsk']}|$_deviceSalt';
    final key = utf8.encode('LieVPN_Flame_Streak_Secret_2026_@#!');
    final hmac = Hmac(sha256, key);
    return hmac.convert(utf8.encode(payload)).toString();
  }

  /// Load and cryptographically verify data
  Future<void> _loadStreakData() async {
    try {
      final file = await _getStorageFile();
      final today = todayMskDateString;

      if (!await file.exists()) {
        final initial = StreakState.fromJson({}, todayMsk: today);
        streakNotifier.value = initial;
        await _saveStreakData(initial);
        return;
      }

      final raw = await file.readAsString();
      final decodedJson = json.decode(utf8.decode(base64.decode(raw))) as Map<String, dynamic>;

      final signature = decodedJson['sig'] as String?;
      final expectedSig = _computeSignature(decodedJson);

      if (signature == null || signature != expectedSig) {
        // Tampered file detected: reset to zero
        final resetState = StreakState.fromJson({}, todayMsk: today);
        streakNotifier.value = resetState;
        await _saveStreakData(resetState);
        return;
      }

      var loaded = StreakState.fromJson(decodedJson, todayMsk: today);

      // Check if streak was broken (missed yesterday)
      if (loaded.count > 0 && !loaded.isActiveToday) {
        final yesterday = yesterdayMskDateString;
        if (loaded.lastActiveDateMsk != yesterday && loaded.lastActiveDateMsk != today) {
          // Streak broke: keep count display for restoration prompt, or mark inactive
          loaded = loaded.copyWith(
            isActiveToday: false,
            canRestore: loaded.restoresUsedThisMonth < 3,
          );
        }
      }

      streakNotifier.value = loaded;
      _checkMilestones(loaded);
    } catch (e) {
      final today = todayMskDateString;
      final fallback = StreakState.fromJson({}, todayMsk: today);
      streakNotifier.value = fallback;
    }
  }

  /// Save with signature and obfuscation
  Future<void> _saveStreakData(StreakState state) async {
    try {
      final file = await _getStorageFile();
      final data = state.toJson();
      data['sig'] = _computeSignature(data);
      final rawBase64 = base64.encode(utf8.encode(json.encode(data)));
      await file.writeAsString(rawBase64, flush: true);

      // Backup to SharedPreferences as well
      final sp = await preferences.sharedPreferencesCompleter.future;
      await sp?.setString('lie_streak_backup', rawBase64);
    } catch (_) {}
  }

  /// Triggered whenever VPN connects successfully (connected state with real traffic)
  Future<void> onSuccessfulConnection() async {
    await _syncNetworkTime();
    final today = todayMskDateString;
    final yesterday = yesterdayMskDateString;
    final current = streakNotifier.value;

    if (current.isActiveToday && current.lastActiveDateMsk == today) {
      // Already active for today
      return;
    }

    int newCount = current.count;
    if (current.lastActiveDateMsk == yesterday) {
      newCount += 1;
    } else if (current.lastActiveDateMsk == today) {
      // already counted
    } else {
      // Missed more than 1 day
      newCount = 1;
    }

    final updated = current.copyWith(
      count: newCount,
      lastActiveDateMsk: today,
      lastCheckDateMsk: today,
      isActiveToday: true,
      canRestore: false,
    );

    streakNotifier.value = updated;
    await _saveStreakData(updated);
    _checkMilestones(updated);
  }

  /// Manual restore (up to 3 times per calendar month)
  Future<bool> restoreStreak() async {
    final today = todayMskDateString;
    final current = streakNotifier.value;

    final thisMonthMsk = today.substring(0, 7);
    var restoresUsed = current.restoresUsedThisMonth;
    if (current.currentMonthMsk != thisMonthMsk) {
      restoresUsed = 0;
    }

    if (restoresUsed >= 3) {
      return false;
    }

    final updated = current.copyWith(
      restoresUsedThisMonth: restoresUsed + 1,
      currentMonthMsk: thisMonthMsk,
      isActiveToday: true,
      lastActiveDateMsk: today,
      canRestore: false,
    );

    streakNotifier.value = updated;
    await _saveStreakData(updated);
    return true;
  }

  /// Check milestones (10, 30, 50, 100...)
  void _checkMilestones(StreakState state) {
    if (state.count <= 0) return;
    for (final m in streakMilestones) {
      if (state.count == m && state.lastMilestoneDismissed != m) {
        pendingMilestoneNotifier.value = m;
        break;
      }
    }
  }

  void dismissMilestone(int milestone) {
    pendingMilestoneNotifier.value = null;
    final updated = streakNotifier.value.copyWith(
      lastMilestoneDismissed: milestone,
    );
    streakNotifier.value = updated;
    _saveStreakData(updated);
  }

  /// Schedule daily check at 00:00:05 MSK
  void _setupMidnightTimer() {
    _midnightCheckTimer?.cancel();
    final now = nowMsk;
    final nextMidnight = DateTime(now.year, now.month, now.day + 1, 0, 0, 5);
    final diff = nextMidnight.difference(now);

    _midnightCheckTimer = Timer(diff, () async {
      await _loadStreakData();
      _setupMidnightTimer();
    });
  }

  /// Check if daily reminder notification should be sent (between 12:00 and 18:00 MSK)
  void _checkDailyReminder() {
    _reminderTimer?.cancel();
    _reminderTimer = Timer.periodic(const Duration(minutes: 30), (_) async {
      final now = nowMsk;
      final current = streakNotifier.value;
      if (current.isActiveToday) return; // already active

      // Between 12:00 and 18:00 MSK
      if (now.hour >= 12 && now.hour < 18) {
        final sp = await preferences.sharedPreferencesCompleter.future;
        final lastRemindedDate = sp?.getString('lie_last_streak_reminder');
        final today = todayMskDateString;
        if (lastRemindedDate != today) {
          await sp?.setString('lie_last_streak_reminder', today);
          await _sendStreakReminderPush(current.count);
        }
      }
    });
  }

  /// Send system notification reminder on Android/Desktop
  Future<void> _sendStreakReminderPush(int streakCount) async {
    try {
      if (Platform.isAndroid) {
        const platform = MethodChannel('com.follow.clash/app');
        await platform.invokeMethod('showStreakReminder', {
          'count': streakCount,
        });
      }
    } catch (_) {}
  }

  void dispose() {
    _midnightCheckTimer?.cancel();
    _reminderTimer?.cancel();
  }
}
