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
      name: '@lllirap',
      amount: '907₽',
      avatarUrl: 'https://vpn.lie2srvv.com/top2.png',
    ),
    DonatorItem(
      rank: 3,
      name: '@Lana_590',
      amount: '800₽',
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
    final lastTime = sp?.getInt('donators_cache_time') ?? 0;

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

    final now = DateTime.now().millisecondsSinceEpoch;
    const dayMs = 24 * 60 * 60 * 1000;
    if (now - lastTime > dayMs || _donators.isEmpty) {
      await _fetchDonators();
    }
  }

  Future<void> _fetchDonators() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });

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
      final hofIndex = html.indexOf('id="hall-of-fame"');
      if (hofIndex == -1) return [];
      final hofSection = html.substring(hofIndex, (hofIndex + 4000).clamp(0, html.length));

      final items = <DonatorItem>[];

      // Top 1 (Throne)
      final top1Match = RegExp(
        r'throne-avatar.*?<span[^>]*>(.*?)<\/span>.*?<span[^>]*class="[^"]*font-bold[^"]*"[^>]*>(@\w+)<\/span>.*?<span[^>]*>(\d+₽)<\/span>',
        dotAll: true,
      ).firstMatch(hofSection);

      if (top1Match != null) {
        items.add(DonatorItem(
          rank: 1,
          title: top1Match.group(1)?.trim() ?? 'Царь Доната',
          name: top1Match.group(2)?.trim() ?? '@glebpozdner',
          amount: top1Match.group(3)?.trim() ?? '2360₽',
          avatarUrl: 'https://vpn.lie2srvv.com/top1.png',
        ));
      } else {
        items.add(_defaultDonators[0]);
      }

      // Top 2
      final top2Match = RegExp(
        r'src="top2\.png".*?<span[^>]*class="[^"]*font-semibold[^"]*"[^>]*>(@\w+)<\/span>.*?<span[^>]*>(\d+₽)<\/span>',
        dotAll: true,
      ).firstMatch(hofSection);
      if (top2Match != null) {
        items.add(DonatorItem(
          rank: 2,
          name: top2Match.group(1)?.trim() ?? '@lllirap',
          amount: top2Match.group(2)?.trim() ?? '907₽',
          avatarUrl: 'https://vpn.lie2srvv.com/top2.png',
        ));
      } else {
        items.add(_defaultDonators[1]);
      }

      // Top 3
      final top3Match = RegExp(
        r'src="top3\.png".*?<span[^>]*class="[^"]*font-semibold[^"]*"[^>]*>(@\w+)<\/span>.*?<span[^>]*>(\d+₽)<\/span>',
        dotAll: true,
      ).firstMatch(hofSection);
      if (top3Match != null) {
        items.add(DonatorItem(
          rank: 3,
          name: top3Match.group(1)?.trim() ?? '@Lana_590',
          amount: top3Match.group(2)?.trim() ?? '800₽',
          avatarUrl: 'https://vpn.lie2srvv.com/top3.png',
        ));
      } else {
        items.add(_defaultDonators[2]);
      }

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
    final top2 = _donators.firstWhere(
      (e) => e.rank == 2,
      orElse: () => _defaultDonators[1],
    );
    final top3 = _donators.firstWhere(
      (e) => e.rank == 3,
      orElse: () => _defaultDonators[2],
    );

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
            _buildRankCard(top2, isSilver: true),
            const SizedBox(height: 10),
            _buildRankCard(top3, isSilver: false),
            const SizedBox(height: 28),
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
