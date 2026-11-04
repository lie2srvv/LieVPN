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

  static Future<void> show(
    BuildContext context, {
    String? initialUsername,
    Profile? currentProfile,
    bool isRenewal = false,
  }) {
    return showLiePaymentDialog(
      context,
      initialUsername: initialUsername,
      currentProfile: currentProfile,
      isRenewal: isRenewal,
    );
  }

  @override
  ConsumerState<LiePaymentSheet> createState() => _LiePaymentSheetState();
}

class _LiePaymentSheetState extends ConsumerState<LiePaymentSheet> {
  late TextEditingController _usernameController;
  late TextEditingController _promoController;
  bool _showPromoField = false;
  bool _isCheckingPromo = false;
  Map<String, dynamic>? _appliedPromo;
  String? _promoError;
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
    _promoController = TextEditingController();
    _checkExistingPendingPayment();
    if (widget.isRenewal && defaultUser.isNotEmpty) {
      _resolveTelegramAccount(defaultUser);
    }
  }

  Future<void> _resolveTelegramAccount(String rawIdentifier) async {
    final cleanId = rawIdentifier.trim().replaceAll('@', '');
    if (cleanId.isEmpty) return;
    try {
      final isNumeric = RegExp(r'^\d+$').hasMatch(cleanId);
      final resp = await _dio.post(
        'https://pay.lie2srvv.com/api/check-user',
        data: {'user_id': isNumeric ? cleanId : '', 'username': cleanId},
      );
      if (resp.statusCode == 200 && resp.data is Map && mounted) {
        final data = Map<String, dynamic>.from(resp.data as Map);
        final linked = data['linked_tg_username']?.toString().trim();
        final display = data['display_username']?.toString().trim();
        if (linked != null && linked.isNotEmpty) {
          setState(() {
            _usernameController.text = linked;
          });
        } else if (display != null &&
            display.isNotEmpty &&
            !display.startsWith('id_')) {
          setState(() {
            _usernameController.text = display;
          });
        }
      }
    } catch (_) {
      // Игнорируем ошибки фонового автоопределения, сохраняя исходный ник подписки
    }
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
    _promoController.dispose();
    super.dispose();
  }

  Future<void> _checkPromoCode() async {
    final code = _promoController.text.trim();
    if (code.isEmpty) return;

    setState(() {
      _isCheckingPromo = true;
      _promoError = null;
    });

    final rawUser = _usernameController.text.trim().replaceAll('@', '');

    try {
      final response = await _dio.post(
        'https://pay.lie2srvv.com/api/check-promo',
        data: {'code': code, 'plan_id': _selectedPlanId, 'username': rawUser},
      );

      if (response.statusCode == 200 && response.data is Map) {
        final data = Map<String, dynamic>.from(response.data as Map);
        if (data['ok'] == true) {
          setState(() {
            _appliedPromo = data;
            _promoError = null;
            _isCheckingPromo = false;
          });
          return;
        } else {
          setState(() {
            _appliedPromo = null;
            _promoError = data['error']?.toString() ?? 'Неверный промокод';
            _isCheckingPromo = false;
          });
          return;
        }
      }
      throw Exception('Неверный ответ сервера');
    } on DioException catch (e) {
      String msg = 'Промокод не найден или недействителен';
      if (e.response?.data is Map) {
        final err = (e.response!.data as Map)['error'];
        if (err != null && err.toString().trim().isNotEmpty) {
          msg = err.toString();
        }
      }
      setState(() {
        _appliedPromo = null;
        _promoError = msg;
        _isCheckingPromo = false;
      });
    } catch (e) {
      setState(() {
        _appliedPromo = null;
        _promoError = 'Промокод не найден или недействителен';
        _isCheckingPromo = false;
      });
    }
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

    setState(() {
      _isLoading = true;
    });

    // Проверяем регистрацию пользователя в Telegram-боте
    bool isKnown = false;
    try {
      final isNumeric = RegExp(r'^\d+$').hasMatch(rawUser);
      final checkResp = await _dio.post(
        'https://pay.lie2srvv.com/api/check-user',
        data: {
          'user_id': isNumeric ? rawUser : '',
          'username': isNumeric ? '' : rawUser,
        },
      );
      if (checkResp.statusCode == 200 && checkResp.data is Map) {
        final data = Map<String, dynamic>.from(checkResp.data as Map);
        isKnown = data['known'] == true;
      }
    } catch (_) {
      // При сбое сети или таймауте не блокируем пользователя жестко
      isKnown = true;
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }

    if (!isKnown && mounted) {
      final refCode =
          _appliedPromo != null && _appliedPromo!['referrer_id'] != null
          ? _appliedPromo!['code']?.toString()
          : null;
      final verified = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (_) =>
            _LieBotVerificationDialog(username: rawUser, referrerCode: refCode),
      );
      if (verified != true) {
        return;
      }
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
        data: {
          'plan_id': _selectedPlanId,
          'username': rawUser,
          'method': 'AC',
          if (_appliedPromo != null) 'promo_code': _appliedPromo!['code'],
          if (_appliedPromo != null && _appliedPromo!['referrer_id'] != null)
            'referrer': _appliedPromo!['referrer_id'].toString(),
        },
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
        'Подписка LieSub успешно активирована!',
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
                              : 'Оплата подписки LieSub',
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
                      Row(
                        children: [
                          if (_paymentUrl != null)
                            Expanded(
                              child: FilledButton.tonalIcon(
                                onPressed: () => _launchPayment(_paymentUrl!),
                                icon: const Icon(
                                  Icons.open_in_browser_rounded,
                                  size: 18,
                                ),
                                label: const Text('Открыть оплату'),
                                style: FilledButton.styleFrom(
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
                  'Юзернейм в Telegram',
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
                        if (_appliedPromo != null) {
                          _checkPromoCode();
                        }
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

                // Promo code section
                if (_appliedPromo != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppCorner.lg),
                      border: Border.all(
                        color: const Color(0xFF10B981).withValues(alpha: 0.35),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.card_giftcard_rounded,
                          color: Color(0xFF10B981),
                          size: 22,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Скидка ${_appliedPromo!['discount_value']}% (${_appliedPromo!['code']})",
                                style: textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF10B981),
                                ),
                              ),
                              if (_appliedPromo!['description'] != null &&
                                  _appliedPromo!['description']
                                      .toString()
                                      .isNotEmpty)
                                Text(
                                  _appliedPromo!['description'].toString(),
                                  style: textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onSurfaceVariant
                                        .withValues(alpha: 0.8),
                                    fontSize: 11,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close_rounded, size: 18),
                          onPressed: () {
                            setState(() {
                              _appliedPromo = null;
                              _promoController.clear();
                              _promoError = null;
                            });
                          },
                          tooltip: 'Удалить промокод',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ] else if (_showPromoField) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _promoController,
                          textCapitalization: TextCapitalization.characters,
                          decoration: InputDecoration(
                            hintText: 'ПРОМОКОД',
                            prefixIcon: const Icon(
                              Icons.discount_outlined,
                              size: 20,
                            ),
                            filled: true,
                            fillColor: colorScheme.surfaceContainerHighest
                                .withValues(alpha: 0.4),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppCorner.md),
                              borderSide: BorderSide(
                                color: colorScheme.outlineVariant.withValues(
                                  alpha: 0.3,
                                ),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppCorner.md),
                              borderSide: BorderSide(
                                color: colorScheme.outlineVariant.withValues(
                                  alpha: 0.3,
                                ),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppCorner.md),
                              borderSide: const BorderSide(
                                color: Color(0xFF10B981),
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        height: 48,
                        child: FilledButton.tonal(
                          onPressed: _isCheckingPromo ? null : _checkPromoCode,
                          style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppCorner.md),
                            ),
                          ),
                          child: _isCheckingPromo
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text('Применить'),
                        ),
                      ),
                    ],
                  ),
                  if (_promoError != null) ...[
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(
                        _promoError!,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.error,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 10),
                ] else ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: () {
                        setState(() {
                          _showPromoField = true;
                        });
                      },
                      icon: const Icon(Icons.discount_outlined, size: 16),
                      label: const Text('Есть промокод или скидка?'),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF10B981),
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],

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
                      _isLoading
                          ? 'Формируем заказ...'
                          : _appliedPromo != null
                          ? 'Оплатить ${_appliedPromo!['final_price']} ₽ (-${_appliedPromo!['discount_amount']} ₽)'
                          : 'Перейти к оплате ${kPaymentPlans.firstWhere((p) => p.id == _selectedPlanId).price.toStringAsFixed(0)} ₽',
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
                        activeColor: const Color(0xFF10B981),
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
                        backgroundColor: const Color(0xFF10B981),
                        foregroundColor: Colors.white,
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

class _LieBotVerificationDialog extends StatefulWidget {
  final String username;
  final String? referrerCode;

  const _LieBotVerificationDialog({required this.username, this.referrerCode});

  @override
  State<_LieBotVerificationDialog> createState() =>
      _LieBotVerificationDialogState();
}

class _LieBotVerificationDialogState extends State<_LieBotVerificationDialog> {
  int _secondsLeft = 60;
  Timer? _countdownTimer;
  Timer? _pollTimer;
  bool _isChecking = false;
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 4),
      receiveTimeout: const Duration(seconds: 4),
    ),
  );

  @override
  void initState() {
    super.initState();
    _startTimers();
  }

  void _startTimers() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_secondsLeft <= 1) {
        timer.cancel();
        setState(() {
          _secondsLeft = 0;
        });
      } else {
        setState(() {
          _secondsLeft--;
        });
      }
    });

    _pollTimer = Timer.periodic(const Duration(milliseconds: 1600), (_) {
      _checkStatus();
    });
  }

  Future<void> _checkStatus() async {
    if (_isChecking || !mounted) return;
    _isChecking = true;
    try {
      final clean = widget.username.trim().replaceAll('@', '');
      final isNumeric = RegExp(r'^\d+$').hasMatch(clean);
      final resp = await _dio.post(
        'https://pay.lie2srvv.com/api/check-user',
        data: {
          'user_id': isNumeric ? clean : '',
          'username': isNumeric ? '' : clean,
        },
      );
      if (resp.statusCode == 200 && resp.data is Map && mounted) {
        final data = Map<String, dynamic>.from(resp.data as Map);
        if (data['known'] == true) {
          _pollTimer?.cancel();
          _countdownTimer?.cancel();
          Navigator.of(context).pop(true);
          return;
        }
      }
    } catch (_) {
      // Игнорируем фоновые ошибки опроса
    } finally {
      if (mounted) {
        _isChecking = false;
      }
    }
  }

  Future<void> _openBot() async {
    final ref = widget.referrerCode != null && widget.referrerCode!.isNotEmpty
        ? 'ref_${widget.referrerCode}'
        : 'ref_lie2srvv';
    final url = 'https://t.me/liesubbot?start=$ref';
    try {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } catch (_) {}
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _pollTimer?.cancel();
    super.dispose();
  }

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
              // Icon & Title
              Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(AppCorner.md),
                      border: Border.all(
                        color: const Color(0xFF10B981).withValues(alpha: 0.3),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.telegram_rounded,
                      color: Color(0xFF10B981),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Подтвердите аккаунт',
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Активация в Telegram-боте',
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
              const SizedBox(height: 16),

              // Description
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.4,
                  ),
                  borderRadius: BorderRadius.circular(AppCorner.md),
                  border: Border.all(
                    color: colorScheme.outlineVariant.withValues(alpha: 0.3),
                  ),
                ),
                child: Text.rich(
                  TextSpan(
                    text: 'Вы ещё ни разу не запускали нашего бота ',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      height: 1.45,
                    ),
                    children: const [
                      TextSpan(
                        text: '@liesubbot',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF10B981),
                        ),
                      ),
                      TextSpan(
                        text: '.\n\nПожалуйста, перейдите в бота и нажмите ',
                      ),
                      TextSpan(
                        text: 'Запустить (Start)',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text:
                            ', чтобы после оплаты бот мгновенно отправил вам подписку и подключил сервис.',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Button to launch Telegram bot
              FilledButton.icon(
                onPressed: _openBot,
                icon: const Icon(Icons.rocket_launch_rounded, size: 18),
                label: const Text(
                  'Запустить @liesubbot',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppCorner.md),
                  ),
                  elevation: 2,
                ),
              ),
              const SizedBox(height: 12),

              // Radar / Status polling bar
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(AppCorner.md),
                  border: Border.all(
                    color: const Color(0xFF10B981).withValues(alpha: 0.25),
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 12,
                      height: 12,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Color(0xFF10B981)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'Ожидаем старт в боте...',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF10B981),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      '$_secondsLeft сек',
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurfaceVariant.withValues(
                          alpha: 0.7,
                        ),
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Alternative email notice
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.25,
                  ),
                  borderRadius: BorderRadius.circular(AppCorner.md),
                  border: Border.all(
                    color: colorScheme.outlineVariant.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('✉️', style: TextStyle(fontSize: 14)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Если вы не можете подтвердить через Telegram, напишите на почту work@lie2srvv.com — мы подключим подписку вручную.',
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant.withValues(
                            alpha: 0.7,
                          ),
                          fontSize: 11,
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Actions
              Row(
                children: [
                  Expanded(
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
                    child: FilledButton.tonal(
                      onPressed: () => _checkStatus(),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppCorner.md),
                        ),
                      ),
                      child: const Text(
                        'Проверить',
                        style: TextStyle(fontWeight: FontWeight.w600),
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
}
