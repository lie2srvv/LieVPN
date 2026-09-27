import 'dart:async';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/core/controller.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConnectionHealthManager extends ConsumerStatefulWidget {
  final Widget child;

  const ConnectionHealthManager({super.key, required this.child});

  @override
  ConsumerState<ConnectionHealthManager> createState() =>
      _ConnectionHealthManagerState();
}

class _ConnectionHealthManagerState
    extends ConsumerState<ConnectionHealthManager> {
  Timer? _healthTimer;
  int _consecutiveFailures = 0;
  bool _isChecking = false;
  DateTime? _connectedAt;

  @override
  void initState() {
    super.initState();
    ref.listenManual(isStartProvider, (prev, next) {
      if (next) {
        _connectedAt = DateTime.now();
        _consecutiveFailures = 0;
        _startHealthTimer();
      } else {
        _stopHealthTimer();
        _consecutiveFailures = 0;
        _connectedAt = null;
        ref.read(currentServerPingProvider.notifier).updatePing(0);
      }
    });

    ref.listenManual(
      appSettingProvider.select(
        (s) => (s.liveNotification, s.liveNotificationType),
      ),
      (prev, next) {
        if (ref.read(isStartProvider)) {
          _startHealthTimer();
        }
      },
    );

    if (ref.read(isStartProvider)) {
      _connectedAt = DateTime.now();
      _startHealthTimer();
    }
  }

  void _startHealthTimer() {
    _healthTimer?.cancel();
    final isPingType = ref.read(
      appSettingProvider.select(
        (s) => s.liveNotification && s.liveNotificationType == 6,
      ),
    );
    final interval = isPingType
        ? const Duration(seconds: 4)
        : const Duration(seconds: 15);
    _healthTimer = Timer.periodic(interval, (_) => _checkConnectionHealth());
  }

  void _stopHealthTimer() {
    _healthTimer?.cancel();
    _healthTimer = null;
  }

  Future<void> _checkConnectionHealth() async {
    if (!mounted || _isChecking) return;
    if (!ref.read(isStartProvider)) return;

    final isPingType = ref.read(
      appSettingProvider.select(
        (s) => s.liveNotification && s.liveNotificationType == 6,
      ),
    );

    // Give connection at least 4 seconds (or 10s if default) to stabilize
    final minSeconds = isPingType ? 4 : 10;
    if (_connectedAt != null &&
        DateTime.now().difference(_connectedAt!).inSeconds < minSeconds) {
      return;
    }

    _isChecking = true;
    try {
      final testUrl = ref.read(
        appSettingProvider.select((state) => state.testUrl),
      );
      final groups = ref.read(groupsProvider);
      final selectedMap = ref.read(selectedMapProvider);
      final proxyName = resolveConnectedServerName(
        groups: groups,
        selectedMap: selectedMap,
      );

      if (proxyName.isEmpty) {
        ref.read(currentServerPingProvider.notifier).updatePing(0);
        _isChecking = false;
        return;
      }

      final delay = await coreController.getDelay(testUrl, proxyName);
      final isAlive = delay != null && (delay.value ?? 0) > 0;
      if (isAlive) {
        _consecutiveFailures = 0;
        ref.read(currentServerPingProvider.notifier).updatePing(delay.value ?? 0);
      } else {
        _consecutiveFailures++;
        ref.read(currentServerPingProvider.notifier).updatePing(0);
        commonPrint.log(
          'Health check: proxy $proxyName ping failed (failure #$_consecutiveFailures)',
          logLevel: LogLevel.warning,
        );
        if (_consecutiveFailures >= 2) {
          _consecutiveFailures = 0;
          if (mounted && ref.read(isStartProvider)) {
            commonPrint.log(
              'Server stopped responding to ping. Auto-reconnecting VPN...',
              logLevel: LogLevel.info,
            );
            dialogs.showNotifier(
              currentAppLocalizations.serverNotRespondingReconnecting,
              level: MessageLevel.warning,
            );
            final setupAction = ref.read(setupActionProvider.notifier);
            await setupAction.setRunning(false);
            await Future.delayed(const Duration(milliseconds: 600));
            if (mounted && ref.read(isStartProvider) == false) {
              _connectedAt = DateTime.now();
              await setupAction.setRunning(true);
            }
          }
        }
      }
    } catch (e) {
      commonPrint.log(
        'Health check error: $e',
        logLevel: LogLevel.warning,
      );
    } finally {
      _isChecking = false;
    }
  }

  @override
  void dispose() {
    _stopHealthTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
