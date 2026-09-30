import 'package:fl_clash/plugins/app.dart';
import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';

class AppUpdateInfo {
  final String version;
  final String downloadUrl;
  final String? releaseNotes;

  const AppUpdateInfo({
    required this.version,
    required this.downloadUrl,
    this.releaseNotes,
  });

  /// Default GitHub release assets per platform
  static String get defaultDownloadUrl {
    if (Platform.isAndroid) {
      return 'https://github.com/lie2srvv/LieVPN/releases/latest/download/LieVPN.apk';
    } else if (Platform.isWindows) {
      return 'https://github.com/lie2srvv/LieVPN/releases/latest/download/LieVPN.exe';
    } else if (Platform.isLinux) {
      return 'https://github.com/lie2srvv/LieVPN/releases/latest/download/LieVPN.AppImage';
    } else {
      return 'https://github.com/lie2srvv/LieVPN/releases/latest/download/LieVPN.apk';
    }
  }

  /// Parses platform-specific update info with fallback to legacy flat format
  factory AppUpdateInfo.fromPlatformJson(Map<String, dynamic> json) {
    String platformKey;
    if (Platform.isAndroid) {
      platformKey = 'android';
    } else if (Platform.isWindows) {
      platformKey = 'windows';
    } else if (Platform.isLinux) {
      platformKey = 'linux';
    } else {
      platformKey = 'other';
    }

    final defaultUrl = defaultDownloadUrl;

    // 1. If combined version.json with OS-specific subobjects (android, windows, linux)
    if (json[platformKey] is Map<String, dynamic>) {
      final pMap = json[platformKey] as Map<String, dynamic>;
      final downloadUrl = pMap['url'] as String? ??
          (Platform.isWindows
              ? (pMap['windowsUrl'] as String? ?? defaultUrl)
              : Platform.isLinux
                  ? (pMap['linuxUrl'] as String? ?? defaultUrl)
                  : (pMap['apkUrl'] as String? ?? defaultUrl));
      return AppUpdateInfo(
        version: pMap['version'] as String? ?? '0.0.0',
        downloadUrl: downloadUrl,
        releaseNotes: pMap['releaseNotes'] as String? ?? json['releaseNotes'] as String?,
      );
    }

    // If json has other OS sections but missing current platformKey,
    // NEVER fall back to top-level version (it belongs to a different OS)!
    final isCombinedManifest = json.containsKey('android') ||
        json.containsKey('windows') ||
        json.containsKey('linux');
    if (isCombinedManifest) {
      return AppUpdateInfo(
        version: '0.0.0',
        downloadUrl: defaultUrl,
        releaseNotes: null,
      );
    }

    // 2. Direct dedicated platform JSON (e.g. version_linux.json or version_windows.json)
    if (Platform.isLinux && json.containsKey('apkUrl') && !json.containsKey('linuxUrl')) {
      return AppUpdateInfo(version: '0.0.0', downloadUrl: defaultUrl, releaseNotes: null);
    }
    if (Platform.isWindows && json.containsKey('apkUrl') && !json.containsKey('windowsUrl')) {
      return AppUpdateInfo(version: '0.0.0', downloadUrl: defaultUrl, releaseNotes: null);
    }

    final directUrl = json['url'] as String? ??
        (Platform.isWindows
            ? (json['windowsUrl'] as String? ?? defaultUrl)
            : Platform.isLinux
                ? (json['linuxUrl'] as String? ?? defaultUrl)
                : (json['apkUrl'] as String? ?? defaultUrl));

    return AppUpdateInfo(
      version: json['version'] as String? ?? '0.0.0',
      downloadUrl: directUrl,
      releaseNotes: json['releaseNotes'] as String?,
    );
  }
}

class AppUpdateManager {
  // Primary update manifest on GitHub
  static const String _primaryGitHubVersionUrl =
      'https://raw.githubusercontent.com/lie2srvv/LieVPN/main/version.json';

  // Fallbacks on personal server
  static const String _fallbackServerVersionUrl =
      'https://clck.lie2srvv.com/files/version.json';

  static String get _platformServerVersionUrl {
    if (Platform.isAndroid) {
      return 'https://clck.lie2srvv.com/files/version_android.json';
    } else if (Platform.isWindows) {
      return 'https://clck.lie2srvv.com/files/version_windows.json';
    } else if (Platform.isLinux) {
      return 'https://clck.lie2srvv.com/files/version_linux.json';
    }
    return _fallbackServerVersionUrl;
  }

  static bool isNewerVersion(String latest, String current) {
    final l = latest
        .replaceFirst(RegExp(r'^[vV]'), '')
        .split('.')
        .map((e) => int.tryParse(e) ?? 0)
        .toList();
    final c = current
        .replaceFirst(RegExp(r'^[vV]'), '')
        .split('.')
        .map((e) => int.tryParse(e) ?? 0)
        .toList();

    while (l.length < 3) {
      l.add(0);
    }
    while (c.length < 3) {
      c.add(0);
    }

    for (int i = 0; i < 3; i++) {
      if (l[i] > c[i]) return true;
      if (l[i] < c[i]) return false;
    }
    return false;
  }

  static Future<AppUpdateInfo?> fetchUpdate() async {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 6),
        receiveTimeout: const Duration(seconds: 8),
      ),
    );

    // 1. Primary: check latest versions manifest from GitHub
    try {
      final response = await dio.get<Map<String, dynamic>>(
        _primaryGitHubVersionUrl,
        options: Options(responseType: ResponseType.json),
      );
      if (response.statusCode == 200 && response.data != null) {
        final updateInfo = AppUpdateInfo.fromPlatformJson(response.data!);
        final currentVersion = globalState.packageInfo.version;
        if (isNewerVersion(updateInfo.version, currentVersion)) {
          return updateInfo;
        }
        return null;
      }
    } catch (_) {}

    // 2. Secondary fallback: check platform-specific endpoint on personal server
    try {
      final response = await dio.get<Map<String, dynamic>>(
        _platformServerVersionUrl,
        options: Options(responseType: ResponseType.json),
      );
      if (response.statusCode == 200 && response.data != null) {
        final updateInfo = AppUpdateInfo.fromPlatformJson(response.data!);
        final currentVersion = globalState.packageInfo.version;
        if (isNewerVersion(updateInfo.version, currentVersion)) {
          return updateInfo;
        }
        return null;
      }
    } catch (_) {}

    // 3. Tertiary fallback: check combined version.json on personal server
    try {
      final response = await dio.get<Map<String, dynamic>>(
        _fallbackServerVersionUrl,
        options: Options(responseType: ResponseType.json),
      );
      if (response.statusCode == 200 && response.data != null) {
        final updateInfo = AppUpdateInfo.fromPlatformJson(response.data!);
        final currentVersion = globalState.packageInfo.version;
        if (isNewerVersion(updateInfo.version, currentVersion)) {
          return updateInfo;
        }
        return null;
      }
    } catch (_) {}

    return null;
  }

  static Timer? _periodicUpdateTimer;

  /// Automatically triggered on application startup and every 1 minute
  static Future<void> autoCheckUpdate(WidgetRef ref) async {
    final autoCheck = ref.read(appSettingProvider).autoCheckUpdate;
    if (!autoCheck) return;

    // Wait 3 seconds after startup to not compete with network initialization
    await Future.delayed(const Duration(seconds: 3));
    await _checkAndNotifyUpdate();

    // Start periodic 1-minute check
    _periodicUpdateTimer?.cancel();
    _periodicUpdateTimer = Timer.periodic(const Duration(minutes: 1), (_) async {
      final autoCheckEnabled = ref.read(appSettingProvider).autoCheckUpdate;
      if (autoCheckEnabled) {
        await _checkAndNotifyUpdate();
      }
    });
  }

  static String? _lastNotifiedVersion;

  static Future<void> _checkAndNotifyUpdate() async {
    final update = await fetchUpdate();
    if (update != null) {
      if (_lastNotifiedVersion == update.version) {
        return;
      }
      _lastNotifiedVersion = update.version;
      final loc = currentAppLocalizations;

      // 1. In-app banner notifier
      dialogs.showNotifier(
        loc.newVersionAvailable(update.version),
        level: MessageLevel.info,
        actionState: MessageActionState(
          actionText: loc.updateNow,
          action: () {
            final activeContext = globalState.navigatorKey.currentContext;
            if (activeContext != null && activeContext.mounted) {
              showUpdateDialog(activeContext, update);
            }
          },
        ),
      );

      // 2. Android system notification
      if (system.isAndroid) {
        try {
          await App().showNotification(
            title: 'LieVPN',
            message: loc.newVersionAvailable(update.version),
            id: 1003,
          );
        } catch (_) {}
      }
    }
  }

  /// Manually triggered from Tools -> Other -> Check Updates
  static Future<void> manualCheckUpdate(BuildContext context) async {
    final loc = context.appLocalizations;
    context.showNotifier(loc.statusChecking, level: MessageLevel.info);

    try {
      final update = await fetchUpdate();
      if (!context.mounted) return;
      final currentLoc = context.appLocalizations;

      if (update != null) {
        showUpdateDialog(context, update);
      } else {
        context.showNotifier(
          currentLoc.latestVersionInstalled,
          level: MessageLevel.success,
        );
      }
    } catch (_) {
      if (context.mounted) {
        context.showNotifier(
          context.appLocalizations.updateCheckError,
          level: MessageLevel.error,
        );
      }
    }
  }

  static void showUpdateDialog(BuildContext context, AppUpdateInfo update) {
    final loc = context.appLocalizations;

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF22C55E).withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.system_update_rounded,
                      color: Color(0xFF22C55E),
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc.newVersionAvailable(update.version),
                          style: Theme.of(sheetContext)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'LieVPN ${update.version}',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (update.releaseNotes != null && update.releaseNotes!.isNotEmpty) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                  ),
                  child: Text(
                    update.releaseNotes!,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => Navigator.pop(sheetContext),
                      child: Text(loc.updateLater),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF22C55E),
                        foregroundColor: const Color(0xFF060A08),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(sheetContext);
                        dialogs.openUrl(update.downloadUrl);
                      },
                      child: Text(
                        loc.updateNow,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
