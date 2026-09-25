import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'speedtest_models.dart';
import 'speedtest_service.dart';

class SpeedtestView extends ConsumerStatefulWidget {
  const SpeedtestView({super.key});

  @override
  ConsumerState<SpeedtestView> createState() => _SpeedtestViewState();
}

class _SpeedtestViewState extends ConsumerState<SpeedtestView> {
  final SpeedtestService _service = SpeedtestService();
  SpeedtestState _state = const SpeedtestState();

  @override
  void dispose() {
    _service.cancel();
    super.dispose();
  }

  void _startTest() {
    final coreStatus = ref.read(coreStatusProvider);
    final isVpnConnected = coreStatus == CoreStatus.connected;

    _service.runTest(
      isVpnConnected: isVpnConnected,
      onUpdate: (newState) {
        if (mounted) {
          setState(() {
            _state = newState;
          });
        }
      },
    );
  }

  void _cancelTest() {
    _service.cancel();
    if (mounted) {
      setState(() {
        _state = _state.copyWith(
          phase: SpeedtestPhase.idle,
          currentSpeedMbps: 0.0,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = _state;
    final coreStatus = ref.watch(coreStatusProvider);
    final isVpnConnected = coreStatus == CoreStatus.connected;

    final String sourceLabel = state.phase != SpeedtestPhase.idle
        ? state.source.displayName
        : (isVpnConnected
            ? SpeedtestSource.ookla.displayName
            : SpeedtestSource.yandex.displayName);

    return CommonScaffold(
      title: context.appLocalizations.speedtest,
      body: Container(
        color: const Color(0xFF060A08),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 32,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Top Mode Indicator Badge
                      _buildSourceBadge(context, isVpnConnected, sourceLabel),
                      const SizedBox(height: 16),

                      // Center Speed Gauge / Live Display
                      _buildSpeedDisplay(context, state),
                      const SizedBox(height: 24),

                      // 3 Result Cards: Ping / Download / Upload
                      _buildMetricCards(context, state),
                      const SizedBox(height: 16),

                      // Source Attribution Text under results
                      Text(
                        sourceLabel,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.4),
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Action Button
                      _buildActionButton(context, state),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSourceBadge(BuildContext context, bool isVpnConnected, String label) {
    final color = isVpnConnected ? const Color(0xFF22C55E) : const Color(0xFF38BDF8);
    final text = isVpnConnected ? 'VPN подключён (защищённый туннель)' : 'VPN выключен (прямое подключение)';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.25), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.8),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpeedDisplay(BuildContext context, SpeedtestState state) {
    final double displaySpeed = state.currentSpeedMbps > 0
        ? state.currentSpeedMbps
        : (state.downloadMbps ?? 0.0);

    String phaseText = 'Готов к тестированию';
    if (state.phase == SpeedtestPhase.findingServer) {
      phaseText = 'Поиск оптимального сервера...';
    } else if (state.phase == SpeedtestPhase.ping) {
      phaseText = 'Измерение задержки (Ping)...';
    } else if (state.phase == SpeedtestPhase.download) {
      phaseText = 'Тест скорости загрузки (Download)...';
    } else if (state.phase == SpeedtestPhase.upload) {
      phaseText = 'Тест скорости отдачи (Upload)...';
    } else if (state.phase == SpeedtestPhase.completed) {
      phaseText = 'Тест успешно завершён';
    } else if (state.phase == SpeedtestPhase.error) {
      phaseText = 'Ошибка во время теста';
    }

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Outer glowing ring
            SizedBox(
              width: 220,
              height: 220,
              child: CircularProgressIndicator(
                value: state.isRunning ? (state.progress > 0 ? state.progress : null) : 1.0,
                strokeWidth: 8,
                backgroundColor: Colors.white.withValues(alpha: 0.05),
                valueColor: AlwaysStoppedAnimation<Color>(
                  state.isRunning
                      ? const Color(0xFF22C55E)
                      : (state.phase == SpeedtestPhase.completed
                          ? const Color(0xFF22C55E)
                          : Colors.white.withValues(alpha: 0.15)),
                ),
              ),
            ),
            // Inner content
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.speed_rounded,
                  size: 32,
                  color: state.isRunning
                      ? const Color(0xFF22C55E)
                      : Colors.white.withValues(alpha: 0.5),
                ),
                const SizedBox(height: 8),
                Text(
                  displaySpeed > 0 ? displaySpeed.toStringAsFixed(1) : '0.0',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -1,
                  ),
                ),
                Text(
                  'Мбит/с',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          phaseText,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: state.phase == SpeedtestPhase.error
                ? const Color(0xFFEF4444)
                : (state.isRunning
                    ? const Color(0xFF22C55E)
                    : Colors.white.withValues(alpha: 0.6)),
          ),
        ),
        if (state.serverName != null && state.serverName!.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            state.serverName!,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: Colors.white.withValues(alpha: 0.35),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildMetricCards(BuildContext context, SpeedtestState state) {
    return Row(
      children: [
        Expanded(
          child: _buildMetricTile(
            title: 'Ping',
            value: state.pingMs != null ? '${state.pingMs}' : '—',
            unit: 'мс',
            icon: Icons.timer_outlined,
            iconColor: const Color(0xFFF59E0B),
            isActive: state.phase == SpeedtestPhase.ping,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildMetricTile(
            title: 'Download',
            value: state.downloadMbps != null
                ? state.downloadMbps!.toStringAsFixed(1)
                : '—',
            unit: 'Мбит/с',
            icon: Icons.arrow_downward_rounded,
            iconColor: const Color(0xFF22C55E),
            isActive: state.phase == SpeedtestPhase.download,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildMetricTile(
            title: 'Upload',
            value: state.uploadMbps != null
                ? state.uploadMbps!.toStringAsFixed(1)
                : '—',
            unit: 'Мбит/с',
            icon: Icons.arrow_upward_rounded,
            iconColor: const Color(0xFF38BDF8),
            isActive: state.phase == SpeedtestPhase.upload,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricTile({
    required String title,
    required String value,
    required String unit,
    required IconData icon,
    required Color iconColor,
    required bool isActive,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF101614),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive
              ? iconColor.withValues(alpha: 0.5)
              : Colors.white.withValues(alpha: 0.08),
          width: isActive ? 1.5 : 1,
        ),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: iconColor.withValues(alpha: 0.15),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 14, color: iconColor),
              const SizedBox(width: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            unit,
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'monospace',
              color: Colors.white.withValues(alpha: 0.35),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    SpeedtestState state,
  ) {
    if (state.isRunning) {
      return SizedBox(
        width: double.infinity,
        height: 52,
        child: OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFFEF4444),
            side: const BorderSide(color: Color(0xFFEF4444), width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          onPressed: _cancelTest,
          icon: const Icon(Icons.stop_rounded),
          label: const Text(
            'Остановить',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    final isCompleted = state.phase == SpeedtestPhase.completed;
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF22C55E),
          foregroundColor: const Color(0xFF060A08),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: _startTest,
        icon: Icon(
          isCompleted ? Icons.replay_rounded : Icons.play_arrow_rounded,
          size: 22,
        ),
        label: Text(
          isCompleted ? 'Измерить ещё раз' : 'Запустить тест',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
