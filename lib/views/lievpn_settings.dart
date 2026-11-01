import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/plugins/app.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

String _getTypeLabel(BuildContext context, int type) {
  final l = context.appLocalizations;
  return switch (type) {
    0 => l.liveNotificationTypeUsername,
    1 => l.liveNotificationTypeTraffic,
    2 => l.liveNotificationTypeSpeed,
    3 => l.liveNotificationTypeSpeedDown,
    4 => l.liveNotificationTypeSpeedUp,
    5 => l.liveNotificationTypeServer,
    6 => l.liveNotificationTypePing,
    7 => l.liveNotificationTypeCustom,
    8 => l.liveNotificationTypeStreak,
    _ => l.liveNotificationTypeUsername,
  };
}

class LieVpnSettingsView extends ConsumerWidget {
  const LieVpnSettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liveNotification = ref.watch(
      appSettingProvider.select((state) => state.liveNotification),
    );
    final liveNotificationType = ref.watch(
      appSettingProvider.select((state) => state.liveNotificationType),
    );
    final liveNotificationCustomText = ref.watch(
      appSettingProvider.select((state) => state.liveNotificationCustomText),
    );

    final items = <Widget>[
      if (system.isAndroid) ...[
        ListItem.toggle(
          title: Text(context.appLocalizations.liveNotification),
          subtitle: Text(context.appLocalizations.liveNotificationDesc),
          value: liveNotification,
          onChanged: (value) {
            if (value) {
              App().requestNotificationsPermission();
            }
            ref
                .read(appSettingProvider.notifier)
                .update((state) => state.copyWith(liveNotification: value));
          },
        ),
        if (liveNotification) ...[
          ListItem<int>.options(
            leading: const Icon(Icons.tune_outlined),
            title: Text(context.appLocalizations.liveNotificationType),
            subtitle: Text(_getTypeLabel(context, liveNotificationType)),
            dialogTitle: context.appLocalizations.liveNotificationType,
            options: const [0, 1, 2, 3, 4, 5, 6, 7, 8],
            value: liveNotificationType,
            textBuilder: (type) => _getTypeLabel(context, type),
            onChanged: (val) {
              if (val != null) {
                ref
                    .read(appSettingProvider.notifier)
                    .update((state) => state.copyWith(liveNotificationType: val));
              }
            },
          ),
          if (liveNotificationType == 7)
            ListItem.input(
              leading: const Icon(Icons.edit_note_outlined),
              title: Text(context.appLocalizations.liveNotificationCustomText),
              subtitle: Text(
                liveNotificationCustomText.isEmpty
                    ? 'LieVPN'
                    : liveNotificationCustomText,
              ),
              dialogTitle: context.appLocalizations.liveNotificationCustomText,
              value: liveNotificationCustomText,
              onChanged: (value) {
                if (value != null) {
                  ref.read(appSettingProvider.notifier).update(
                        (state) => state.copyWith(
                            liveNotificationCustomText: value.trim()),
                      );
                }
              },
            ),
        ],
      ],
    ];

    return BaseScaffold(
      title: context.appLocalizations.lieVpnSettings,
      body: ListView.separated(
        padding: const EdgeInsets.only(bottom: 20),
        itemBuilder: (_, index) => items[index],
        separatorBuilder: (_, _) => const Divider(height: 0),
        itemCount: items.length,
      ),
    );
  }
}
