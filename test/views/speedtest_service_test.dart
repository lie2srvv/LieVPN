import 'package:flutter_test/flutter_test.dart';
import 'package:fl_clash/views/speedtest/speedtest_models.dart';
import 'package:fl_clash/views/speedtest/speedtest_service.dart';

void main() {
  group('SpeedtestService', () {
    test('SpeedtestState initial values and copyWith', () {
      const state = SpeedtestState();
      expect(state.phase, SpeedtestPhase.idle);
      expect(state.isRunning, false);
      expect(state.currentSpeedMbps, 0.0);
      expect(state.downloadMbps, isNull);
      expect(state.uploadMbps, isNull);
      expect(state.pingMs, isNull);

      final runningState = state.copyWith(
        phase: SpeedtestPhase.download,
        currentSpeedMbps: 45.2,
      );
      expect(runningState.isRunning, true);
      expect(runningState.currentSpeedMbps, 45.2);
    });

    test('cancel() sets _isCanceled and stops', () async {
      final service = SpeedtestService();
      final updates = <SpeedtestState>[];

      final future = service.runTest(
        isVpnConnected: true,
        onUpdate: (s) => updates.add(s),
      );

      // Cancel immediately
      service.cancel();
      await future;

      expect(updates, isNotEmpty);
      expect(updates.first.phase, SpeedtestPhase.download);
    });
  });
}
