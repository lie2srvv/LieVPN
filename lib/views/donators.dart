import 'dart:convert';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/widgets/scaffold.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class DonatorItem {
  final int rank;
  final String name;
  final String amount;
  final String avatarUrl;
  final String? title;

  const DonatorItem({
    required this.rank,
    required this.name,
    required this.amount,
    required this.avatarUrl,
    this.title,
  });

  Map<String, dynamic> toJson() => {
        'rank': rank,
        'name': name,
        'amount': amount,
        'avatarUrl': avatarUrl,
        'title': title,
      };

  factory DonatorItem.fromJson(Map<String, dynamic> json) => DonatorItem(
        rank: json['rank'] as int? ?? 1,
        name: json['name'] as String? ?? '',
        amount: json['amount'] as String? ?? '',
        avatarUrl: json['avatarUrl'] as String? ?? '',
        title: json['title'] as String?,
      );
}

class DonatorsView extends ConsumerStatefulWidget {
  const DonatorsView({super.key});

  @override
  ConsumerState<DonatorsView> createState() => _DonatorsViewState();
}

class _DonatorsViewState extends ConsumerState<DonatorsView> {
  static const _defaultDonators = [
    DonatorItem(
      rank: 1,
      name: '@glebpozdner',
      amount: '2360₽',
      avatarUrl: 'https://vpn.lie2srvv.com/top1.png',
      title: 'Царь Доната',
    ),
    DonatorItem(
      rank: 2,
      name: '@Ite_ph_ps',
      amount: '1250₽',
      avatarUrl: 'https://vpn.lie2srvv.com/top2.png',
    ),
    DonatorItem(
      rank: 3,
      name: '@Lllirap',
      amount: '907₽',
      avatarUrl: 'https://vpn.lie2srvv.com/top3.png',
    ),
  ];

  List<DonatorItem> _donators = _defaultDonators;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCacheAndCheck();
  }

  Future<void> _loadCacheAndCheck() async {
    final sp = await preferences.sharedPreferencesCompleter.future;
    final cachedJson = sp?.getString('donators_cache_json');

    if (cachedJson != null && cachedJson.isNotEmpty) {
      try {
        final List list = json.decode(cachedJson);
        final cachedItems = list.map((e) => DonatorItem.fromJson(e)).toList();
        if (cachedItems.isNotEmpty && mounted) {
          setState(() {
            _donators = cachedItems;
          });
        }
      } catch (e) {
        commonPrint.log('Donators cache parse error: $e');
      }
    }

    // Always fetch fresh data on screen open
    await _fetchDonators();
  }

  Future<void> _fetchDonators() async {
    if (_isLoading) return;
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }

    try {
      final response = await request.dio.get<String>(
        'https://vpn.lie2srvv.com/',
      );
      final html = response.data ?? '';
      final parsed = _parseDonatorsHtml(html);
      if (parsed.isNotEmpty) {
        if (mounted) {
          setState(() {
            _donators = parsed;
          });
        }
        final sp = await preferences.sharedPreferencesCompleter.future;
        await sp?.setString(
          'donators_cache_json',
          json.encode(parsed.map((e) => e.toJson()).toList()),
        );
        await sp?.setInt(
          'donators_cache_time',
          DateTime.now().millisecondsSinceEpoch,
        );
      }
    } catch (e) {
      commonPrint.log('Failed to fetch donators: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  List<DonatorItem> _parseDonatorsHtml(String html) {
    try {
      final hofRegex = RegExp(
        r'id=["\x27]hall-of-fame["\x27]|Зал\s+[Сс]лавы',
        caseSensitive: false,
      );
      final hofMatch = hofRegex.firstMatch(html);
      if (hofMatch == null) return [];

      final startIndex = hofMatch.start;
      final sectionEnd = html.indexOf('</section>', startIndex);
      final hofSection = sectionEnd != -1
          ? html.substring(startIndex, sectionEnd)
          : html.substring(startIndex, (startIndex + 25000).clamp(0, html.length));

      final items = <DonatorItem>[];

      // 1. Top 1 (Throne)
      final throneIndex = hofSection.indexOf('throne-card');
      if (throneIndex != -1) {
        final throneEnd = hofSection.indexOf('grid', throneIndex);
        final throneHtml = throneEnd != -1
            ? hofSection.substring(throneIndex, throneEnd)
            : hofSection.substring(throneIndex);

        final titleMatch = RegExp(r'<span[^>]*uppercase[^>]*>([^<]+)</span>').firstMatch(throneHtml);
        final title = titleMatch?.group(1)?.trim() ?? 'Царь Доната';

        final nameMatch = RegExp(r'<span[^>]*font-bold[^>]*>([^<]+)</span>').firstMatch(throneHtml) ??
            RegExp(r'>\s*(@[^\s<]+)\s*<').firstMatch(throneHtml);
        final name = nameMatch?.group(1)?.trim();

        final amtMatch = RegExp(r'>\s*(\d[\d\s]*[₽\w]+)\s*<').firstMatch(throneHtml);
        final amt = amtMatch?.group(1)?.trim();

        final avMatch = RegExp(r'<img[^>]*src=["\x27]([^"\x27]+)["\x27]').firstMatch(throneHtml);
        var av = avMatch?.group(1)?.trim() ?? 'top1.png';
        if (!av.startsWith('http')) {
          av = 'https://vpn.lie2srvv.com/${av.replaceAll(RegExp(r'^\.?\/'), '')}';
        }

        if (name != null && amt != null) {
          items.add(DonatorItem(
            rank: 1,
            title: title,
            name: name,
            amount: amt,
            avatarUrl: av,
          ));
        }
      }

      if (items.isEmpty) {
        items.add(_defaultDonators[0]);
      }

      // 2. Liquid glass cards (Top 2, 3, etc.)
      final cardChunks = hofSection.split(RegExp(r'<div[^>]*class=["\x27][^"\x27]*liquid-glass'));
      if (cardChunks.length > 1) {
        for (var i = 1; i < cardChunks.length; i++) {
          final chunk = cardChunks[i];

          final rankMatch = RegExp(r'rank-badge[^>]*>(\d+)</span>').firstMatch(chunk);
          final rank = rankMatch != null ? int.tryParse(rankMatch.group(1) ?? '') ?? (i + 1) : (i + 1);

          final nameMatch = RegExp(r'<span[^>]*font-semibold[^>]*>([^<]+)</span>').firstMatch(chunk) ??
              RegExp(r'>\s*(@[^\s<]+)\s*<').firstMatch(chunk);
          final name = nameMatch?.group(1)?.trim();

          final amtMatch = RegExp(r'<span[^>]*font-mono[^>]*>([^<]+)</span>').firstMatch(chunk) ??
              RegExp(r'>\s*(\d[\d\s]*[₽\w]+)\s*<').firstMatch(chunk);
          final amt = amtMatch?.group(1)?.trim();

          final avMatch = RegExp(r'<img[^>]*src=["\x27]([^"\x27]+)["\x27]').firstMatch(chunk);
          var av = avMatch?.group(1)?.trim() ?? 'top$rank.png';
          if (!av.startsWith('http')) {
            av = 'https://vpn.lie2srvv.com/${av.replaceAll(RegExp(r'^\.?\/'), '')}';
          }

          if (name != null && amt != null) {
            items.add(DonatorItem(
              rank: rank,
              name: name,
              amount: amt,
              avatarUrl: av,
            ));
          }
        }
      }

      if (!items.any((e) => e.rank == 2)) {
        items.add(_defaultDonators[1]);
      }
      if (!items.any((e) => e.rank == 3)) {
        items.add(_defaultDonators[2]);
      }

      items.sort((a, b) => a.rank.compareTo(b.rank));
      return items;
    } catch (e) {
      commonPrint.log('Error parsing donators html: $e');
      return [];
    }
  }

  Widget _buildTop1Card(DonatorItem item) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFF59E0B).withValues(alpha: 0.18),
            const Color(0xFFD97706).withValues(alpha: 0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppCorner.xl),
        border: Border.all(
          color: const Color(0xFFF59E0B).withValues(alpha: 0.4),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.workspace_premium_rounded,
                color: Color(0xFFFACC15),
                size: 20,
              ),
              const SizedBox(width: 6),
              Text(
                item.title ?? 'Царь Доната',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFACC15),
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFFACC15),
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFACC15).withValues(alpha: 0.35),
                      blurRadius: 18,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.network(
                    item.avatarUrl,
                    key: ValueKey('${item.avatarUrl}_${item.name}'),
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => const Icon(
                      Icons.person,
                      size: 40,
                      color: Color(0xFFFACC15),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            item.name,
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.amount,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFDE68A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRankCard(DonatorItem item, {required bool isSilver}) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final badgeColor = isSilver ? const Color(0xFFE2E8F0) : const Color(0xFFF97316);
    final badgeBg = isSilver
        ? const Color(0xFF94A3B8).withValues(alpha: 0.25)
        : const Color(0xFFEA580C).withValues(alpha: 0.25);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppCorner.lg),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: badgeColor.withValues(alpha: 0.6),
                width: 2,
              ),
            ),
            child: ClipOval(
              child: Image.network(
                item.avatarUrl,
                key: ValueKey('${item.avatarUrl}_${item.name}'),
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Icon(
                  Icons.person,
                  size: 24,
                  color: badgeColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.name,
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  item.amount,
                  style: textTheme.bodySmall?.copyWith(
                    fontFamily: 'monospace',
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: badgeBg,
              border: Border.all(color: badgeColor.withValues(alpha: 0.5)),
            ),
            alignment: Alignment.center,
            child: Text(
              '${item.rank}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: badgeColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.appLocalizations;
    final top1 = _donators.firstWhere(
      (e) => e.rank == 1,
      orElse: () => _defaultDonators[0],
    );
    final otherDonators = _donators.where((e) => e.rank > 1).toList()
      ..sort((a, b) => a.rank.compareTo(b.rank));

    return CommonScaffold(
      title: appLocalizations.donators,
      body: RefreshIndicator(
        onRefresh: _fetchDonators,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16)
              .copyWith(bottom: 32),
          children: [
            _buildTop1Card(top1),
            const SizedBox(height: 14),
            ...otherDonators.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _buildRankCard(item, isSilver: item.rank == 2),
                )),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton.icon(
                onPressed: () {
                  launchUrl(
                    Uri.parse('https://t.me/liesubbot'),
                    mode: LaunchMode.externalApplication,
                  );
                },
                icon: const Icon(Icons.favorite_rounded, color: Colors.white),
                label: Text(appLocalizations.supportProject),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppCorner.md),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
