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
          // Opens PersonalAccountSheet or paste flow
          handleSubscriptionTap(context, ref);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppCorner.md),
                ),
                child: const Icon(
                  Icons.vpn_key_outlined,
                  size: 24,
                  color: Color(0xFF10B981),
                ),
              ),
              const SizedBox(width: 14),
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
                      style: textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF10B981),
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      appLocalizations.subscriptionFromClipboardHint,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant
                            .withValues(alpha: 0.7),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.add_circle_outline_rounded,
                color: Color(0xFF10B981),
                size: 22,
              ),
            ],
          ),
        ),
      );
    }

    final subscriptionInfo = currentProfile?.subscriptionInfo;

    String expireText;
    bool isExpired = false;
    if (subscriptionInfo != null && subscriptionInfo.expire > 0) {
      final expireDate =
          DateTime.fromMillisecondsSinceEpoch(subscriptionInfo.expire * 1000);
      final diff = expireDate.difference(DateTime.now());
      if (diff.isNegative) {
        expireText = '${appLocalizations.statusExpired} (${expireDate.show})';
        isExpired = true;
      } else if (diff.inDays > 0) {
        expireText = '${expireDate.show} (${diff.inDays} d.)';
      } else if (diff.inHours > 0) {
        expireText = '${expireDate.show} (${diff.inHours} h.)';
      } else {
        expireText = '< 1 h.';
      }
    } else {
      expireText = appLocalizations.noExpiration;
    }

    final total = subscriptionInfo?.total ?? 0;
    final used =
        (subscriptionInfo?.upload ?? 0) + (subscriptionInfo?.download ?? 0);
    final double progress = total > 0 ? (used / total).clamp(0.0, 1.0) : 0.0;
    final trafficText = total > 0
        ? '${used.traffic.show} / ${total.traffic.show}'
        : '${appLocalizations.dataUsed}: ${used.traffic.show}';

    return CommonCard(
      radius: AppCorner.lg,
      onPressed: () {
        // Opens PersonalAccountSheet modal
        showPersonalAccountSheet(context, currentProfile);
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
                        currentProfile?.label.isNotEmpty == true
                            ? '${currentProfile!.label} • $expireText'
                            : expireText,
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
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  appLocalizations.trafficUsage,
                  style: textTheme.bodySmall?.toLight,
                ),
                Text(
                  trafficText,
                  style: textTheme.bodySmall?.toSoftBold,
                ),
              ],
            ),
            if (total > 0) ...[
              const SizedBox(height: 6),
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
            ],
          ],
        ),
      ),
    );
  }
}
