import 'package:flutter/widgets.dart';

class ProxyCountryResolver {
  static const List<CountryEntry> _countries = [
    CountryEntry(
      patterns: ['Нидерланды', 'Netherlands', 'Holland', 'Nederland', 'Одерланды'],
      ru: 'Нидерланды',
      en: 'Netherlands',
      ja: 'オランダ',
      zh: '荷兰',
    ),
    CountryEntry(
      patterns: ['Польша', 'Poland', 'Polska'],
      ru: 'Польша',
      en: 'Poland',
      ja: 'ポーランド',
      zh: '波兰',
    ),
    CountryEntry(
      patterns: ['Германия', 'Germany', 'Deutschland'],
      ru: 'Германия',
      en: 'Germany',
      ja: 'ドイツ',
      zh: '德国',
    ),
    CountryEntry(
      patterns: ['Эстония', 'Estonia', 'Eesti'],
      ru: 'Эстония',
      en: 'Estonia',
      ja: 'エストニア',
      zh: '爱沙尼亚',
    ),
    CountryEntry(
      patterns: ['Швеция', 'Sweden', 'Sverige'],
      ru: 'Швеция',
      en: 'Sweden',
      ja: 'スウェーデン',
      zh: '瑞典',
    ),
    CountryEntry(
      patterns: ['Финляндия', 'Finland', 'Suomi'],
      ru: 'Финляндия',
      en: 'Finland',
      ja: 'フィンランド',
      zh: '芬兰',
    ),
    CountryEntry(
      patterns: ['Франция', 'France', 'Frankreich'],
      ru: 'Франция',
      en: 'France',
      ja: 'フランス',
      zh: '法国',
    ),
    CountryEntry(
      patterns: ['Великобритания', 'United Kingdom', 'Great Britain', 'England', 'Англия', 'UK'],
      ru: 'Великобритания',
      en: 'United Kingdom',
      ja: 'イギリス',
      zh: '英国',
    ),
    CountryEntry(
      patterns: ['США', 'USA', 'United States', 'Соединенные Штаты'],
      ru: 'США',
      en: 'USA',
      ja: 'アメリカ',
      zh: '美国',
    ),
    CountryEntry(
      patterns: ['Япония', 'Japan', 'Nippon'],
      ru: 'Япония',
      en: 'Japan',
      ja: '日本',
      zh: '日本',
    ),
    CountryEntry(
      patterns: ['Турция', 'Turkey', 'Türkiye'],
      ru: 'Турция',
      en: 'Turkey',
      ja: 'トルコ',
      zh: '土耳其',
    ),
    CountryEntry(
      patterns: ['Сингапур', 'Singapore'],
      ru: 'Сингапур',
      en: 'Singapore',
      ja: 'シンガポール',
      zh: '新加坡',
    ),
    CountryEntry(
      patterns: ['Казахстан', 'Kazakhstan'],
      ru: 'Казахстан',
      en: 'Kazakhstan',
      ja: 'カザフスタン',
      zh: '哈萨克斯坦',
    ),
    CountryEntry(
      patterns: ['Украина', 'Ukraine'],
      ru: 'Украина',
      en: 'Ukraine',
      ja: 'ウクライナ',
      zh: '乌克兰',
    ),
    CountryEntry(
      patterns: ['Канада', 'Canada'],
      ru: 'Канада',
      en: 'Canada',
      ja: 'カナダ',
      zh: '加拿大',
    ),
    CountryEntry(
      patterns: ['Швейцария', 'Switzerland'],
      ru: 'Швейцария',
      en: 'Switzerland',
      ja: 'スイス',
      zh: '瑞士',
    ),
    CountryEntry(
      patterns: ['Австрия', 'Austria'],
      ru: 'Австрия',
      en: 'Austria',
      ja: 'オーストリア',
      zh: '奥地利',
    ),
    CountryEntry(
      patterns: ['Испания', 'Spain', 'España'],
      ru: 'Испания',
      en: 'Spain',
      ja: 'スペイン',
      zh: '西班牙',
    ),
    CountryEntry(
      patterns: ['Италия', 'Italy', 'Italia'],
      ru: 'Италия',
      en: 'Italy',
      ja: 'イタリア',
      zh: '意大利',
    ),
  ];

  static String resolve(String originalText, Locale? locale) {
    if (originalText.isEmpty) return originalText;
    final langCode = locale?.languageCode.toLowerCase() ?? 'en';

    String result = originalText;
    for (final entry in _countries) {
      final targetTranslation = switch (langCode) {
        'ru' => entry.ru,
        'ja' => entry.ja,
        'zh' => entry.zh,
        _ => entry.en,
      };

      for (final pattern in entry.patterns) {
        final regExp = RegExp(RegExp.escape(pattern), caseSensitive: false);
        if (regExp.hasMatch(result)) {
          result = result.replaceAll(regExp, targetTranslation);
          return result;
        }
      }
    }

    return result;
  }
}

class CountryEntry {
  final List<String> patterns;
  final String ru;
  final String en;
  final String ja;
  final String zh;

  const CountryEntry({
    required this.patterns,
    required this.ru,
    required this.en,
    required this.ja,
    required this.zh,
  });
}
