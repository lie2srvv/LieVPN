import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:fl_clash/common/proxy_country_resolver.dart';

void main() {
  group('ProxyCountryResolver tests', () {
    test('Translates standard Russian country names to English and Japanese', () {
      expect(ProxyCountryResolver.resolve('Нидерланды 01', const Locale('en')), 'Netherlands 01');
      expect(ProxyCountryResolver.resolve('Нидерланды 01', const Locale('ja')), 'オランダ 01');
      expect(ProxyCountryResolver.resolve('Польша VIP', const Locale('en')), 'Poland VIP');
      expect(ProxyCountryResolver.resolve('Германия', const Locale('ja')), 'ドイツ');
    });

    test('Preserves emoji flags and prefixes/suffixes', () {
      expect(ProxyCountryResolver.resolve('🇳🇱 [NL] Нидерланды #1', const Locale('en')), '🇳🇱 [NL] Netherlands #1');
      expect(ProxyCountryResolver.resolve('🇩🇪 Германия Ultra', const Locale('ja')), '🇩🇪 ドイツ Ultra');
      expect(ProxyCountryResolver.resolve('🇸🇪 Sweden Fast', const Locale('ru')), '🇸🇪 Швеция Fast');
    });

    test('Translates English country names to Russian when Russian locale is active', () {
      expect(ProxyCountryResolver.resolve('Netherlands 01', const Locale('ru')), 'Нидерланды 01');
      expect(ProxyCountryResolver.resolve('Germany #5', const Locale('ru')), 'Германия #5');
      expect(ProxyCountryResolver.resolve('Poland Premium', const Locale('ru')), 'Польша Premium');
    });

    test('Leaves unknown server names unchanged', () {
      expect(ProxyCountryResolver.resolve('CustomNode-XYZ', const Locale('en')), 'CustomNode-XYZ');
    });
  });
}
