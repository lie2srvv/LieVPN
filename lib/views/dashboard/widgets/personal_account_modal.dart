import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void showPersonalAccountSheet(BuildContext context, Profile? profile) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppCorner.xxl)),
    ),
    builder: (_) => PersonalAccountSheet(profile: profile),
  );
}

class PersonalAccountSheet extends ConsumerStatefulWidget {
  final Profile? profile;

  const PersonalAccountSheet({super.key, this.profile});

  @override
  ConsumerState<PersonalAccountSheet> createState() =>
      _PersonalAccountSheetState();
}

class _PersonalAccountSheetState extends ConsumerState<PersonalAccountSheet> {
  bool _isUpdating = false;

  Widget _buildInfoCard({
    required BuildContext context,
    required String label,
    required String value,
    required IconData icon,
    Color? valueColor,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppCorner.lg),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: textTheme.labelSmall?.copyWith(
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: valueColor ?? colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppCorner.md),
            ),
            child: Icon(
              icon,
              size: 20,
              color: const Color(0xFF10B981),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleUpdate(Profile? profile) async {
    if (profile == null || _isUpdating) return;
    setState(() {
      _isUpdating = true;
    });
    try {
      final isChanged = await ref
          .read(profilesActionProvider.notifier)
          .updateProfile(profile, showLoading: true, force: true);
      if (mounted) {
        final loc = context.appLocalizations;
        dialogs.showNotifier(
          isChanged ? loc.subscriptionUpdated : loc.subscriptionNoChanges,
          level: MessageLevel.info,
        );
      }
    } catch (e) {
      if (mounted) {
        dialogs.showNotifier(e.toString(), level: MessageLevel.error);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUpdating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentProfile = ref.watch(currentProfileProvider) ?? widget.profile;
    final info = currentProfile?.subscriptionInfo;
    final appLocalizations = context.appLocalizations;

    final isExpired = info != null &&
        info.expire > 0 &&
        DateTime.fromMillisecondsSinceEpoch(info.expire * 1000)
            .isBefore(DateTime.now());

    final userName = (currentProfile?.label.isNotEmpty == true)
        ? currentProfile!.label
        : 'LieVPN';

    final total = info?.total ?? 0;
    final used = (info?.upload ?? 0) + (info?.download ?? 0);
    final limitText = total > 0 ? total.traffic.show : appLocalizations.unlimited;
    final usedText = used.traffic.show;

    final expireText = (info != null && info.expire > 0)
        ? DateTime.fromMillisecondsSinceEpoch(info.expire * 1000).show
        : appLocalizations.noExpiration;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12)
            .copyWith(bottom: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appLocalizations.userProfileHeader,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF10B981),
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 500;
                if (isWide) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildInfoCard(
                              context: context,
                              label: appLocalizations.accountUsername,
                              value: userName,
                              icon: Icons.person,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildInfoCard(
                              context: context,
                              label: appLocalizations.accountStatus,
                              value: isExpired
                                  ? '🔴 ${appLocalizations.statusExpired}'
                                  : '🟢 ${appLocalizations.statusActive}',
                              icon: Icons.shield_outlined,
                              valueColor: isExpired
                                  ? Colors.redAccent
                                  : const Color(0xFF10B981),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildInfoCard(
                              context: context,
                              label: appLocalizations.dataLimit,
                              value: limitText,
                              icon: Icons.storage_rounded,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildInfoCard(
                              context: context,
                              label: appLocalizations.dataUsed,
                              value: usedText,
                              icon: Icons.pie_chart_outline_rounded,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildInfoCard(
                        context: context,
                        label: appLocalizations.expirationDate,
                        value: expireText,
                        icon: Icons.calendar_today_rounded,
                      ),
                    ],
                  );
                }
                return Column(
                  children: [
                    _buildInfoCard(
                      context: context,
                      label: appLocalizations.accountUsername,
                      value: userName,
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 10),
                    _buildInfoCard(
                      context: context,
                      label: appLocalizations.accountStatus,
                      value: isExpired
                          ? '🔴 ${appLocalizations.statusExpired}'
                          : '🟢 ${appLocalizations.statusActive}',
                      icon: Icons.shield_outlined,
                      valueColor: isExpired
                          ? Colors.redAccent
                          : const Color(0xFF10B981),
                    ),
                    const SizedBox(height: 10),
                    _buildInfoCard(
                      context: context,
                      label: appLocalizations.dataLimit,
                      value: limitText,
                      icon: Icons.storage_rounded,
                    ),
                    const SizedBox(height: 10),
                    _buildInfoCard(
                      context: context,
                      label: appLocalizations.dataUsed,
                      value: usedText,
                      icon: Icons.pie_chart_outline_rounded,
                    ),
                    const SizedBox(height: 10),
                    _buildInfoCard(
                      context: context,
                      label: appLocalizations.expirationDate,
                      value: expireText,
                      icon: Icons.calendar_today_rounded,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton.icon(
                onPressed: _isUpdating ? null : () => _handleUpdate(currentProfile),
                icon: _isUpdating
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.refresh_rounded),
                label: Text(appLocalizations.updateSubscription),
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppCorner.md),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
