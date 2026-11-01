import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/action.dart';
import 'package:fl_clash/providers/state.dart';
import 'package:fl_clash/state.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VpnManager extends ConsumerStatefulWidget {
  final Widget child;

  const VpnManager({super.key, required this.child});

  @override
  ConsumerState<VpnManager> createState() => _VpnContainerState();
}

class _VpnContainerState extends ConsumerState<VpnManager> {
  @override
  void initState() {
    super.initState();
    ref.listenManual(vpnStateProvider, (prev, next) {
      if (prev != next) {
        _handleVpnStateChange(next);
      }
    });
  }

  void _handleVpnStateChange(VpnState state) {
    throttler.call(
      FunctionTag.vpnTip,
      () async {
        if (!ref.read(isStartProvider) || state == globalState.lastVpnState) {
          return;
        }
        globalState.lastVpnState = state;
        commonPrint.log('VPN network state change detected, auto-reconnecting...');
        try {
          final setupAction = ref.read(setupActionProvider.notifier);
          await setupAction.setRunning(false);
          await Future.delayed(const Duration(milliseconds: 600));
          if (mounted && ref.read(isStartProvider) == false) {
            await setupAction.setRunning(true);
          }
        } catch (e) {
          commonPrint.log('VPN auto-reconnect error: $e', logLevel: LogLevel.warning);
        }
      },
      duration: const Duration(seconds: 4),
      fire: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
