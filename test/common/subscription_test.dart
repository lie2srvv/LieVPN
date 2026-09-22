import 'dart:convert';
import 'dart:typed_data';
import 'package:fl_clash/common/subscription.dart';
import 'package:fl_clash/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LieVPN Subscription URL validation', () {
    test('accepts valid LieVPN URLs', () {
      expect(
        isValidLieVpnSubscriptionUrl('https://vpn.lie2srvv.com/sub/abcdef123'),
        isTrue,
      );
      expect(
        isValidLieVpnSubscriptionUrl('https://vpn.lie2srvv.com/token123'),
        isTrue,
      );
      expect(
        isValidLieVpnSubscriptionUrl('http://vpn.lie2srvv.com/user/config'),
        isTrue,
      );
    });

    test('rejects invalid, external, or root URLs', () {
      expect(isValidLieVpnSubscriptionUrl('https://vpn.lie2srvv.com'), isFalse);
      expect(
        isValidLieVpnSubscriptionUrl('https://vpn.lie2srvv.com/'),
        isFalse,
      );
      expect(
        isValidLieVpnSubscriptionUrl('https://google.com/test'),
        isFalse,
      );
      expect(isValidLieVpnSubscriptionUrl('not a url'), isFalse);
      expect(isValidLieVpnSubscriptionUrl(''), isFalse);
    });
  });

  group('Extract LieVPN URL from text/clipboard', () {
    test('finds url in mixed text', () {
      const text =
          'Here is your subscription: https://vpn.lie2srvv.com/mytoken please enjoy';
      expect(
        extractLieVpnUrl(text),
        'https://vpn.lie2srvv.com/mytoken',
      );
    });

    test('returns null for text without LieVPN url', () {
      expect(extractLieVpnUrl('hello world 123'), isNull);
      expect(extractLieVpnUrl('https://other-vpn.com/sub'), isNull);
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

      final status = getSubscriptionExpiryStatus(profile);
      expect(status.isExpired, isTrue);
      expect(status.dynamicWarningText, contains('истек'));
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

      final status = getSubscriptionExpiryStatus(profile);
      expect(status.isExpired, isFalse);
      expect(status.isExpiringSoon, isFalse);
    });

    test('computes smart dynamic warning text for expiring subscription', () {
      // 2 days remaining
      final twoDaysTimestamp =
          (DateTime.now().millisecondsSinceEpoch ~/ 1000) + 86400 * 2 + 3600;
      final profile2Days = Profile.normal(
        url: 'https://vpn.lie2srvv.com/sub123',
      ).copyWith(
        subscriptionInfo: SubscriptionInfo(expire: twoDaysTimestamp),
      );
      final status2Days = getSubscriptionExpiryStatus(profile2Days);
      expect(status2Days.isExpiringSoon, isTrue);
      expect(status2Days.remainingDays, 2);
      expect(status2Days.dynamicWarningText, contains('через 2 дня'));

      // 1 day remaining
      final oneDayTimestamp =
          (DateTime.now().millisecondsSinceEpoch ~/ 1000) + 86400 * 1 + 3600;
      final profile1Day = Profile.normal(
        url: 'https://vpn.lie2srvv.com/sub123',
      ).copyWith(
        subscriptionInfo: SubscriptionInfo(expire: oneDayTimestamp),
      );
      final status1Day = getSubscriptionExpiryStatus(profile1Day);
      expect(status1Day.isExpiringSoon, isTrue);
      expect(status1Day.remainingDays, 1);
      expect(status1Day.dynamicWarningText, contains('через 1 день'));
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
