import 'package:fl_clash/views/views.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/icons/icons.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/views/config/general.dart';
import 'package:fl_clash/views/hotkey.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/advanced.dart';
import 'theme.dart';

class ToolsView extends ConsumerStatefulWidget {
  const ToolsView({super.key});

  @override
  ConsumerState<ToolsView> createState() => _ToolViewState();
}

class _ToolViewState extends ConsumerState<ToolsView> {
  Widget _buildNavigationMenuItem(NavigationItem navigationItem) {
    return ListItem.open(
      leading: GlyphIcon(navigationItem.glyph),
      title: Text(navigationItem.label.label),
      widget: navigationItem.builder(context),
      forceFull: navigationItem.modes.contains(NavigationItemMode.moreFull),
    );
  }

  Widget _buildNavigationMenu(List<NavigationItem> navigationItems) {
    return Column(
      children: [
        for (final navigationItem in navigationItems) ...[
          _buildNavigationMenuItem(navigationItem),
          navigationItems.last != navigationItem
              ? const Divider(height: 0)
              : Container(),
        ],
      ],
    );
  }

  List<Widget> _getOtherList(bool enableDeveloperMode) {
    return generateSection(
      title: context.appLocalizations.other,
      items: [
        const _CheckUpdateItem(),
        const _SupportItem(),
        const _DonatorsItem(),
        if (system.isAndroid) const _LieVpnSettingsItem(),
        if (enableDeveloperMode) const _DeveloperItem(),
        const _InfoItem(),
      ],
    );
  }

  List<Widget> _getSettingList() {
    return generateSection(
      title: context.appLocalizations.settings,
      items: [
        const _LocaleItem(),
        const _ThemeItem(),
        const _BackupItem(),
        if (system.isDesktop) const _HotkeyItem(),
        if (system.isAndroid) const _AccessItem(),
        const _AdvancedConfigItem(),
        const _GeneralItem(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final appSetting = ref.watch(
      appSettingProvider.select(
        (state) => (locale: state.locale, developerMode: state.developerMode),
      ),
    );
    final items = [
      Consumer(
        builder: (_, ref, _) {
          final state = ref.watch(moreToolsSelectorStateProvider);
          if (state.navigationItems.isEmpty) {
            return Container();
          }
          return Column(
            children: [
              ListHeader(title: context.appLocalizations.more),
              _buildNavigationMenu(state.navigationItems),
            ],
          );
        },
      ),
      ..._getSettingList(),
      ..._getOtherList(appSetting.developerMode),
    ];
    return CommonScaffold(
      title: context.appLocalizations.tools,
      body: ListView.builder(
        key: toolsStoreKey,
        itemCount: items.length,
        itemBuilder: (_, index) => items[index],
        padding: EdgeInsets.only(
          top: context.appBarInset,
          bottom: 20 + BottomInsetScope.of(context),
        ),
      ),
    );
  }
}

class _LocaleItem extends ConsumerWidget {
  const _LocaleItem();

  String _getLocaleString(BuildContext context, Locale? locale) {
    if (locale == null) return context.appLocalizations.defaultText;
    return locale.label;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(
      appSettingProvider.select((state) => state.locale),
    );
    final currentLocale = getLocaleForString(locale);
    return ListItem<Locale?>.options(
      leading: const GlyphIcon(AppGlyphs.language),
      title: Text(context.appLocalizations.language),
      subtitle: Text(_getLocaleString(context, currentLocale)),
      dialogTitle: context.appLocalizations.language,
      options: const [Locale('ru'), Locale('en'), Locale('uk'), Locale('be'), Locale('kk'), Locale('ko'), Locale('ja'), Locale('zh_CN'), Locale('tt')],
      onChanged: (Locale? locale) {
        ref
            .read(appSettingProvider.notifier)
            .update((state) => state.copyWith(locale: locale?.toString()));
      },
      textBuilder: (locale) => _getLocaleString(context, locale),
      value: currentLocale,
    );
  }
}

class _ThemeItem extends StatelessWidget {
  const _ThemeItem();

  @override
  Widget build(BuildContext context) {
    return ListItem.open(
      leading: const GlyphIcon(AppGlyphs.paintbrush),
      title: Text(context.appLocalizations.theme),
      subtitle: Text(context.appLocalizations.themeDesc),
      widget: const ThemeView(),
    );
  }
}

class _BackupItem extends StatelessWidget {
  const _BackupItem();

  @override
  Widget build(BuildContext context) {
    return ListItem.open(
      leading: const GlyphIcon(AppGlyphs.cloudSync),
      title: Text(context.appLocalizations.backupAndRestore),
      subtitle: Text(context.appLocalizations.backupAndRestoreDesc),
      widget: const BackupAndRestore(),
    );
  }
}

class _HotkeyItem extends StatelessWidget {
  const _HotkeyItem();

  @override
  Widget build(BuildContext context) {
    return ListItem.open(
      leading: const GlyphIcon(AppGlyphs.keyboard),
      title: Text(context.appLocalizations.hotkeyManagement),
      widget: const HotKeyView(),
    );
  }
}

class _AccessItem extends StatelessWidget {
  const _AccessItem();

  @override
  Widget build(BuildContext context) {
    return ListItem.open(
      leading: const GlyphIcon(AppGlyphs.appsList),
      title: Text(context.appLocalizations.accessControl),
      subtitle: Text(context.appLocalizations.accessControlDesc),
      widget: const AccessView(),
    );
  }
}

class _GeneralItem extends StatelessWidget {
  const _GeneralItem();

  @override
  Widget build(BuildContext context) {
    return ListItem.open(
      leading: const GlyphIcon(AppGlyphs.settings),
      title: Text(context.appLocalizations.general),
      widget: const GeneralView(),
    );
  }
}

class _AdvancedConfigItem extends StatelessWidget {
  const _AdvancedConfigItem();

  @override
  Widget build(BuildContext context) {
    return ListItem.open(
      leading: const GlyphIcon(AppGlyphs.wrench),
      title: Text(context.appLocalizations.advancedConfig),
      subtitle: Text(context.appLocalizations.advancedConfigDesc),
      widget: const AdvancedConfigView(),
    );
  }
}


class _InfoItem extends StatelessWidget {
  const _InfoItem();

  @override
  Widget build(BuildContext context) {
    return ListItem.open(
      leading: const GlyphIcon(AppGlyphs.info),
      title: Text(context.appLocalizations.about),
      widget: const AboutView(),
    );
  }
}

class _DeveloperItem extends StatelessWidget {
  const _DeveloperItem();

  @override
  Widget build(BuildContext context) {
    return ListItem.open(
      leading: const GlyphIcon(AppGlyphs.cpu),
      title: Text(context.appLocalizations.developerMode),
      widget: const DeveloperView(),
    );
  }
}

class _CheckUpdateItem extends StatelessWidget {
  const _CheckUpdateItem();

  @override
  Widget build(BuildContext context) {
    return ListItem(
      leading: const GlyphIcon(AppGlyphs.cloudDownload),
      title: Text(context.appLocalizations.checkUpdates),
      subtitle: Text(context.appLocalizations.checkUpdatesDesc),
      trailing: const GlyphIcon(AppGlyphs.chevronForward),
      onTap: () {
        AppUpdateManager.manualCheckUpdate(context);
      },
    );
  }
}

class _SupportItem extends StatelessWidget {
  const _SupportItem();

  @override
  Widget build(BuildContext context) {
    final loc = context.appLocalizations;
    return ListItem(
      leading: const Icon(Icons.support_agent_rounded),
      title: Text(loc.supportLieVpn),
      subtitle: const Text('Telegram, MAX, Email'),
      trailing: const GlyphIcon(AppGlyphs.chevronForward),
      onTap: () {
        showModalBottomSheet(
          context: context,
          showDragHandle: true,
          builder: (sheetContext) => SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      loc.supportLieVpnTitle,
                      style: Theme.of(sheetContext).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListItem(
                    leading: const Icon(Icons.send_rounded, color: Color(0xFF2AABEE)),
                    title: const Text('Telegram'),
                    subtitle: const Text('@lie2srvv'),
                    trailing: const GlyphIcon(AppGlyphs.openExternal),
                    onTap: () {
                      Navigator.pop(sheetContext);
                      dialogs.openUrl('https://lie2srvv.t.me');
                    },
                  ),
                  ListItem(
                    leading: const Icon(Icons.chat_bubble_rounded, color: Color(0xFF007AFF)),
                    title: Text(loc.supportMessengerMax),
                    subtitle: Text(loc.supportMessengerMaxSubtitle),
                    trailing: const GlyphIcon(AppGlyphs.openExternal),
                    onTap: () {
                      Navigator.pop(sheetContext);
                      dialogs.openUrl(
                        'https://max.ru/u/f9LHodD0cOLnlsYicsq-a-hyW986_IxbXiaExg00IFhfKP9cJFw9tJk-H-A',
                      );
                    },
                  ),
                  ListItem(
                    leading: const Icon(Icons.email_outlined, color: Color(0xFFEA4335)),
                    title: Text(loc.supportEmail),
                    subtitle: const Text('vpn@lie2srvv.com'),
                    trailing: const GlyphIcon(AppGlyphs.openExternal),
                    onTap: () {
                      Navigator.pop(sheetContext);
                      dialogs.openUrl('mailto:vpn@lie2srvv.com');
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DonatorsItem extends StatelessWidget {
  const _DonatorsItem();

  @override
  Widget build(BuildContext context) {
    return ListItem.open(
      leading: const GlyphIcon(AppGlyphs.star),
      title: Text(context.appLocalizations.donators),
      widget: const DonatorsView(),
      forceFull: false,
    );
  }
}

class _LieVpnSettingsItem extends StatelessWidget {
  const _LieVpnSettingsItem();

  @override
  Widget build(BuildContext context) {
    return ListItem.open(
      leading: const GlyphIcon(AppGlyphs.sliders),
      title: Text(context.appLocalizations.lieVpnSettings),
      subtitle: Text(context.appLocalizations.lieVpnSettingsDesc),
      widget: const LieVpnSettingsView(),
    );
  }
}
