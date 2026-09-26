import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/plugins/app.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/widgets/widgets.dart';

enum CustomRuleMode { domain, app }

class AddRulesView extends ConsumerStatefulWidget {
  const AddRulesView({super.key});

  @override
  ConsumerState<AddRulesView> createState() => _AddRulesViewState();
}

class _AddRulesViewState extends ConsumerState<AddRulesView> {
  CustomRuleMode _mode = CustomRuleMode.domain;
  final TextEditingController _inputController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _inputController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleAddRule() {
    final text = _inputController.text.trim();
    final appLocalizations = context.appLocalizations;
    if (text.isEmpty) {
      dialogs.showNotifier(
        appLocalizations.ruleInputEmpty,
        level: MessageLevel.warning,
      );
      return;
    }

    final RuleAction action = _mode == CustomRuleMode.domain
        ? RuleAction.DOMAIN_SUFFIX
        : RuleAction.PROCESS_NAME;

    final existingRules = ref.read(globalRulesProvider).value ?? [];
    final alreadyExists = existingRules.any(
      (r) =>
          r.ruleAction == action &&
          (r.content?.toLowerCase() == text.toLowerCase()) &&
          (r.ruleTarget?.toUpperCase() == 'DIRECT'),
    );

    if (alreadyExists) {
      dialogs.showNotifier(
        appLocalizations.ruleAlreadyExists,
        level: MessageLevel.warning,
      );
      return;
    }

    final newRule = Rule(
      id: snowflake.id,
      ruleAction: action,
      content: text,
      ruleTarget: 'DIRECT',
    );

    ref.read(globalRulesProvider.notifier).put(newRule);
    _inputController.clear();
    _focusNode.unfocus();

    dialogs.showNotifier(
      appLocalizations.ruleAddedSuccess,
      level: MessageLevel.success,
    );
  }

  Future<void> _handlePickApp() async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => const _AppPickerSheet(),
    );

    if (selected != null && selected.isNotEmpty) {
      setState(() {
        _inputController.text = selected;
      });
    }
  }

  Future<void> _handleDeleteRule(Rule rule) async {
    final appLocalizations = context.appLocalizations;
    final res = await dialogs.showMessage(
      title: appLocalizations.tip,
      message: TextSpan(
        text: appLocalizations.deleteMultipTip(rule.content ?? rule.ruleAction.name),
      ),
    );
    if (res == true) {
      ref.read(globalRulesProvider.notifier).delAll([rule.id]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.appLocalizations;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final allRules = ref.watch(globalRulesProvider).value ?? [];

    // Filter rules relevant to custom direct rules
    final customRules = allRules.where((r) {
      return (r.ruleAction == RuleAction.DOMAIN_SUFFIX ||
              r.ruleAction == RuleAction.DOMAIN ||
              r.ruleAction == RuleAction.PROCESS_NAME) &&
          (r.ruleTarget?.toUpperCase() == 'DIRECT');
    }).toList();

    return CommonScaffold(
      title: appLocalizations.addRules,
      body: SafeArea(
        child: Column(
          children: [
            // Top Section: Input Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(AppCorner.lg),
                  border: Border.all(
                    color: colorScheme.outlineVariant.withValues(alpha: 0.25),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Slider / Segmented Button
                    SizedBox(
                      width: double.infinity,
                      child: SegmentedButton<CustomRuleMode>(
                        segments: [
                          ButtonSegment<CustomRuleMode>(
                            value: CustomRuleMode.domain,
                            icon: const Icon(Icons.language_rounded, size: 18),
                            label: Text(
                              appLocalizations.ruleDomain,
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          ButtonSegment<CustomRuleMode>(
                            value: CustomRuleMode.app,
                            icon: const Icon(Icons.apps_rounded, size: 18),
                            label: Text(
                              appLocalizations.ruleApp,
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                        selected: {_mode},
                        onSelectionChanged: (newSelection) {
                          setState(() {
                            _mode = newSelection.first;
                            _inputController.clear();
                          });
                        },
                        style: ButtonStyle(
                          visualDensity: VisualDensity.compact,
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppCorner.md),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Input Field with Trailing Button
                    TextField(
                      controller: _inputController,
                      focusNode: _focusNode,
                      style: textTheme.bodyMedium?.toJetBrainsMono,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        hintText: _mode == CustomRuleMode.domain
                            ? appLocalizations.ruleDomainHint
                            : appLocalizations.ruleProcessHint,
                        hintStyle: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                        ),
                        prefixIcon: Icon(
                          _mode == CustomRuleMode.domain
                              ? Icons.public
                              : Icons.widgets_outlined,
                          size: 20,
                          color: colorScheme.primary,
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_mode == CustomRuleMode.app)
                              IconButton(
                                icon: const Icon(Icons.apps_rounded),
                                tooltip: appLocalizations.ruleSelectAppTooltip,
                                onPressed: _handlePickApp,
                              ),
                            if (_inputController.text.isNotEmpty)
                              IconButton(
                                icon: const Icon(Icons.clear, size: 18),
                                onPressed: () {
                                  setState(() {
                                    _inputController.clear();
                                  });
                                },
                              ),
                          ],
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppCorner.md),
                          borderSide: BorderSide(
                            color: colorScheme.outlineVariant.withValues(alpha: 0.3),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppCorner.md),
                          borderSide: BorderSide(
                            color: colorScheme.outlineVariant.withValues(alpha: 0.3),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppCorner.md),
                          borderSide: BorderSide(
                            color: colorScheme.primary,
                            width: 1.5,
                          ),
                        ),
                      ),
                      onSubmitted: (_) => _handleAddRule(),
                    ),
                    const SizedBox(height: 12),

                    // Route destination badge & Add button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // DIRECT route destination badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(AppCorner.sm),
                            border: Border.all(
                              color: const Color(0xFF10B981).withValues(alpha: 0.4),
                              width: 1,
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.alt_route_rounded,
                                size: 14,
                                color: Color(0xFF10B981),
                              ),
                              SizedBox(width: 6),
                              Text(
                                'DIRECT',
                                style: TextStyle(
                                  color: Color(0xFF10B981),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Add Button
                        FilledButton.icon(
                          onPressed: _handleAddRule,
                          icon: const Icon(Icons.add_rounded, size: 18),
                          label: Text(appLocalizations.add),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppCorner.md),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Glider / Divider separator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: colorScheme.outlineVariant.withValues(alpha: 0.3),
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      '${appLocalizations.rules} (${customRules.length})',
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: colorScheme.outlineVariant.withValues(alpha: 0.3),
                      thickness: 1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),

            // Rules List
            Expanded(
              child: customRules.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.playlist_add_check_rounded,
                              size: 48,
                              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              appLocalizations.noAddedRulesYet,
                              textAlign: TextAlign.center,
                              style: textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      itemCount: customRules.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final rule = customRules[index];
                        final isProcess = rule.ruleAction == RuleAction.PROCESS_NAME;
                        final typeLabel = isProcess
                            ? appLocalizations.ruleApp
                            : appLocalizations.ruleDomain;

                        return Container(
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(AppCorner.md),
                            border: Border.all(
                              color: colorScheme.outlineVariant.withValues(alpha: 0.2),
                              width: 1,
                            ),
                          ),
                          child: ListTile(
                            dense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 2,
                            ),
                            leading: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: (isProcess ? colorScheme.tertiary : colorScheme.primary)
                                    .withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(AppCorner.sm),
                              ),
                              child: Text(
                                typeLabel,
                                style: TextStyle(
                                  color: isProcess ? colorScheme.tertiary : colorScheme.primary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            title: Text(
                              rule.content ?? '',
                              style: textTheme.bodyMedium?.toJetBrainsMono.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              rule.ruleAction.value,
                              style: textTheme.labelSmall?.copyWith(
                                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                                fontFamily: 'monospace',
                                fontSize: 10,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF10B981).withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(AppCorner.sm),
                                  ),
                                  child: const Text(
                                    'DIRECT',
                                    style: TextStyle(
                                      color: Color(0xFF10B981),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'monospace',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete_outline_rounded,
                                    size: 20,
                                    color: colorScheme.error.withValues(alpha: 0.8),
                                  ),
                                  tooltip: appLocalizations.delete,
                                  onPressed: () => _handleDeleteRule(rule),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppPickerSheet extends ConsumerStatefulWidget {
  const _AppPickerSheet();

  @override
  ConsumerState<_AppPickerSheet> createState() => _AppPickerSheetState();
}

class _AppPickerSheetState extends ConsumerState<_AppPickerSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<_AppItem> _items = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadApps();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadApps() async {
    final list = <_AppItem>[];

    try {
      if (system.isAndroid) {
        final packages = await App().getPackages();
        for (final pkg in packages) {
          list.add(_AppItem(
            name: pkg.label.isNotEmpty ? pkg.label : pkg.packageName,
            identifier: pkg.packageName,
            isPackage: true,
          ));
        }
      } else {
        // Desktop (Linux / Windows / macOS)
        final processes = await _fetchDesktopProcesses();
        for (final p in processes) {
          list.add(_AppItem(
            name: p,
            identifier: p,
            isPackage: false,
          ));
        }
      }
    } catch (e) {
      commonPrint.log('Error loading apps/processes: $e');
    }

    if (mounted) {
      setState(() {
        _items = list;
        _loading = false;
      });
    }
  }

  Future<List<String>> _fetchDesktopProcesses() async {
    final processSet = <String>{};
    try {
      if (Platform.isLinux || Platform.isMacOS) {
        final res = await Process.run('ps', ['-eo', 'comm']);
        if (res.exitCode == 0) {
          final lines = (res.stdout as String).split('\n');
          for (final line in lines.skip(1)) {
            final name = line.trim();
            if (name.isNotEmpty && !name.startsWith('[') && !processSet.contains(name)) {
              processSet.add(name);
            }
          }
        }
      } else if (Platform.isWindows) {
        final res = await Process.run('tasklist', ['/FO', 'CSV', '/NH']);
        if (res.exitCode == 0) {
          final lines = (res.stdout as String).split('\n');
          for (final line in lines) {
            final trimmed = line.trim();
            if (trimmed.isEmpty) continue;
            final match = RegExp(r'^"([^"]+)"').firstMatch(trimmed);
            if (match != null) {
              final procName = match.group(1)!;
              if (procName.isNotEmpty) {
                processSet.add(procName);
              }
            }
          }
        }
      }
    } catch (e) {
      commonPrint.log('Failed to query processes via OS command: $e');
    }

    // Also include any active processes from requestsProvider
    final reqs = ref.read(requestsProvider).list;
    for (final req in reqs) {
      final proc = req.metadata.process;
      if (proc.isNotEmpty) {
        processSet.add(proc);
      }
    }

    final sorted = processSet.toList()..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.appLocalizations;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final query = _searchController.text.trim().toLowerCase();
    final filtered = query.isEmpty
        ? _items
        : _items.where((it) {
            return it.name.toLowerCase().contains(query) ||
                it.identifier.toLowerCase().contains(query);
          }).toList();

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.75,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppCorner.xxl),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 6),
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(AppCorner.full),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      appLocalizations.selectAppTitle,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: TextField(
                controller: _searchController,
                style: textTheme.bodyMedium,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
                  hintText: appLocalizations.searchAppHint,
                  prefixIcon: const Icon(Icons.search, size: 20),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 18),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                            });
                          },
                        )
                      : null,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppCorner.md),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (_) => setState(() {}),
              ),
            ),
            const SizedBox(height: 8),

            // Content
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : filtered.isEmpty
                      ? Center(
                          child: Text(
                            appLocalizations.noAddedRulesYet,
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            final item = filtered[index];
                            return ListTile(
                              dense: true,
                              leading: item.isPackage
                                  ? PackageIcon(
                                      packageName: item.identifier,
                                      size: 36,
                                    )
                                  : CircleAvatar(
                                      radius: 18,
                                      backgroundColor: colorScheme.primaryContainer,
                                      child: Icon(
                                        Icons.memory_rounded,
                                        size: 20,
                                        color: colorScheme.primary,
                                      ),
                                    ),
                              title: Text(
                                item.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                item.identifier,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.bodySmall?.toJetBrainsMono.copyWith(
                                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                                  fontSize: 11,
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).pop(item.identifier);
                              },
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppItem {
  final String name;
  final String identifier;
  final bool isPackage;

  const _AppItem({
    required this.name,
    required this.identifier,
    required this.isPackage,
  });
}
