import 'dart:async';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/pages/scan.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class SubscriptionLockView extends ConsumerStatefulWidget {
  const SubscriptionLockView({super.key});

  @override
  ConsumerState<SubscriptionLockView> createState() =>
      _SubscriptionLockViewState();
}

class _SubscriptionLockViewState extends ConsumerState<SubscriptionLockView>
    with WidgetsBindingObserver {
  String? _lastAttemptedClipboard;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _disconnectIfRunning();
      _checkClipboard(isAuto: true);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkClipboard(isAuto: true);
    }
  }

  void _disconnectIfRunning() {
    final coreStatus = ref.read(coreStatusProvider);
    if (coreStatus != CoreStatus.disconnected) {
      ref.read(setupActionProvider.notifier).setRunning(false);
    }
  }

  Future<void> _checkClipboard({bool isAuto = false}) async {
    if (_isProcessing || !mounted) return;
    String clipboardText = '';
    try {
      final data = await Clipboard.getData(Clipboard.kTextPlain);
      clipboardText = data?.text?.trim() ?? '';
    } catch (_) {}

    if (clipboardText.isEmpty) return;
    final detectedUrl = extractLieVpnUrl(clipboardText);
    if (detectedUrl == null) return;

    if (isAuto && detectedUrl == _lastAttemptedClipboard) {
      return;
    }

    _lastAttemptedClipboard = detectedUrl;
    await _activateUrl(detectedUrl, fromClipboard: true);
  }

  Future<void> _activateUrl(String url, {bool fromClipboard = false}) async {
    if (_isProcessing || !mounted) return;
    setState(() => _isProcessing = true);
    final loc = context.appLocalizations;

    try {
      if (fromClipboard) {
        dialogs.showNotifier(
          loc.subscriptionActivating,
          level: MessageLevel.info,
        );
      }
      final success = await ref
          .read(profilesActionProvider.notifier)
          .addProfileFormURL(url, replaceOld: true);

      if (!success && mounted) {
        dialogs.showNotifier(
          loc.subscriptionInvalidOrEmpty,
          level: MessageLevel.error,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  Future<void> _handleUrlTap() async {
    if (_isProcessing || !mounted) return;

    String clipboardText = '';
    try {
      final data = await Clipboard.getData(Clipboard.kTextPlain);
      clipboardText = data?.text?.trim() ?? '';
    } catch (_) {}

    final detectedUrl = extractLieVpnUrl(clipboardText);
    if (detectedUrl != null && mounted) {
      await _activateUrl(detectedUrl, fromClipboard: true);
      return;
    }

    if (!mounted) return;
    final loc = context.appLocalizations;
    final enteredUrl = await dialogs.showCommonDialog<String>(
      context: context,
      child: InputDialog(
        autovalidateMode: AutovalidateMode.onUnfocus,
        title: loc.enterSubscriptionUrl,
        labelText: loc.url,
        value: '',
        inputFormatters: TextInputLimits.limit(TextInputLimits.url),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
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

    if (enteredUrl != null && enteredUrl.trim().isNotEmpty && mounted) {
      await _activateUrl(enteredUrl.trim(), fromClipboard: false);
    }
  }

  Future<void> _handleQrTap() async {
    if (_isProcessing || !mounted) return;
    final profilesAction = ref.read(profilesActionProvider.notifier);

    if (system.isDesktop) {
      setState(() => _isProcessing = true);
      try {
        final success =
            await profilesAction.addProfileFormQrCode(replaceOld: true);
        if (!success && mounted) {
          final loc = context.appLocalizations;
          dialogs.showNotifier(
            loc.subscriptionInvalidOrEmpty,
            level: MessageLevel.error,
          );
        }
      } finally {
        if (mounted) setState(() => _isProcessing = false);
      }
      return;
    }

    final url = await BaseNavigator.push<String>(context, const ScanPage());
    if (url != null && url.isNotEmpty && mounted) {
      await _activateUrl(url, fromClipboard: false);
    }
  }

  Future<void> _handleRefreshExisting(Profile profile) async {
    if (_isProcessing || !mounted) return;
    setState(() => _isProcessing = true);
    final loc = context.appLocalizations;
    try {
      final changed = await ref
          .read(profilesActionProvider.notifier)
          .updateProfile(profile, force: true, showLoading: true);
      if (mounted) {
        dialogs.showNotifier(
          changed ? loc.subscriptionUpdated : loc.subscriptionNoChanges,
          level: MessageLevel.info,
        );
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  Future<void> _openTelegramBot() async {
    final uri = Uri.parse('https://t.me/liesubbot');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final loc = context.appLocalizations;

    final currentProfile = ref.watch(currentProfileProvider);
    final isExpired = isSubscriptionExpired(currentProfile);

    String? expireText;
    if (isExpired && currentProfile?.subscriptionInfo?.expire != null) {
      final expireDate = DateTime.fromMillisecondsSinceEpoch(
        currentProfile!.subscriptionInfo!.expire * 1000,
      );
      expireText = expireDate.show;
    }

    final accentColor =
        isExpired ? const Color(0xFFF59E0B) : const Color(0xFF10B981);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: accentColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(AppCorner.xxl),
                        border: Border.all(
                          color: accentColor.withValues(alpha: 0.35),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: accentColor.withValues(alpha: 0.2),
                            blurRadius: 28,
                            spreadRadius: 2,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppCorner.lg),
                          child: isExpired
                              ? Icon(
                                  Icons.warning_amber_rounded,
                                  size: 48,
                                  color: accentColor,
                                )
                              : Image.asset(
                                  'assets/images/lievpn_logo.png',
                                  width: 56,
                                  height: 56,
                                  errorBuilder: (_, _, _) => Icon(
                                    Icons.shield_outlined,
                                    size: 48,
                                    color: accentColor,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: accentColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(AppCorner.full),
                        border: Border.all(
                          color: accentColor.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        isExpired
                            ? '// ${loc.subExpiredTitle.toUpperCase()}'
                            : '// ${loc.subscriptionRequired.toUpperCase()}',
                        style: textTheme.labelSmall?.copyWith(
                          color: accentColor,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.4,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    isExpired ? loc.subscriptionInactive : appName,
                    style: textTheme.headlineSmall?.toBold.copyWith(
                      color: colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isExpired
                        ? (expireText != null
                            ? '${loc.subscriptionExpiredDesc}\n(${loc.expirationDate}: $expireText)'
                            : loc.subscriptionExpiredDesc)
                        : loc.subscriptionRequiredDesc,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant.withValues(alpha: 0.75),
                      height: 1.45,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 28),
                  Container(
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest
                          .withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(AppCorner.xl),
                      border: Border.all(
                        color:
                            colorScheme.outlineVariant.withValues(alpha: 0.3),
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        FilledButton.icon(
                          style: FilledButton.styleFrom(
                            backgroundColor: accentColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppCorner.lg),
                            ),
                            elevation: 0,
                          ),
                          onPressed: _isProcessing ? null : _handleUrlTap,
                          icon: _isProcessing
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Icon(Icons.link_rounded),
                          label: Text(
                            loc.insertSubscriptionUrl,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            side: BorderSide(
                              color: colorScheme.outlineVariant
                                  .withValues(alpha: 0.5),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppCorner.lg),
                            ),
                          ),
                          onPressed: _isProcessing ? null : _handleQrTap,
                          icon: const Icon(Icons.qr_code_scanner_rounded),
                          label: Text(
                            loc.scanQrCode,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        if (isExpired && currentProfile != null) ...[
                          const SizedBox(height: 10),
                          OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              side: BorderSide(
                                color: colorScheme.outlineVariant
                                    .withValues(alpha: 0.5),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(AppCorner.lg),
                              ),
                            ),
                            onPressed: _isProcessing
                                ? null
                                : () => _handleRefreshExisting(currentProfile),
                            icon: const Icon(Icons.refresh_rounded),
                            label: Text(
                              loc.checkUpdateStatus,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: colorScheme.primary,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppCorner.lg),
                      ),
                    ),
                    onPressed: _openTelegramBot,
                    icon: const Icon(Icons.send_rounded, size: 18),
                    label: Text(
                      '${loc.buyInTelegram} (@liesubbot)',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
