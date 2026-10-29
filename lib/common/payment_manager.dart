import 'dart:async';
import 'package:dio/dio.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiePaymentManager {
  static bool _isChecking = false;

  /// Checks if there is a pending order stored on the device.
  /// If order is paid, automatically fulfills subscription and notifies the user.
  static Future<void> checkPendingPayment(WidgetRef ref) async {
    if (_isChecking) return;
    _isChecking = true;

    try {
      final pending = await preferences.getPendingPayment();
      if (pending == null) return;

      final orderId = pending['order_id']?.toString() ?? '';
      final clientSecret = pending['client_secret']?.toString() ?? '';
      final createdAt = pending['created_at'] as int? ?? 0;
      final isRenewal = pending['is_renewal'] as bool? ?? false;

      if (orderId.isEmpty) return;

      // Discard orders older than 48 hours
      final diffMs = DateTime.now().millisecondsSinceEpoch - createdAt;
      if (diffMs > 48 * 3600 * 1000) {
        await preferences.clearPendingPayment();
        return;
      }

      final dio = Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 8),
          receiveTimeout: const Duration(seconds: 8),
        ),
      );

      final resp = await dio.get(
        'https://pay.lie2srvv.com/api/check-order',
        queryParameters: {
          'order_id': orderId,
          if (clientSecret.isNotEmpty) 'client_secret': clientSecret,
        },
      );

      if (resp.statusCode == 200 && resp.data is Map) {
        final data = resp.data as Map;
        final status = data['status']?.toString();
        final subUrl = data['subscription_url']?.toString() ?? '';

        if (status == 'paid') {
          // Clear immediately to prevent repeat triggers
          await preferences.clearPendingPayment();

          final currentProfile = ref.read(currentProfileProvider);
          if (isRenewal && currentProfile != null) {
            await ref
                .read(profilesActionProvider.notifier)
                .updateProfile(currentProfile, showLoading: false, force: true);
          } else if (subUrl.isNotEmpty) {
            await ref
                .read(profilesActionProvider.notifier)
                .addProfileFormURL(subUrl, replaceOld: true);
          }

          dialogs.showNotifier(
            'Оплата подтверждена! Подписка LieVPN успешно активирована.',
            level: MessageLevel.success,
          );
        }
      }
    } catch (_) {
      // Ignored on network issues
    } finally {
      _isChecking = false;
    }
  }
}
