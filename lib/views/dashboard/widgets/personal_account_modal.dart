import 'dart:async';
import 'package:flutter/services.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/pages/scan.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AddSubscriptionChoice { qrcode, url }

Future<void> showAddSubscriptionFlow(
  BuildContext context,
  WidgetRef ref, {
  bool replaceOld = false,
}) async {
  final parentContext = globalState.navigatorKey.currentContext ?? context;

  final choice = await showModalBottomSheet<AddSubscriptionChoice>(
    context: parentContext,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppCorner.xxl)),
    ),
    builder: (sheetContext) {
      final loc = sheetContext.appLocalizations;
      final colorScheme = Theme.of(sheetContext).colorScheme;
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8)
              .copyWith(bottom: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                loc.addSubscription,
                style: Theme.of(sheetContext).textTheme.titleLarge?.toBold,
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppCorner.lg),
                ),
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(AppCorner.md),
                  ),
                  child: Icon(
                    Icons.qr_code_scanner_rounded,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
                title: Text(
                  loc.qrcode,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(loc.qrcodeDesc),
                onTap: () {
                  Navigator.of(sheetContext).pop(AddSubscriptionChoice.qrcode);
                },
              ),
              const SizedBox(height: 8),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppCorner.lg),
                ),
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(AppCorner.md),
                  ),
                  child: Icon(
                    Icons.cloud_download_rounded,
                    color: colorScheme.onSecondaryContainer,
                  ),
                ),
                title: Text(
                  loc.url,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(loc.urlDesc),
                onTap: () {
                  Navigator.of(sheetContext).pop(AddSubscriptionChoice.url);
                },
              ),
            ],
          ),
        ),
      );
    },
  );

  if (choice == null) return;

  final activeContext = globalState.navigatorKey.currentContext ?? context;
  if (!activeContext.mounted) return;
  final profilesAction = ref.read(profilesActionProvider.notifier);

  if (choice == AddSubscriptionChoice.qrcode) {
    if (system.isDesktop) {
      unawaited(profilesAction.addProfileFormQrCode(replaceOld: replaceOld));
      return;
    }
    final url =
        await BaseNavigator.push<String>(activeContext, const ScanPage());
    if (url != null) {
      unawaited(profilesAction.addProfileFormURL(url, replaceOld: replaceOld));
    }
  } else if (choice == AddSubscriptionChoice.url) {
    if (!activeContext.mounted) return;
    final loc = activeContext.appLocalizations;
    final enteredUrl = await dialogs.showCommonDialog<String>(
      context: activeContext,
      child: InputDialog(
        autovalidateMode: AutovalidateMode.onUnfocus,
        title: loc.importFromURL,
        labelText: loc.url,
        value: '',
        inputFormatters: TextInputLimits.limit(TextInputLimits.url),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return loc.emptyTip('').trim();
          }
          if (!value.isUrl) {
            return loc.urlTip('').trim();
          }
          if (!isValidLieVpnSubscriptionUrl(value)) {
            return loc.notLieVpnSubscription;
          }
          return null;
        },
      ),
    );
    if (enteredUrl != null && enteredUrl.isNotEmpty) {
      unawaited(
          profilesAction.addProfileFormURL(enteredUrl, replaceOld: replaceOld));
    }
  }
}

Future<void> handleSubscriptionTap(
  BuildContext context,
  WidgetRef ref, {
  bool replaceOld = false,
}) async {
  final appLocalizations = context.appLocalizations;
  String clipboardText = '';
  try {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    clipboardText = data?.text ?? '';
  } catch (_) {}

  final detectedUrl = extractLieVpnUrl(clipboardText);
  if (detectedUrl != null) {
    dialogs.showNotifier(
      appLocalizations.subscriptionActivating,
      level: MessageLevel.info,
    );
    final success = await ref
        .read(profilesActionProvider.notifier)
        .addProfileFormURL(detectedUrl, replaceOld: replaceOld);
    if (success) {
      return;
    }
  }

  final activeContext = globalState.navigatorKey.currentContext ?? context;
  if (activeContext.mounted) {
    await showAddSubscriptionFlow(activeContext, ref, replaceOld: replaceOld);
  }
}

Future<String?> showPersonalAccountSheet(
  BuildContext context,
  Profile? profile,
) {
  return showModalBottomSheet<String>(
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
              color: (valueColor ?? colorScheme.primary).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppCorner.md),
            ),
            child: Icon(
              icon,
              size: 20,
              color: valueColor ?? colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profile = widget.profile;
    final appLocalizations = context.appLocalizations;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final sub = profile?.subscriptionInfo;
    final total = sub?.total ?? 0;
    final used = (sub?.upload ?? 0) + (sub?.download ?? 0);
    final hasExpire = sub != null && sub.expire > 0;
    final isExpired = isSubscriptionExpired(profile);

    String expireText = appLocalizations.noExpiration;
    if (hasExpire) {
      final date = DateTime.fromMillisecondsSinceEpoch(sub.expire * 1000);
      expireText = date.show;
    }

    final totalStr = total > 0 ? total.traffic.show : appLocalizations.unlimited;
    final usedStr = used.traffic.show;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8)
            .copyWith(bottom: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appLocalizations.personalAccount,
                      style: textTheme.titleLarge?.toBold,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      appLocalizations.userProfileHeader,
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant.opacity50,
                        letterSpacing: 1.2,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildInfoCard(
                    context: context,
                    label: appLocalizations.accountStatus,
                    value: isExpired
                        ? appLocalizations.statusExpired
                        : appLocalizations.statusActive,
                    icon: isExpired
                        ? Icons.warning_amber_rounded
                        : Icons.check_circle_outline,
                    valueColor: isExpired
                        ? colorScheme.error
                        : const Color(0xFF10B981),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildInfoCard(
                    context: context,
                    label: appLocalizations.expirationDate,
                    value: expireText,
                    icon: Icons.calendar_today_outlined,
                    valueColor: isExpired ? colorScheme.error : null,
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
                    label: appLocalizations.dataUsed,
                    value: usedStr,
                    icon: Icons.arrow_upward_rounded,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildInfoCard(
                    context: context,
                    label: appLocalizations.dataLimit,
                    value: totalStr,
                    icon: Icons.data_usage_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppCorner.lg),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop('change');
                    },
                    icon: const Icon(Icons.swap_horiz_rounded),
                    label: Text(appLocalizations.changeSubscription),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: const Color(0xFF10B981),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppCorner.lg),
                      ),
                    ),
                    onPressed: _isUpdating
                        ? null
                        : () async {
                            if (profile == null) return;
                            setState(() => _isUpdating = true);
                            try {
                              final changed = await ref
                                  .read(profilesActionProvider.notifier)
                                  .updateProfile(profile, force: true);
                              if (context.mounted) {
                                Navigator.of(context).pop();
                                dialogs.showNotifier(
                                  changed
                                      ? appLocalizations.subscriptionUpdated
                                      : appLocalizations.subscriptionNoChanges,
                                );
                              }
                            } finally {
                              if (mounted) setState(() => _isUpdating = false);
                            }
                          },
                    icon: _isUpdating
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.sync_rounded),
                    label: Text(appLocalizations.updateSubscription),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
