import 'dart:async';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/l10n/l10n.dart';
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
        title: 'Поддержка и связь',
        items: [
          ListItem(
            leading: const Icon(Icons.send_rounded, color: Color(0xFF2AABEE)),
            title: const Text('Telegram'),
            subtitle: const Text('@lie2srvv'),
            onTap: () {
              dialogs.openUrl('https://lie2srvv.t.me');
            },
            trailing: const Icon(Icons.launch),
          ),
          ListItem(
            leading: const Icon(Icons.chat_bubble_rounded, color: Color(0xFF007AFF)),
            title: const Text('Мессенджер MAX'),
            subtitle: const Text('Написать в MAX'),
            onTap: () {
              dialogs.openUrl(
                'https://max.ru/u/f9LHodD0cOLnlsYicsq-a-hyW986_IxbXiaExg00IFhfKP9cJFw9tJk-H-A',
              );
            },
            trailing: const Icon(Icons.launch),
          ),
          ListItem(
            leading: const Icon(Icons.email_outlined, color: Color(0xFFEA4335)),
            title: const Text('Электронная почта'),
            subtitle: const Text('vpn@lie2srvv.com'),
            onTap: () {
              dialogs.openUrl('mailto:vpn@lie2srvv.com');
            },
            trailing: const Icon(Icons.launch),
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
