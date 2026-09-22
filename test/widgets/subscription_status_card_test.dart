import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/theme.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/views/dashboard/widgets/subscription_status_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('SubscriptionStatusCard renders prompt when no subscription is added',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          currentProfileProvider.overrideWithValue(null),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            ...GlobalMaterialLocalizations.delegates,
          ],
          supportedLocales: AppLocalizations.delegate.supportedLocales,
          locale: const Locale('ru'),
          builder: (context, child) {
            globalState.measure = Measure.of(context, 1);
            globalState.theme = CommonTheme.of(context, 1);
            return child!;
          },
          home: const Scaffold(
            body: SubscriptionStatusCard(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Личный кабинет'), findsOneWidget);
    expect(find.text('Нажмите, чтобы вставить подписку'), findsOneWidget);
  });

  testWidgets(
      'SubscriptionStatusCard renders usage stats when LieVPN subscription is active',
      (tester) async {
    final profile = Profile.normal(
      label: 'LieVPN User',
      url: 'https://vpn.lie2srvv.com/sub/12345',
    ).copyWith(
      subscriptionInfo: const SubscriptionInfo(
        upload: 1048576,
        download: 10485760,
        total: 10737418240,
        expire: 4102444800,
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          currentProfileProvider.overrideWithValue(profile),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            ...GlobalMaterialLocalizations.delegates,
          ],
          supportedLocales: AppLocalizations.delegate.supportedLocales,
          locale: const Locale('ru'),
          builder: (context, child) {
            globalState.measure = Measure.of(context, 1);
            globalState.theme = CommonTheme.of(context, 1);
            return child!;
          },
          home: const Scaffold(
            body: SubscriptionStatusCard(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Личный кабинет'), findsOneWidget);
    expect(find.textContaining('LieVPN User'), findsOneWidget);
    expect(find.text('Статистика трафика'), findsOneWidget);
  });
}
