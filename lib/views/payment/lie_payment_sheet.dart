import 'package:fl_clash/enum/enum.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

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
    badge: 'Хит',
  ),
  PaymentPlan(
    id: '12m',
    title: '1 год',
    days: 365,
    price: 950,
    desc: 'Максимальная выгода • 365 дней',
    badge: 'Выгода',
  ),
];

Future<void> showLiePaymentDialog(
  BuildContext context, {
  String? initialUsername,
  Profile? currentProfile,
  bool isRenewal = false,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppCorner.xxl)),
    ),
    builder: (_) => LiePaymentSheet(
      initialUsername: initialUsername,
      currentProfile: currentProfile,
      isRenewal: isRenewal,
    ),
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

  @override
  ConsumerState<LiePaymentSheet> createState() => _LiePaymentSheetState();
}

class _LiePaymentSheetState extends ConsumerState<LiePaymentSheet> {
  late TextEditingController _usernameController;
  String _selectedPlanId = '1m';
  bool _isLoading = false;
  String? _activeOrderId;
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
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    _usernameController.dispose();
    super.dispose();
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
        final payUrl = data['payment_url']?.toString() ?? '';

        if (orderId.isNotEmpty && payUrl.isNotEmpty) {
          setState(() {
            _activeOrderId = orderId;
            _paymentUrl = payUrl;
            _isLoading = false;
          });

          // Open browser for payment
          await dialogs.openUrl(payUrl);

          // Start polling order status
          _startPolling(orderId);
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

  void _startPolling(String orderId) {
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
          queryParameters: {'order_id': orderId},
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

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(AppCorner.lg),
                    ),
                    child: const Icon(
                      Icons.credit_card_rounded,
                      color: Color(0xFF10B981),
                      size: 26,
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
                              : 'Оплата подписки LieVPN',
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Быстрая оплата картой или СБП через ЮMoney',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant.withValues(
                              alpha: 0.7,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Waiting payment state
              if (_activeOrderId != null) ...[
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(AppCorner.xl),
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
                        'Завершите перевод в открывшемся окне браузера. Подписка автоматически применится здесь сразу после оплаты.',
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant.withValues(
                            alpha: 0.8,
                          ),
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      FilledButton.tonalIcon(
                        onPressed: _paymentUrl != null
                            ? () => dialogs.openUrl(_paymentUrl!)
                            : null,
                        icon: const Icon(
                          Icons.open_in_browser_rounded,
                          size: 18,
                        ),
                        label: const Text('Открыть страницу оплаты ещё раз'),
                        style: FilledButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppCorner.md),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ] else ...[
                // Username field
                Text(
                  'Никнейм в Telegram',
                  style: textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: 'например, lie2srvv',
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
                      vertical: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppCorner.lg),
                      borderSide: BorderSide(
                        color: colorScheme.outlineVariant.withValues(
                          alpha: 0.3,
                        ),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppCorner.lg),
                      borderSide: BorderSide(
                        color: colorScheme.outlineVariant.withValues(
                          alpha: 0.3,
                        ),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppCorner.lg),
                      borderSide: const BorderSide(
                        color: Color(0xFF10B981),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                // Plans selection
                Text(
                  'Выберите тариф',
                  style: textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                ...kPaymentPlans.map((plan) {
                  final isSelected = plan.id == _selectedPlanId;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedPlanId = plan.id;
                        });
                      },
                      borderRadius: BorderRadius.circular(AppCorner.lg),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF10B981).withValues(alpha: 0.12)
                              : colorScheme.surfaceContainerHighest.withValues(
                                  alpha: 0.4,
                                ),
                          borderRadius: BorderRadius.circular(AppCorner.lg),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF10B981)
                                : colorScheme.outlineVariant.withValues(
                                    alpha: 0.3,
                                  ),
                            width: isSelected ? 1.5 : 1.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        plan.title,
                                        style: textTheme.titleSmall?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      if (plan.badge.isNotEmpty) ...[
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF10B981),
                                            borderRadius: BorderRadius.circular(
                                              AppCorner.full,
                                            ),
                                          ),
                                          child: Text(
                                            plan.badge,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    plan.desc,
                                    style: textTheme.bodySmall?.copyWith(
                                      color: colorScheme.onSurfaceVariant
                                          .withValues(alpha: 0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '${plan.price.toStringAsFixed(0)} ₽',
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? const Color(0xFF10B981)
                                    : colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 14),

                // Pay Button
                SizedBox(
                  height: 50,
                  child: FilledButton.icon(
                    onPressed: _isLoading ? null : _createOrderAndPay,
                    icon: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.arrow_forward_rounded),
                    label: Text(
                      _isLoading ? 'Формируем заказ...' : 'Перейти к оплате',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF10B981),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppCorner.lg),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
