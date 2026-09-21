import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/views/profiles/profiles.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class SubscriptionStatusCard extends ConsumerWidget {
  const SubscriptionStatusCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentProfile = ref.watch(currentProfileProvider);
    final subscriptionInfo = currentProfile?.subscriptionInfo;

    String expireText;
    bool isExpired = false;
    if (subscriptionInfo != null && subscriptionInfo.expire > 0) {
      final expireDate =
          DateTime.fromMillisecondsSinceEpoch(subscriptionInfo.expire * 1000);
      final diff = expireDate.difference(DateTime.now());
      if (diff.isNegative) {
        expireText = 'Истекла (${expireDate.show})';
        isExpired = true;
      } else if (diff.inDays > 0) {
        expireText = 'Осталось: ${diff.inDays} дн. (до ${expireDate.show})';
      } else if (diff.inHours > 0) {
        expireText = 'Осталось: ${diff.inHours} ч. (до ${expireDate.show})';
      } else {
        expireText = 'Осталось менее часа';
      }
    } else {
      expireText = 'Без ограничений по времени';
    }

    final total = subscriptionInfo?.total ?? 0;
    final used = (subscriptionInfo?.upload ?? 0) + (subscriptionInfo?.download ?? 0);
    final double progress = total > 0 ? (used / total).clamp(0.0, 1.0) : 0.0;
    final trafficText = total > 0
        ? '${used.traffic.show} / ${total.traffic.show}'
        : 'Трафик: без ограничений';

    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    return CommonCard(
      radius: AppCorner.lg,
      onPressed: () {
        if (currentProfile != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const ProfilesView(),
            ),
          );
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
                        : colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    isExpired
                        ? Icons.warning_amber_rounded
                        : Icons.verified_user_rounded,
                    size: 22,
                    color: isExpired
                        ? colorScheme.error
                        : colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentProfile?.label.isNotEmpty == true
                            ? currentProfile!.label
                            : 'Подписка LieVPN',
                        style: textTheme.titleMedium?.toBold,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        expireText,
                        style: textTheme.bodyMedium?.copyWith(
                          color: isExpired
                              ? colorScheme.error
                              : colorScheme.primary,
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
            if (total > 0) ...[
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Трафик',
                    style: textTheme.bodySmall?.toLight,
                  ),
                  Text(
                    trafficText,
                    style: textTheme.bodySmall?.toSoftBold,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 5,
                  backgroundColor: colorScheme.primary.opacity15,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
