import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentPlan {
  final String id;
  final String title;
  final int days;
  final double price;
  final String desc;
  final String badge;

  const PaymentPlan({
    required this.id,
    required this.title,
    required this.days,
    required this.price,
    required this.desc,
    this.badge = '',
  });
}

const List<PaymentPlan> kPaymentPlans = [
  PaymentPlan(
    id: '1m',
    title: '1 месяц',
    days: 30,
    price: 100,
    desc: 'Базовый тариф на 30 дней',
  ),
  PaymentPlan(
    id: '3m',
    title: '3 месяца',
    days: 90,
    price: 270,
    desc: 'Экономия 10% • 90 дней',
    badge: '-10%',
  ),
  PaymentPlan(
    id: '6m',
    title: '6 месяцев',
    days: 180,
    price: 500,
    desc: 'Популярный выбор • 180 дней',
    badge: '-17%',
  ),
  PaymentPlan(
    id: '12m',
    title: '1 год',
    days: 365,
    price: 950,
    desc: 'Максимальная выгода • 365 дней',
    badge: '-21%',
  ),
];

Future<void> showLiePaymentDialog(
  BuildContext context, {
  String? initialUsername,
  Profile? currentProfile,
  bool isRenewal = false,
}) {
  return LiePaymentSheet.show(
    context,
    initialUsername: initialUsername,
    currentProfile: currentProfile,
    isRenewal: isRenewal,
  );
}

class LiePaymentSheet extends ConsumerStatefulWidget {
  final String? initialUsername;
  final Profile? currentProfile;
  final bool isRenewal;

  const LiePaymentSheet({
    super.key,
    this.initialUsername,
    this.currentProfile,
    this.isRenewal = false,
  });

  static Future<void> show(
    BuildContext context, {
    String? initialUsername,
    Profile? currentProfile,
    bool isRenewal = false,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => LiePaymentSheet(
        initialUsername: initialUsername,
        currentProfile: currentProfile,
        isRenewal: isRenewal,
      ),
    );
  }

  @override
  ConsumerState<LiePaymentSheet> createState() => _LiePaymentSheetState();
}

class _LiePaymentSheetState extends ConsumerState<LiePaymentSheet> {
  late TextEditingController _usernameController;
  String _selectedPlanId = '1m';
  bool _isLoading = false;
  String? _activeOrderId;
  String? _activeClientSecret;
  String? _paymentUrl;
  Timer? _pollTimer;
  int _pollCount = 0;

  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 8),
      receiveTimeout: const Duration(seconds: 8),
    ),
  );

  @override
  void initState() {
    super.initState();
    String defaultUser = widget.initialUsername ?? '';
    if (defaultUser.isEmpty && widget.currentProfile != null) {
      defaultUser = widget.currentProfile!.label;
    }
    _usernameController = TextEditingController(text: defaultUser);
    _checkExistingPendingPayment();
  }

  Future<void> _checkExistingPendingPayment() async {
    final pending = await preferences.getPendingPayment();
    if (pending != null && mounted) {
      final orderId = pending['order_id']?.toString() ?? '';
      final clientSecret = pending['client_secret']?.toString() ?? '';
      final savedUser = pending['username']?.toString() ?? '';
      final createdAt = pending['created_at'] as int? ?? 0;
      final diffMs = DateTime.now().millisecondsSinceEpoch - createdAt;

      if (orderId.isNotEmpty && diffMs < 48 * 3600 * 1000) {
        setState(() {
          _activeOrderId = orderId;
          _activeClientSecret = clientSecret;
          if (savedUser.isNotEmpty && _usernameController.text.isEmpty) {
            _usernameController.text = savedUser;
          }
        });
        _startPolling(orderId, clientSecret);
      } else {
        await preferences.clearPendingPayment();
      }
    }
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _launchPayment(String payUrl) async {
    try {
      final uri = Uri.parse(payUrl);
      if (Platform.isAndroid) {
        await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
      } else {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      commonPrint.log('Error launching payment url: $e');
    }
  }

  Future<void> _createOrderAndPay() async {
    final rawUser = _usernameController.text.trim().replaceAll('@', '');
    if (rawUser.isEmpty) {
      dialogs.showNotifier(
        'Укажите ваш никнейм в Telegram',
        level: MessageLevel.warning,
      );
      return;
    }

    final dismissed = await preferences.getCommissionWarningDismissed();
    if (!dismissed && mounted) {
      final shouldProceed = await showDialog<bool>(
        context: context,
        builder: (_) => const _LieCommissionWarningDialog(),
      );
      if (shouldProceed != true) {
        return;
      }
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _dio.post(
        'https://pay.lie2srvv.com/api/create-order',
        data: {'plan_id': _selectedPlanId, 'username': rawUser, 'method': 'AC'},
      );

      if (response.statusCode == 200 && response.data is Map) {
        final data = response.data as Map;
        final orderId = data['order_id']?.toString() ?? '';
        final clientSecret = data['client_secret']?.toString() ?? '';
        final payUrl = data['payment_url']?.toString() ?? '';

        if (orderId.isNotEmpty && payUrl.isNotEmpty) {
          await preferences.savePendingPayment(
            orderId: orderId,
            clientSecret: clientSecret,
            username: rawUser,
            isRenewal: widget.isRenewal,
          );

          setState(() {
            _activeOrderId = orderId;
            _activeClientSecret = clientSecret;
            _paymentUrl = payUrl;
            _isLoading = false;
          });

          // Open directly via In-App Browser (Android) or external browser (Desktop)
          await _launchPayment(payUrl);

          // Start polling order status
          _startPolling(orderId, clientSecret);
          return;
        }
      }
      throw Exception('Не удалось создать заказ на сервере');
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        dialogs.showNotifier(
          'Ошибка создания платежа: $e',
          level: MessageLevel.error,
        );
      }
    }
  }

  void _startPolling([String? orderId, String? clientSecret]) {
    final targetOrderId = orderId ?? _activeOrderId;
    final targetSecret = clientSecret ?? _activeClientSecret ?? '';
    if (targetOrderId == null) return;
    _pollTimer?.cancel();
    _pollCount = 0;

    _pollTimer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      _pollCount++;
      if (_pollCount > 180) {
        // 6 minutes max
        timer.cancel();
        return;
      }

      try {
        final resp = await _dio.get(
          'https://pay.lie2srvv.com/api/check-order',
          queryParameters: {
            'order_id': targetOrderId,
            if (targetSecret.isNotEmpty) 'client_secret': targetSecret,
          },
        );

        if (resp.statusCode == 200 && resp.data is Map) {
          final data = resp.data as Map;
          final status = data['status']?.toString();
          final subUrl = data['subscription_url']?.toString() ?? '';

          if (status == 'paid') {
            timer.cancel();
            if (mounted) {
              await _handlePaymentSuccess(subUrl);
            }
          }
        }
      } catch (_) {
        // Polling errors are ignored
      }
    });
  }

  Future<void> _handlePaymentSuccess(String subUrl) async {
    if (!mounted) return;

    await preferences.clearPendingPayment();

    dialogs.showNotifier(
      'Оплата успешно подтверждена! Активируем подписку...',
      level: MessageLevel.info,
    );

    if (widget.isRenewal && widget.currentProfile != null) {
      // Refresh current profile
      try {
        await ref
            .read(profilesActionProvider.notifier)
            .updateProfile(
              widget.currentProfile!,
              showLoading: true,
              force: true,
            );
      } catch (_) {}
    } else if (subUrl.isNotEmpty) {
      // Add profile from received subscription URL
      try {
        await ref
            .read(profilesActionProvider.notifier)
            .addProfileFormURL(subUrl, replaceOld: true);
      } catch (_) {}
    } else if (widget.currentProfile != null) {
      try {
        await ref
            .read(profilesActionProvider.notifier)
            .updateProfile(
              widget.currentProfile!,
              showLoading: true,
              force: true,
            );
      } catch (_) {}
    }

    if (mounted) {
      Navigator.of(context).pop();
      dialogs.showNotifier(
        'Подписка LieVPN успешно активирована!',
        level: MessageLevel.info,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        top: 16,
        left: 20,
        right: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Title & Subtitle
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.bolt_rounded,
                    color: colorScheme.onPrimaryContainer,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.isRenewal
                            ? 'Продление подписки'
                            : 'Оформление подписки',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Быстрое автоматическое подключение через LiePay',
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            if (_activeOrderId != null) ...[
              // Active payment pending banner
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppCorner.lg),
                  border: Border.all(
                    color: const Color(0xFF10B981).withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      width: 32,
                      height: 32,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation(Color(0xFF10B981)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Ожидаем подтверждения оплаты...',
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF10B981),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Завершите перевод в открывшемся окне. Подписка автоматически применится здесь сразу после оплаты.',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant.withValues(
                          alpha: 0.8,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        if (_paymentUrl != null)
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _launchPayment(_paymentUrl!),
                              icon: const Icon(
                                Icons.open_in_new_rounded,
                                size: 16,
                              ),
                              label: const Text('Открыть оплату'),
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppCorner.md,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if (_paymentUrl != null) const SizedBox(width: 8),
                        Expanded(
                          child: TextButton(
                            onPressed: () async {
                              _pollTimer?.cancel();
                              await preferences.clearPendingPayment();
                              setState(() {
                                _activeOrderId = null;
                                _activeClientSecret = null;
                                _paymentUrl = null;
                              });
                            },
                            child: const Text('Отменить и создать заново'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ] else ...[
              // Username field
              Text(
                'Telegram никнейм для подписки',
                style: textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: 'username (без знака @)',
                  prefixIcon: const Icon(
                    Icons.alternate_email_rounded,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.5,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppCorner.md),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Plans selector
              Text(
                'Выберите тариф',
                style: textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              Column(
                children: kPaymentPlans.map((plan) {
                  final isSelected = plan.id == _selectedPlanId;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedPlanId = plan.id;
                        });
                      },
                      borderRadius: BorderRadius.circular(AppCorner.md),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? colorScheme.primaryContainer.withValues(
                                  alpha: 0.35,
                                )
                              : colorScheme.surfaceContainerHighest.withValues(
                                  alpha: 0.35,
                                ),
                          borderRadius: BorderRadius.circular(AppCorner.md),
                          border: Border.all(
                            color: isSelected
                                ? colorScheme.primary
                                : Colors.transparent,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Radio<String>(
                              value: plan.id,
                              groupValue: _selectedPlanId,
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() {
                                    _selectedPlanId = val;
                                  });
                                }
                              },
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        plan.title,
                                        style: textTheme.bodyLarge?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      if (plan.badge.isNotEmpty) ...[
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: colorScheme.primary,
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                          child: Text(
                                            plan.badge,
                                            style: textTheme.labelSmall
                                                ?.copyWith(
                                                  color: colorScheme.onPrimary,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  Text(
                                    plan.desc,
                                    style: textTheme.bodySmall?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '${plan.price.toInt()} ₽',
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? colorScheme.primary
                                    : colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Pay button
              FilledButton(
                onPressed: _isLoading ? null : _createOrderAndPay,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppCorner.md),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.credit_card_rounded, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            widget.isRenewal
                                ? 'Продлить подписку'
                                : 'Оплатить через LiePay',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _LieCommissionWarningDialog extends StatefulWidget {
  const _LieCommissionWarningDialog();

  @override
  State<_LieCommissionWarningDialog> createState() =>
      _LieCommissionWarningDialogState();
}

class _LieCommissionWarningDialogState
    extends State<_LieCommissionWarningDialog> {
  bool _isAgreed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppCorner.xl),
      ),
      backgroundColor: colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title
              Text(
                'Комиссия банков при оплате картой',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Subtitle
              Text.rich(
                const TextSpan(
                  text: 'Оплата происходит через шлюз ',
                  children: [
                    TextSpan(
                      text: 'ЮMoney',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          '. При прямом вводе карты ваш банк может расценить платёж как перевод («стягивание») и начислить ',
                    ),
                    TextSpan(
                      text: 'дополнительную комиссию',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: ':'),
                  ],
                ),
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 14),

              // Bank list card
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(AppCorner.md),
                  border: Border.all(
                    color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    _buildBankRow(
                      dotColor: const Color(0xFF21A038),
                      name: 'Сбербанк',
                      fee: '1.25%, мин. 50 ₽',
                      feeColor: colorScheme.error,
                      textTheme: textTheme,
                    ),
                    const Divider(height: 12, thickness: 0.5),
                    _buildBankRow(
                      dotColor: const Color(0xFF002882),
                      name: 'ВТБ',
                      fee: '1.79%, мин. 79 ₽',
                      feeColor: colorScheme.error,
                      textTheme: textTheme,
                    ),
                    const Divider(height: 12, thickness: 0.5),
                    _buildBankRow(
                      dotColor: const Color(0xFFEF3124),
                      name: 'Альфа-Банк',
                      fee: '49 ₽ + 1.95% (от 199 ₽)',
                      feeColor: colorScheme.error,
                      textTheme: textTheme,
                    ),
                    const Divider(height: 12, thickness: 0.5),
                    _buildBankRow(
                      dotColor: const Color(0xFF005BFF),
                      name: 'Озон Банк',
                      fee: '1.5%, мин. 45 ₽',
                      feeColor: colorScheme.error,
                      textTheme: textTheme,
                    ),
                    const Divider(height: 12, thickness: 0.5),
                    _buildBankRow(
                      dotColor: const Color(0xFFFFDD2D),
                      name: 'Т-Банк',
                      fee: '0 ₽ (в лимите переводов)',
                      feeColor: const Color(0xFF10B981),
                      textTheme: textTheme,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Credit card alert
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.errorContainer.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(AppCorner.md),
                  border: Border.all(
                    color: colorScheme.error.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('💳', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text.rich(
                        const TextSpan(
                          text: 'Кредитные карты: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text:
                                  'большинство банков взимают от 390–590 ₽ и моментально аннулируют беспроцентный период!',
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onErrorContainer,
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Recommendation card
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(AppCorner.md),
                  border: Border.all(
                    color: const Color(0xFF10B981).withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text('💡', style: TextStyle(fontSize: 14)),
                        SizedBox(width: 6),
                        Text(
                          'Рекомендуется:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Color(0xFF10B981),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _buildStepRow(
                      step: '1',
                      richText: const TextSpan(
                        text: 'Откройте бесплатный кошелёк ',
                        children: [
                          TextSpan(
                            text: 'ЮMoney',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                ' (быстро в 1 клик через СберID или по номеру телефона).',
                          ),
                        ],
                      ),
                      textTheme: textTheme,
                      colorScheme: colorScheme,
                    ),
                    const SizedBox(height: 6),
                    _buildStepRow(
                      step: '2',
                      richText: const TextSpan(
                        text: 'Пополните баланс кошелька со своего банка ',
                        children: [
                          TextSpan(
                            text: 'по СБП без комиссии 0%',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF10B981),
                            ),
                          ),
                          TextSpan(text: '.'),
                        ],
                      ),
                      textTheme: textTheme,
                      colorScheme: colorScheme,
                    ),
                    const SizedBox(height: 6),
                    _buildStepRow(
                      step: '3',
                      richText: const TextSpan(
                        text: 'На странице оплаты выберите ',
                        children: [
                          TextSpan(
                            text: '«Из ЮMoney»',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: ' — списание пройдёт ровно на сумму тарифа.',
                          ),
                        ],
                      ),
                      textTheme: textTheme,
                      colorScheme: colorScheme,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Checkbox tile
              InkWell(
                onTap: () {
                  setState(() {
                    _isAgreed = !_isAgreed;
                  });
                },
                borderRadius: BorderRadius.circular(AppCorner.md),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 2,
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _isAgreed,
                        onChanged: (val) {
                          setState(() {
                            _isAgreed = val ?? false;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          'Я ознакомился с условиями и больше не показывать это предупреждение',
                          style: textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Actions
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppCorner.md),
                        ),
                      ),
                      child: const Text('Отмена'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: FilledButton(
                      onPressed: _isAgreed
                          ? () async {
                              await preferences.saveCommissionWarningDismissed(
                                true,
                              );
                              if (context.mounted) {
                                Navigator.of(context).pop(true);
                              }
                            }
                          : null,
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppCorner.md),
                        ),
                      ),
                      child: const Text(
                        'Перейти к оплате',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBankRow({
    required Color dotColor,
    required String name,
    required String fee,
    required Color feeColor,
    required TextTheme textTheme,
  }) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          name,
          style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
        ),
        const Spacer(),
        Text(
          fee,
          style: textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: feeColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStepRow({
    required String step,
    required InlineSpan richText,
    required TextTheme textTheme,
    required ColorScheme colorScheme,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: const Color(0xFF10B981).withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: const Color(0xFF10B981).withValues(alpha: 0.4),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            step,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Color(0xFF10B981),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text.rich(
            richText,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}
