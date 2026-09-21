import 'dart:async';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/list.dart';
import 'package:fl_clash/widgets/scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class AboutView extends ConsumerWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalizations = context.appLocalizations;
    final items = <Widget>[
      ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer(
              builder: (_, ref, _) {
                return _DeveloperModeDetector(
                  child: Wrap(
                    spacing: 16,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            'assets/images/lievpn_logo.png',
                            width: 64,
                            height: 64,
                            errorBuilder: (_, _, _) => Image.asset(
                              'assets/images/icon.png',
                              width: 64,
                              height: 64,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appName,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            globalState.packageInfo.version,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ],
                  ),
                  onEnterDeveloperMode: () {
                    ref
                        .read(appSettingProvider.notifier)
                        .update((state) => state.copyWith(developerMode: true));
                    context.showNotifier(
                      appLocalizations.developerModeEnableTip,
                      level: MessageLevel.success,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      ...generateSection(
        separated: false,
        title: 'О проекте',
        items: [
          ListItem(
            leading: const Icon(Icons.fork_right_rounded),
            title: const Text('Форк FlClash'),
            subtitle: const Text('LieVPN основан на FlClash. Открыть оригинал'),
            trailing: const Icon(Icons.launch),
            onTap: () {
              dialogs.openUrl('https://github.com/chen08209/FlClash');
            },
          ),
          ListItem(
            leading: const Icon(Icons.code_rounded),
            title: const Text('Исходный код LieVPN'),
            subtitle: const Text('GitHub репозиторий проекта'),
            trailing: const Icon(Icons.launch),
            onTap: () {
              dialogs.openUrl('https://github.com/lie2srvv/LieVPN');
            },
          ),
        ],
      ),
    ];
    return BaseScaffold(
      title: appLocalizations.about,
      body: Padding(
        padding: kMaterialListPadding.copyWith(top: 16, bottom: 16),
        child: generateListView(items),
      ),
    );
  }
}

class _DeveloperModeDetector extends StatefulWidget {
  final Widget child;
  final VoidCallback onEnterDeveloperMode;

  const _DeveloperModeDetector({
    required this.child,
    required this.onEnterDeveloperMode,
  });

  @override
  State<_DeveloperModeDetector> createState() => _DeveloperModeDetectorState();
}

class _DeveloperModeDetectorState extends State<_DeveloperModeDetector> {
  int _counter = 0;
  Timer? _timer;

  void _handleTap() {
    _counter++;
    if (_counter >= 5) {
      widget.onEnterDeveloperMode();
      _resetCounter();
      return;
    }
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 600), () {
      _resetCounter();
    });
  }

  void _resetCounter() {
    _counter = 0;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      behavior: HitTestBehavior.opaque,
      child: widget.child,
    );
  }
}
