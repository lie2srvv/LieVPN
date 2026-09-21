import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';

import 'print.dart';
import 'protocol.dart';

typedef InstallConfigCallBack = void Function(String url);

class LinkManager {
  static LinkManager? _instance;
  StreamSubscription? subscription;
  Uri? _pendingUri;
  String? _lastHandledUrl;
  DateTime? _lastHandledTime;

  LinkManager._internal();

  @visibleForTesting
  Stream<Uri> Function() uriLinkStream = () => AppLinks().uriLinkStream;

  /// Linux argv: the gtk plugin hooks GApplication too late to see it.
  void seedInitialLink(List<String> args) {
    for (final arg in args) {
      final uri = Uri.tryParse(arg);
      if (uri != null &&
          (protocolSchemes.contains(uri.scheme) ||
              uri.scheme == 'http' ||
              uri.scheme == 'https')) {
        _pendingUri = uri;
        return;
      }
    }
  }

  Future<void> initAppLinksListen(
    Function(String url) installConfigCallBack,
  ) async {
    commonPrint.log('initAppLinksListen');
    destroy();
    subscription = uriLinkStream().listen((uri) {
      _handle(uri, installConfigCallBack);
    });
    final pending = _pendingUri;
    _pendingUri = null;
    if (pending != null) {
      _handle(pending, installConfigCallBack);
    }
    try {
      final initialUri = await AppLinks().getInitialLink();
      if (initialUri != null) {
        _handle(initialUri, installConfigCallBack);
      }
    } catch (_) {}
  }

  void _handle(Uri uri, Function(String url) installConfigCallBack) {
    commonPrint.log('onAppLink: $uri');
    String? targetUrl;
    if (uri.host == 'install-config') {
      targetUrl = uri.queryParameters['url'];
    } else if ((uri.scheme == 'http' || uri.scheme == 'https') &&
        (uri.host == 'vpn.lie2srvv.com' || uri.path.startsWith('/sub'))) {
      targetUrl = uri.toString();
    } else if (protocolSchemes.contains(uri.scheme)) {
      targetUrl = uri.queryParameters['url'] ?? (uri.path.isNotEmpty ? uri.path : null);
    }

    if (targetUrl == null || targetUrl.trim().isEmpty) {
      return;
    }

    final trimmedUrl = targetUrl.trim();
    final now = DateTime.now();
    if (_lastHandledUrl == trimmedUrl &&
        _lastHandledTime != null &&
        now.difference(_lastHandledTime!) < const Duration(seconds: 2)) {
      return;
    }
    _lastHandledUrl = trimmedUrl;
    _lastHandledTime = now;

    installConfigCallBack(trimmedUrl);
  }

  void destroy() {
    if (subscription != null) {
      subscription?.cancel();
      subscription = null;
    }
  }

  factory LinkManager() {
    _instance ??= LinkManager._internal();
    return _instance!;
  }
}

final linkManager = LinkManager();
