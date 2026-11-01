import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/plugins/app.dart';

class SubscriptionReminderManager {
  static Future<void> checkSubscriptionExpiry(Profile? profile) async {
    if (profile == null) return;
    final expire = profile.subscriptionInfo?.expire;
    if (expire == null || expire <= 0) return;

    final expireDate = DateTime.fromMillisecondsSinceEpoch(expire * 1000);
    final now = DateTime.now();
    final diff = expireDate.difference(now);

    String? stage;
    String? title;
    String? message;

    if (diff.isNegative) {
      stage = 'expired';
      title = currentAppLocalizations.subExpiredTitle;
      message = currentAppLocalizations.subExpiredNotice;
    } else if (diff.inMinutes <= 60) {
      stage = '1h';
      title = currentAppLocalizations.subExpiringTitle;
      message = currentAppLocalizations.subExpireReminder1h;
    } else if (diff.inHours <= 24) {
      stage = '1d';
      title = currentAppLocalizations.subExpiringTitle;
      message = currentAppLocalizations.subExpireReminder1d;
    } else if (diff.inHours <= 72) {
      stage = '3d';
      title = currentAppLocalizations.subExpiringTitle;
      message = currentAppLocalizations.subExpireReminder3d;
    } else {
      await preferences.clearSubNotifyStage(profile.id);
      return;
    }

    final lastStage = await preferences.getSubNotifyStage(profile.id);
    if (lastStage != stage) {
      await preferences.saveSubNotifyStage(profile.id, stage);
      await app?.showNotification(
        title: title,
        message: message,
        id: 1002,
      );
      dialogs.showNotifier(
        '$title\n$message',
        level: MessageLevel.warning,
      );
    }
  }
}
