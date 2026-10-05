import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/views/dashboard/widgets/personal_account_modal.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class SubscriptionStatusCard extends ConsumerWidget {
  const SubscriptionStatusCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentProfile = ref.watch(currentProfileProvider);
    final hasSubscription = isLieVpnSubscription(currentProfile);
    final appLocalizations = context.appLocalizations;
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    if (!hasSubscription) {
      return CommonCard(
        radius: AppCorner.lg,
        onPressed: () {
          handleSubscriptionTap(context, ref, replaceOld: true);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(AppCorner.md),
                    ),
                    child: const Icon(
                      Icons.shield_outlined,
                      size: 22,
                      color: Color(0xFF10B981),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appLocalizations.personalAccount,
                          style: textTheme.titleMedium?.toBold,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          appLocalizations.tapToInsertSubscription,
                          style: textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF10B981),
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: colorScheme.onSurfaceVariant.opacity50,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                appLocalizations.subscriptionFromClipboardHint,
                style: textTheme.bodySmall?.toLight,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
    }

    final subscriptionInfo = currentProfile?.subscriptionInfo;
    final expiryStatus = getSubscriptionExpiryStatus(currentProfile);
    final isExpired = expiryStatus.isExpired;

    final hasExpire = subscriptionInfo != null && subscriptionInfo.expire > 0;
    String expireText = '';
    if (hasExpire) {
      final expireDate =
          DateTime.fromMillisecondsSinceEpoch(subscriptionInfo.expire * 1000);
      final diff = expireDate.difference(DateTime.now());
      if (diff.isNegative) {
        expireText = '${appLocalizations.statusExpired} (${expireDate.show})';
      } else if (diff.inDays > 0) {
        expireText = '${expireDate.show} (${diff.inDays} d.)';
      } else if (diff.inHours > 0) {
        expireText = '${expireDate.show} (${diff.inHours} h.)';
      } else {
        expireText = '< 1 h.';
      }
    }

    final total = subscriptionInfo?.total ?? 0;
    final used =
        (subscriptionInfo?.upload ?? 0) + (subscriptionInfo?.download ?? 0);
    final double progress = total > 0 ? (used / total).clamp(0.0, 1.0) : 0.0;

    final subtitleText = currentProfile?.label.isNotEmpty == true
        ? (hasExpire
            ? '${currentProfile!.label} • $expireText'
            : currentProfile!.label)
        : (hasExpire ? expireText : 'LieVPN');

    return CommonCard(
      radius: AppCorner.lg,
      onPressed: () async {
        final result = await showPersonalAccountSheet(context, currentProfile);
        if (result == 'change' && context.mounted) {
          await showAddSubscriptionFlow(context, ref, replaceOld: true);
        } else if (result == 'add' && context.mounted) {
          await handleSubscriptionTap(context, ref, replaceOld: true);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isExpired
                        ? colorScheme.errorContainer
                        : const Color(0xFF10B981).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppCorner.md),
                  ),
                  child: Icon(
                    isExpired
                        ? Icons.warning_amber_rounded
                        : Icons.shield_outlined,
                    size: 22,
                    color: isExpired
                        ? colorScheme.error
                        : const Color(0xFF10B981),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appLocalizations.personalAccount,
                        style: textTheme.titleMedium?.toBold,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitleText,
                        style: textTheme.bodyMedium?.copyWith(
                          color: isExpired
                              ? colorScheme.error
                              : colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: colorScheme.onSurfaceVariant.opacity50,
                ),
              ],
            ),
            if (expiryStatus.isExpiringSoon || isExpired) ...[
              const SizedBox(height: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: isExpired
                      ? colorScheme.errorContainer.withValues(alpha: 0.35)
                      : Colors.amber.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppCorner.md),
                  border: Border.all(
                    color: isExpired
                        ? colorScheme.error.withValues(alpha: 0.3)
                        : Colors.amber.withValues(alpha: 0.35),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      isExpired
                          ? Icons.warning_amber_rounded
                          : Icons.access_time_rounded,
                      size: 16,
                      color: isExpired
                          ? colorScheme.error
                          : Colors.amber.shade700,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        expiryStatus.dynamicWarningText,
                        style: textTheme.bodySmall?.copyWith(
                          color: isExpired
                              ? colorScheme.error
                              : (Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.amber.shade300
                                  : Colors.amber.shade900),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    InkWell(
                      onTap: () =>
                          dialogs.openUrl('https://t.me/liesubbot'),
                      borderRadius: BorderRadius.circular(AppCorner.sm),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        child: Text(
                          'Продлить',
                          style: textTheme.labelSmall?.copyWith(
                            color: isExpired
                                ? colorScheme.error
                                : const Color(0xFF10B981),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (total > 0) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppCorner.xs),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 5,
                  backgroundColor: colorScheme.primary.opacity15,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isExpired ? colorScheme.error : const Color(0xFF10B981),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${used.traffic.show} / ${total.traffic.show}',
                  style: textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ] else if (used > 0) ...[
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  used.traffic.show,
                  style: textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
