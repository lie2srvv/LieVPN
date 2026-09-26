import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/common/common.dart';
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
    final isVpnConnected = ref.read(isStartProvider);
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
    final isVpnConnected = ref.watch(isStartProvider);
    final appLocalizations = context.appLocalizations;
    final colorScheme = Theme.of(context).colorScheme;

    return CommonScaffold(
      title: appLocalizations.speedtest,
      body: SafeArea(
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
                    // Top VPN state indicator badge
                    _buildVpnBadge(context, isVpnConnected, colorScheme),
                    const SizedBox(height: 14),

                    // Center Speedometer Gauge
                    _buildSpeedometerSection(context, state, colorScheme),
                    const SizedBox(height: 24),

                    // 3 Metric Cards: Download -> Upload -> Ping
                    _buildMetricCards(context, state, colorScheme),
                    const SizedBox(height: 24),

                    // Action Button
                    _buildActionButton(context, state, colorScheme),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildVpnBadge(
    BuildContext context,
    bool isVpnConnected,
    ColorScheme colorScheme,
  ) {
    final appLocalizations = context.appLocalizations;
    final dotColor = isVpnConnected
        ? const Color(0xFF10B981)
        : colorScheme.onSurfaceVariant.withValues(alpha: 0.4);
    final borderColor = isVpnConnected
        ? const Color(0xFF10B981).withValues(alpha: 0.3)
        : colorScheme.outlineVariant.withValues(alpha: 0.3);
    final bgColor = isVpnConnected
        ? const Color(0xFF10B981).withValues(alpha: 0.1)
        : colorScheme.surfaceContainerHighest.withValues(alpha: 0.35);
    final labelText = isVpnConnected
        ? appLocalizations.vpnConnected
        : appLocalizations.vpnDisconnected;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppCorner.full),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
              boxShadow: isVpnConnected
                  ? [
                      BoxShadow(
                        color: dotColor.withValues(alpha: 0.8),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ]
                  : null,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            labelText,
            style: TextStyle(
              color: isVpnConnected ? const Color(0xFF10B981) : colorScheme.onSurfaceVariant,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpeedometerSection(
    BuildContext context,
    SpeedtestState state,
    ColorScheme colorScheme,
  ) {
    final appLocalizations = context.appLocalizations;
    final double targetSpeed =
        state.phase == SpeedtestPhase.ping ? 0.0 : state.currentSpeedMbps;

    String statusText = appLocalizations.readyToTest;
    Color statusColor = colorScheme.onSurfaceVariant;

    switch (state.phase) {
      case SpeedtestPhase.idle:
        statusText = appLocalizations.readyToTest;
        statusColor = colorScheme.onSurfaceVariant;
        break;
      case SpeedtestPhase.download:
        statusText = appLocalizations.speedtestTestingDownload;
        statusColor = colorScheme.primary;
        break;
      case SpeedtestPhase.upload:
        statusText = appLocalizations.speedtestTestingUpload;
        statusColor = colorScheme.tertiary;
        break;
      case SpeedtestPhase.ping:
        statusText = appLocalizations.speedtestTestingPing;
        statusColor = const Color(0xFFF59E0B);
        break;
      case SpeedtestPhase.completed:
        statusText = appLocalizations.speedtestCompleted;
        statusColor = const Color(0xFF10B981);
        break;
      case SpeedtestPhase.error:
        statusText = state.errorMessage ?? appLocalizations.speedtestError;
        statusColor = colorScheme.error;
        break;
    }

    return Column(
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: targetSpeed),
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          builder: (context, animatedSpeed, child) {
            return SizedBox(
              width: 280,
              height: 250,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    size: const Size(280, 250),
                    painter: _SpeedGaugePainter(
                      speedMbps: animatedSpeed,
                      isActive: state.isRunning,
                      colorScheme: colorScheme,
                    ),
                  ),
                  Positioned(
                    bottom: 45,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          animatedSpeed > 0.0
                              ? animatedSpeed.toStringAsFixed(1)
                              : (state.downloadMbps != null &&
                                      state.phase == SpeedtestPhase.completed
                                  ? state.downloadMbps!.toStringAsFixed(1)
                                  : '0.0'),
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                            letterSpacing: -1.5,
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                        Text(
                          appLocalizations.speedtestGaugeUnit,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        Text(
          statusText,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: statusColor,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildMetricCards(
    BuildContext context,
    SpeedtestState state,
    ColorScheme colorScheme,
  ) {
    final appLocalizations = context.appLocalizations;
    return Row(
      children: [
        // 1. Download
        Expanded(
          child: _buildMetricTile(
            colorScheme: colorScheme,
            title: appLocalizations.speedtestDownload,
            value: state.downloadMbps != null
                ? state.downloadMbps!.toStringAsFixed(1)
                : '—',
            unit: appLocalizations.speedtestUnitMbps,
            icon: Icons.arrow_downward_rounded,
            iconColor: colorScheme.primary,
            isActive: state.phase == SpeedtestPhase.download,
          ),
        ),
        const SizedBox(width: 8),

        // 2. Upload
        Expanded(
          child: _buildMetricTile(
            colorScheme: colorScheme,
            title: appLocalizations.speedtestUpload,
            value: state.uploadMbps != null
                ? state.uploadMbps!.toStringAsFixed(1)
                : '—',
            unit: appLocalizations.speedtestUnitMbps,
            icon: Icons.arrow_upward_rounded,
            iconColor: colorScheme.tertiary,
            isActive: state.phase == SpeedtestPhase.upload,
          ),
        ),
        const SizedBox(width: 8),

        // 3. Ping
        Expanded(
          child: _buildMetricTile(
            colorScheme: colorScheme,
            title: appLocalizations.speedtestPing,
            value: state.pingMs != null ? '${state.pingMs}' : '—',
            unit: appLocalizations.speedtestUnitMs,
            icon: Icons.timer_outlined,
            iconColor: const Color(0xFFF59E0B),
            isActive: state.phase == SpeedtestPhase.ping,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricTile({
    required ColorScheme colorScheme,
    required String title,
    required String value,
    required String unit,
    required IconData icon,
    required Color iconColor,
    required bool isActive,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(AppCorner.lg),
        border: Border.all(
          color: isActive
              ? iconColor.withValues(alpha: 0.6)
              : colorScheme.outlineVariant.withValues(alpha: 0.25),
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
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          const SizedBox(height: 2),
          Text(
            unit,
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'monospace',
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    SpeedtestState state,
    ColorScheme colorScheme,
  ) {
    final appLocalizations = context.appLocalizations;
    if (state.isRunning) {
      return SizedBox(
        width: double.infinity,
        height: 52,
        child: OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            foregroundColor: colorScheme.error,
            side: BorderSide(color: colorScheme.error, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppCorner.md),
            ),
          ),
          onPressed: _cancelTest,
          icon: const Icon(Icons.stop_rounded),
          label: Text(
            appLocalizations.speedtestStop,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppCorner.md),
          ),
        ),
        onPressed: _startTest,
        icon: Icon(
          isCompleted ? Icons.replay_rounded : Icons.play_arrow_rounded,
          size: 22,
        ),
        label: Text(
          isCompleted ? appLocalizations.speedtestRunAgain : appLocalizations.speedtestStart,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// ========================================================
// CUSTOM SPEEDOMETER GAUGE PAINTER
// ========================================================
class _SpeedGaugePainter extends CustomPainter {
  final double speedMbps;
  final bool isActive;
  final ColorScheme colorScheme;

  _SpeedGaugePainter({
    required this.speedMbps,
    required this.isActive,
    required this.colorScheme,
  });

  // Map speed from 0 to 500+ Mbps dynamically across the arc
  double _speedToFraction(double mbps) {
    if (mbps <= 0.0) return 0.0;
    if (mbps >= 500.0) return 1.0;
    if (mbps <= 10.0) return (mbps / 10.0) * 0.22;
    if (mbps <= 50.0) return 0.22 + ((mbps - 10.0) / 40.0) * 0.26;
    if (mbps <= 100.0) return 0.48 + ((mbps - 50.0) / 50.0) * 0.22;
    if (mbps <= 250.0) return 0.70 + ((mbps - 100.0) / 150.0) * 0.18;
    return 0.88 + ((mbps - 250.0) / 250.0) * 0.12;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.58);
    final radius = size.width * 0.42;

    const startAngle = 145.0 * (math.pi / 180.0);
    const sweepAngle = 250.0 * (math.pi / 180.0);

    // 1. Background Arc Track
    final bgPaint = Paint()
      ..color = colorScheme.outlineVariant.withValues(alpha: 0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(rect, startAngle, sweepAngle, false, bgPaint);

    // 2. Scale Ticks & Labels (0, 10, 50, 100, 250, 500)
    final List<int> scaleValues = [0, 10, 50, 100, 250, 500];
    final tickPaint = Paint()
      ..color = colorScheme.outlineVariant.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    for (final val in scaleValues) {
      final frac = _speedToFraction(val.toDouble());
      final angle = startAngle + frac * sweepAngle;

      final p1 = Offset(
        center.dx + (radius + 8) * math.cos(angle),
        center.dy + (radius + 8) * math.sin(angle),
      );
      final p2 = Offset(
        center.dx + (radius + 16) * math.cos(angle),
        center.dy + (radius + 16) * math.sin(angle),
      );
      canvas.drawLine(p1, p2, tickPaint);

      // Label text
      final textSpan = TextSpan(
        text: val.toString(),
        style: TextStyle(
          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
          fontSize: 10,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w600,
        ),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final labelRadius = radius + 25;
      final labelX = center.dx + labelRadius * math.cos(angle) - (textPainter.width / 2);
      final labelY = center.dy + labelRadius * math.sin(angle) - (textPainter.height / 2);
      textPainter.paint(canvas, Offset(labelX, labelY));
    }

    // Minor ticks between markers
    final minorTickPaint = Paint()
      ..color = colorScheme.outlineVariant.withValues(alpha: 0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (int i = 0; i <= 30; i++) {
      final frac = i / 30.0;
      final angle = startAngle + frac * sweepAngle;
      final p1 = Offset(
        center.dx + (radius + 8) * math.cos(angle),
        center.dy + (radius + 8) * math.sin(angle),
      );
      final p2 = Offset(
        center.dx + (radius + 12) * math.cos(angle),
        center.dy + (radius + 12) * math.sin(angle),
      );
      canvas.drawLine(p1, p2, minorTickPaint);
    }

    // 3. Active Velocity Arc
    final currentFraction = _speedToFraction(speedMbps).clamp(0.0, 1.0);
    if (currentFraction > 0.001) {
      final activeSweep = sweepAngle * currentFraction;

      final gradientPaint = Paint()
        ..shader = SweepGradient(
          startAngle: startAngle,
          endAngle: startAngle + sweepAngle,
          colors: [
            colorScheme.primary.withValues(alpha: 0.5),
            colorScheme.primary,
            colorScheme.secondary,
            colorScheme.tertiary,
          ],
        ).createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(rect, startAngle, activeSweep, false, gradientPaint);

      // Glowing dot at the needle head of the active arc
      final tipAngle = startAngle + activeSweep;
      final tipOffset = Offset(
        center.dx + radius * math.cos(tipAngle),
        center.dy + radius * math.sin(tipAngle),
      );

      final glowPaint = Paint()
        ..color = colorScheme.primary.withValues(alpha: 0.6)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
      canvas.drawCircle(tipOffset, 8, glowPaint);

      final dotPaint = Paint()
        ..color = colorScheme.primary
        ..style = PaintingStyle.fill;
      canvas.drawCircle(tipOffset, 5, dotPaint);
    }

    // 4. Center Needle Pointer
    final needleAngle = startAngle + currentFraction * sweepAngle;
    final needleTip = Offset(
      center.dx + (radius - 16) * math.cos(needleAngle),
      center.dy + (radius - 16) * math.sin(needleAngle),
    );
    final needleBaseLeft = Offset(
      center.dx + 6 * math.cos(needleAngle - math.pi / 2),
      center.dy + 6 * math.sin(needleAngle - math.pi / 2),
    );
    final needleBaseRight = Offset(
      center.dx + 6 * math.cos(needleAngle + math.pi / 2),
      center.dy + 6 * math.sin(needleAngle + math.pi / 2),
    );

    final needlePath = Path()
      ..moveTo(needleBaseLeft.dx, needleBaseLeft.dy)
      ..lineTo(needleTip.dx, needleTip.dy)
      ..lineTo(needleBaseRight.dx, needleBaseRight.dy)
      ..close();

    final needlePaint = Paint()
      ..color = isActive
          ? colorScheme.primary
          : colorScheme.onSurfaceVariant.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;
    canvas.drawPath(needlePath, needlePaint);

    // Center Hub Pivot
    final hubPaint = Paint()
      ..color = colorScheme.surfaceContainerHighest
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 9, hubPaint);

    final hubRingPaint = Paint()
      ..color = isActive
          ? colorScheme.primary
          : colorScheme.outlineVariant.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawCircle(center, 9, hubRingPaint);
  }

  @override
  bool shouldRepaint(covariant _SpeedGaugePainter oldDelegate) {
    return oldDelegate.speedMbps != speedMbps ||
        oldDelegate.isActive != isActive ||
        oldDelegate.colorScheme != colorScheme;
  }
}
