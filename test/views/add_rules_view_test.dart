import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/views/rules/add_rules_view.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';
import '../helpers/test_database_providers.dart';

class _RecordingGlobalRules extends TestGlobalRules {
  _RecordingGlobalRules(super.initial);

  final deleted = <List<int>>[];

  @override
  void delAll(Iterable<int> ruleIds) {
    deleted.add(List<int>.from(ruleIds));
  }
}

Rule _rule(int id, String content, RuleAction action) {
  return Rule(
    id: id,
    ruleAction: action,
    content: content,
    ruleTarget: 'DIRECT',
    order: id.toString(),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProviderContainer container;
  late _RecordingGlobalRules rules;

  Future<void> pumpRules(WidgetTester tester, List<Rule> initial) async {
    tester.view.physicalSize = const Size(1200, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    rules = _RecordingGlobalRules(initial);
    container = ProviderContainer(
      overrides: [globalRulesProvider.overrideWith(() => rules)],
    );
    addTearDown(container.dispose);
    globalState.container = container;
    container
        .read(viewSizeProvider.notifier)
        .update((_) => const Size(1200, 2400));

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const TestApp(child: AddRulesView()),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('renders rules in AddRulesView', (tester) async {
    final list = [
      _rule(1, 'google.com', RuleAction.DOMAIN_SUFFIX),
      _rule(2, 'telegram.org', RuleAction.DOMAIN),
      _rule(3, 'com.whatsapp', RuleAction.PROCESS_NAME),
    ];
    await pumpRules(tester, list);

    expect(find.text('google.com'), findsOneWidget);
    expect(find.text('telegram.org'), findsOneWidget);
    expect(find.text('com.whatsapp'), findsOneWidget);
    expect(find.text('DIRECT'), findsNWidgets(4)); // 1 in badge above + 3 in items
  });
}
