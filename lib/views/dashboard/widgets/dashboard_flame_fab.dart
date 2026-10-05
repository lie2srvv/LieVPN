import 'dart:async';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/manager/streak_manager.dart';
import 'package:fl_clash/views/dashboard/widgets/start_button.dart';
import 'package:flutter/material.dart';

class DashboardFlameFab extends StatefulWidget {
  const DashboardFlameFab({super.key});

  static void showStreakSheet(BuildContext context, StreakState state) {
    _DashboardFlameFabState.showStreakSheet(context, state);
  }

  @override
  State<DashboardFlameFab> createState() => _DashboardFlameFabState();
}

class _DashboardFlameFabState extends State<DashboardFlameFab>
    with SingleTickerProviderStateMixin {
  Timer? _milestoneDismissTimer;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.94, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    StreakManager.instance.pendingMilestoneNotifier.addListener(
      _onMilestoneChanged,
    );
  }

  @override
  void dispose() {
    _milestoneDismissTimer?.cancel();
    StreakManager.instance.pendingMilestoneNotifier.removeListener(
      _onMilestoneChanged,
    );
    _pulseController.dispose();
    super.dispose();
  }

  void _onMilestoneChanged() {
    final milestone = StreakManager.instance.pendingMilestoneNotifier.value;
    if (milestone != null) {
      _milestoneDismissTimer?.cancel();
      _milestoneDismissTimer = Timer(const Duration(seconds: 10), () {
        if (mounted) {
          StreakManager.instance.dismissMilestone(milestone);
        }
      });
    }
  }

  static void showStreakSheet(BuildContext context, StreakState state) {
    final l = context.appLocalizations;
    final colorScheme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return ValueListenableBuilder<StreakState>(
          valueListenable: StreakManager.instance.streakNotifier,
          builder: (_, currentState, _) {
            final isActive = currentState.isActiveToday;
            final count = currentState.count;
            final restoresLeft = 3 - currentState.restoresUsedThisMonth;

            return Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.18),
                    blurRadius: 20,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Handle
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: colorScheme.onSurfaceVariant.withValues(
                          alpha: 0.4,
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Big Flame with Day Count
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Outer glow
                          if (isActive)
                            Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFFFF5722,
                                    ).withValues(alpha: 0.35),
                                    blurRadius: 36,
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                            ),
                          // Big Flame Icon
                          Icon(
                            Icons.local_fire_department_rounded,
                            size: 110,
                            color: isActive
                                ? const Color(0xFFFF4500)
                                : colorScheme.onSurfaceVariant.withValues(
                                    alpha: 0.35,
                                  ),
                          ),
                          // Number in the flame center
                          Positioned(
                            bottom: 24,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: isActive
                                    ? Colors.black.withValues(alpha: 0.7)
                                    : colorScheme.surface.withValues(
                                        alpha: 0.85,
                                      ),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isActive
                                      ? const Color(0xFFFFD54F)
                                      : colorScheme.outline.withValues(
                                          alpha: 0.4,
                                        ),
                                  width: 1.5,
                                ),
                              ),
                              child: Text(
                                '$count',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                  color: isActive
                                      ? const Color(0xFFFFEB3B)
                                      : colorScheme.onSurfaceVariant,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Title
                    Text(
                      l.streakFlameTitle,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),

                    // Status line
                    Text(
                      isActive ? l.streakActiveToday : l.streakInactiveToday,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: isActive ? Colors.green : colorScheme.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    // Restore Button if eligible
                    if (currentState.canRestore) ...[
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF5722),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        icon: const Icon(Icons.restart_alt_rounded),
                        label: Text(
                          l.streakRestoreButton,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () async {
                          final success = await StreakManager.instance
                              .restoreStreak();
                          if (ctx.mounted) {
                            if (success) {
                              ScaffoldMessenger.of(ctx).showSnackBar(
                                SnackBar(
                                  content: Text(l.streakRestoredSuccess),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(ctx).showSnackBar(
                                SnackBar(
                                  content: Text(l.streakNoRestoresLeft),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ],

                    const SizedBox(height: 8),
                    Text(
                      l.streakRestoresLeft(restoresLeft),
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurfaceVariant.withValues(
                          alpha: 0.7,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 12),

                    // Rules Box
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        l.streakRuleTitle,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _RuleLine(text: l.streakRuleTime),
                    const SizedBox(height: 6),
                    _RuleLine(text: l.streakRuleStorage),
                    const SizedBox(height: 6),
                    _RuleLine(text: l.streakRuleRestore),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<StreakState>(
      valueListenable: StreakManager.instance.streakNotifier,
      builder: (context, streakState, _) {
        final isActive = streakState.isActiveToday;
        final count = streakState.count;
        final colorScheme = Theme.of(context).colorScheme;

        return ValueListenableBuilder<int?>(
          valueListenable: StreakManager.instance.pendingMilestoneNotifier,
          builder: (context, milestone, _) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Milestone congratulation banner floating right above flame
                if (milestone != null) ...[
                  Container(
                    margin: const EdgeInsets.only(bottom: 10, right: 60),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF5722), Color(0xFFFF9800)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF5722).withValues(alpha: 0.4),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('🎉 ', style: TextStyle(fontSize: 16)),
                        Text(
                          context.appLocalizations.streakMilestoneCongrats(
                            milestone,
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            StreakManager.instance.dismissMilestone(milestone);
                          },
                          child: const Icon(
                            Icons.close_rounded,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                // Row with Flame widget and StartButton
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Flame widget
                    GestureDetector(
                      onTap: () => showStreakSheet(context, streakState),
                      child: Container(
                        height: 56,
                        margin: const EdgeInsets.only(right: 18), // ~0.5 cm
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isActive
                              ? const Color(0xFF2C150A)
                              : colorScheme.surfaceContainerHighest.withValues(
                                  alpha: 0.8,
                                ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isActive
                                ? const Color(0xFFFF5722).withValues(alpha: 0.8)
                                : colorScheme.outline.withValues(alpha: 0.2),
                            width: isActive ? 1.8 : 1.0,
                          ),
                          boxShadow: isActive
                              ? [
                                  BoxShadow(
                                    color: const Color(
                                      0xFFFF5722,
                                    ).withValues(alpha: 0.35),
                                    blurRadius: 12,
                                    spreadRadius: 1,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Count text
                            Text(
                              '$count',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: isActive
                                    ? const Color(0xFFFFB74D)
                                    : colorScheme.onSurfaceVariant.withValues(
                                        alpha: 0.6,
                                      ),
                                letterSpacing: -0.2,
                              ),
                            ),
                            const SizedBox(width: 4),
                            // Flame icon with gentle pulse when active
                            if (isActive)
                              ScaleTransition(
                                scale: _pulseAnimation,
                                child: const Icon(
                                  Icons.local_fire_department_rounded,
                                  color: Color(0xFFFF3D00),
                                  size: 26,
                                ),
                              )
                            else
                              Icon(
                                Icons.local_fire_department_rounded,
                                color: colorScheme.onSurfaceVariant.withValues(
                                  alpha: 0.4,
                                ),
                                size: 26,
                              ),
                          ],
                        ),
                      ),
                    ),

                    // Start button itself
                    const StartButton(),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _RuleLine extends StatelessWidget {
  final String text;
  const _RuleLine({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        height: 1.35,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}

class StreakFlameDockButton extends StatefulWidget {
  const StreakFlameDockButton({super.key});

  @override
  State<StreakFlameDockButton> createState() => _StreakFlameDockButtonState();
}

class _StreakFlameDockButtonState extends State<StreakFlameDockButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.94, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<StreakState>(
      valueListenable: StreakManager.instance.streakNotifier,
      builder: (context, streakState, _) {
        final isActive = streakState.isActiveToday;
        final count = streakState.count;
        final colorScheme = Theme.of(context).colorScheme;

        return Material(
          color: isActive
              ? const Color(0xFF2C150A)
              : colorScheme.surfaceContainer,
          shape: AppShape.md,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () =>
                DashboardFlameFab.showStreakSheet(context, streakState),
            child: SizedBox(
              height: 56,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$count',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: isActive
                            ? const Color(0xFFFFB74D)
                            : colorScheme.onSurfaceVariant.withValues(
                                alpha: 0.7,
                              ),
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(width: 4),
                    if (isActive)
                      ScaleTransition(
                        scale: _pulseAnimation,
                        child: const Icon(
                          Icons.local_fire_department_rounded,
                          color: Color(0xFFFF3D00),
                          size: 26,
                        ),
                      )
                    else
                      Icon(
                        Icons.local_fire_department_rounded,
                        color: colorScheme.onSurfaceVariant.withValues(
                          alpha: 0.4,
                        ),
                        size: 26,
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
