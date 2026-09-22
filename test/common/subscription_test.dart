import 'dart:convert';
import 'dart:typed_data';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LieVPN Subscription URL validation', () {
    test('accepts valid LieVPN URLs', () {
      expect(
        isValidLieVpnSubscriptionUrl('https://vpn.lie2srvv.com/token_abc123'),
        isTrue,
      );
      expect(
        isValidLieVpnSubscriptionUrl('http://vpn.lie2srvv.com/user_profile'),
        isTrue,
      );
      expect(
        isValidLieVpnSubscriptionUrl('vpn.lie2srvv.com/key_987'),
        isTrue,
      );
    });

    test('rejects invalid, external, or root URLs', () {
      expect(isValidLieVpnSubscriptionUrl(''), isFalse);
      expect(isValidLieVpnSubscriptionUrl('not a url'), isFalse);
      expect(isValidLieVpnSubscriptionUrl('https://other.com/token'), isFalse);
      expect(isValidLieVpnSubscriptionUrl('https://vpn.lie2srvv.com'), isFalse);
      expect(isValidLieVpnSubscriptionUrl('https://vpn.lie2srvv.com/'), isFalse);
      expect(
        isValidLieVpnSubscriptionUrl('https://vpn.lie2srvv.com/index.html'),
        isFalse,
      );
    });
  });

  group('Extract LieVPN URL from text/clipboard', () {
    test('finds url in mixed text', () {
      final text =
          'Привет, твоя подписка: https://vpn.lie2srvv.com/sub_token_123 приятного пользования';
      expect(
        extractLieVpnUrl(text),
        equals('https://vpn.lie2srvv.com/sub_token_123'),
      );
    });

    test('returns null for text without LieVPN url', () {
      expect(extractLieVpnUrl('Some random text without links'), isNull);
      expect(extractLieVpnUrl('https://google.com/test'), isNull);
    });
  });

  group('Subscription expiration', () {
    test('detects expired profile', () {
      final pastTimestamp =
          (DateTime.now().millisecondsSinceEpoch ~/ 1000) - 3600;
      final profile = Profile.normal(
        url: 'https://vpn.lie2srvv.com/sub123',
      ).copyWith(
        subscriptionInfo: SubscriptionInfo(expire: pastTimestamp),
      );
      expect(isSubscriptionExpired(profile), isTrue);
      expect(hasActiveLieVpnSubscription(profile), isFalse);
    });

    test('detects active profile', () {
      final futureTimestamp =
          (DateTime.now().millisecondsSinceEpoch ~/ 1000) + 86400 * 30;
      final profile = Profile.normal(
        url: 'https://vpn.lie2srvv.com/sub123',
      ).copyWith(
        subscriptionInfo: SubscriptionInfo(expire: futureTimestamp),
      );
      expect(isSubscriptionExpired(profile), isFalse);
      expect(hasActiveLieVpnSubscription(profile), isTrue);
    });
  });

  group('Proxy presence check in YAML', () {
    test('returns true when proxies exist', () {
      final yamlStr = '''
port: 7890
mode: rule
proxies:
  - name: "Node 1"
    type: vless
    server: 1.2.3.4
    port: 443
''';
      expect(
        checkHasProxies(Uint8List.fromList(utf8.encode(yamlStr))),
        isTrue,
      );
    });

    test('returns true when proxy-providers exist', () {
      final yamlStr = '''
port: 7890
proxy-providers:
  provider1:
    type: http
    url: "https://example.com"
''';
      expect(
        checkHasProxies(Uint8List.fromList(utf8.encode(yamlStr))),
        isTrue,
      );
    });

    test('returns false when proxies is empty or gibberish', () {
      final emptyProxies = '''
port: 7890
mode: rule
proxies: []
''';
      expect(
        checkHasProxies(Uint8List.fromList(utf8.encode(emptyProxies))),
        isFalse,
      );

      final gibberish = '<html><head><title>404</title></head></html>';
      expect(
        checkHasProxies(Uint8List.fromList(utf8.encode(gibberish))),
        isFalse,
      );
    });
  });
}
