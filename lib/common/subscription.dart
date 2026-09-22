import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:fl_clash/models/models.dart';
import 'package:yaml/yaml.dart';

/// Validates whether the given URL string points to a valid LieVPN subscription endpoint.
bool isValidLieVpnSubscriptionUrl(String url) {
  var target = url.trim();
  if (target.isEmpty) return false;
  if (!target.startsWith('http://') && !target.startsWith('https://')) {
    target = 'https://$target';
  }
  final uri = Uri.tryParse(target);
  if (uri == null || uri.host.toLowerCase() != 'vpn.lie2srvv.com') {
    return false;
  }
  final path = uri.path.trim();
  if (path.isEmpty || path == '/' || path == '/index.html') {
    return false;
  }
  return true;
}

/// Checks if the given profile has a valid LieVPN subscription URL.
bool isLieVpnSubscription(Profile? profile) {
  if (profile == null) return false;
  return isValidLieVpnSubscriptionUrl(profile.url);
}

/// Extracts a LieVPN subscription URL from raw input or clipboard text.
String? extractLieVpnUrl(String text) {
  final trimmed = text.trim();
  if (trimmed.isEmpty) return null;
  final regex = RegExp(
    r'https?://vpn\.lie2srvv\.com[^\s]*',
    caseSensitive: false,
  );
  final match = regex.firstMatch(trimmed);
  if (match != null) {
    final candidate = match.group(0)!;
    if (isValidLieVpnSubscriptionUrl(candidate)) {
      return candidate;
    }
  }
  final noProtoRegex = RegExp(
    r'(?:^|\s)(vpn\.lie2srvv\.com[^\s]*)',
    caseSensitive: false,
  );
  final noProtoMatch = noProtoRegex.firstMatch(trimmed);
  if (noProtoMatch != null) {
    final candidate = 'https://${noProtoMatch.group(1)}';
    if (isValidLieVpnSubscriptionUrl(candidate)) {
      return candidate;
    }
  }
  return null;
}

/// Checks whether the profile's subscription has expired based on subscriptionInfo.expire.
bool isSubscriptionExpired(Profile? profile) {
  if (profile == null) return false;
  final expire = profile.subscriptionInfo?.expire;
  if (expire == null || expire <= 0) return false;
  final expireDate = DateTime.fromMillisecondsSinceEpoch(expire * 1000);
  return expireDate.isBefore(DateTime.now());
}

/// Representation of subscription expiry information with dynamic days/hours count.
class SubscriptionExpiryStatus {
  final bool hasExpire;
  final bool isExpired;
  final bool isExpiringSoon;
  final int remainingDays;
  final int remainingHours;
  final String dynamicWarningText;

  const SubscriptionExpiryStatus({
    required this.hasExpire,
    required this.isExpired,
    required this.isExpiringSoon,
    required this.remainingDays,
    required this.remainingHours,
    required this.dynamicWarningText,
  });
}

/// Computes dynamic subscription expiration status and formatted Russian warning message.
SubscriptionExpiryStatus getSubscriptionExpiryStatus(Profile? profile) {
  final expire = profile?.subscriptionInfo?.expire;
  if (expire == null || expire <= 0) {
    return const SubscriptionExpiryStatus(
      hasExpire: false,
      isExpired: false,
      isExpiringSoon: false,
      remainingDays: 0,
      remainingHours: 0,
      dynamicWarningText: '',
    );
  }

  final expireDate = DateTime.fromMillisecondsSinceEpoch(expire * 1000);
  final now = DateTime.now();
  final diff = expireDate.difference(now);

  if (diff.isNegative) {
    return const SubscriptionExpiryStatus(
      hasExpire: true,
      isExpired: true,
      isExpiringSoon: false,
      remainingDays: 0,
      remainingHours: 0,
      dynamicWarningText: 'Срок действия подписки истек',
    );
  }

  final days = diff.inDays;
  final hours = diff.inHours;
  final minutes = diff.inMinutes;
  final isExpiringSoon = diff.inSeconds <= 3 * 86400; // <= 3 days

  String timeText;
  if (days >= 1) {
    final daySuffix = (days == 1) ? 'день' : 'дня';
    timeText = '$days $daySuffix';
  } else if (hours >= 1) {
    final mod10 = hours % 10;
    final mod100 = hours % 100;
    final hourSuffix = (mod10 == 1 && mod100 != 11)
        ? 'час'
        : ([2, 3, 4].contains(mod10) && ![12, 13, 14].contains(mod100))
            ? 'часа'
            : 'часов';
    timeText = '$hours $hourSuffix';
  } else if (minutes > 0) {
    timeText = '$minutes мин.';
  } else {
    timeText = 'менее минуты';
  }

  return SubscriptionExpiryStatus(
    hasExpire: true,
    isExpired: false,
    isExpiringSoon: isExpiringSoon,
    remainingDays: days,
    remainingHours: hours,
    dynamicWarningText: 'Подписка заканчивается через $timeText',
  );
}

/// Checks if Clash YAML config bytes contain at least one valid proxy or proxy-provider.
bool checkHasProxies(Uint8List bytes) {
  try {
    final content = utf8.decode(bytes, allowMalformed: true);
    final dynamic doc = loadYaml(content);
    if (doc is Map) {
      final proxies = doc['proxies'];
      if (proxies is List && proxies.isNotEmpty) {
        return true;
      }
      final proxyProviders = doc['proxy-providers'];
      if (proxyProviders is Map && proxyProviders.isNotEmpty) {
        return true;
      }
    }
  } catch (_) {}
  return false;
}

/// Verifies whether a profile file on disk actually contains proxies.
bool profileFileHasProxies(File file) {
  try {
    if (!file.existsSync()) return false;
    final bytes = file.readAsBytesSync();
    return checkHasProxies(bytes);
  } catch (_) {
    return false;
  }
}

/// Checks whether a profile has an active, valid, non-expired LieVPN subscription.
bool hasActiveLieVpnSubscription(Profile? profile) {
  if (profile == null) return false;
  if (!isLieVpnSubscription(profile)) return false;
  if (isSubscriptionExpired(profile)) return false;
  return true;
}
