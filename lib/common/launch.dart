import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:launch_at_startup/launch_at_startup.dart';

import 'constant.dart';
import 'system.dart';

class AutoLaunch {
  static AutoLaunch? _instance;

  AutoLaunch._internal() {
    final appPath =
        system.isLinux ? '/usr/local/bin/lievpn' : Platform.resolvedExecutable;
    launcher.setup(appName: appName, appPath: appPath);
  }

  factory AutoLaunch() {
    _instance ??= AutoLaunch._internal();
    return _instance!;
  }

  @visibleForTesting
  static LaunchAtStartup launcher = launchAtStartup;

  Future<bool> get isEnable async {
    return launcher.isEnabled();
  }

  Future<bool> enable() async {
    return launcher.enable();
  }

  Future<bool> disable() async {
    return launcher.disable();
  }

  Future<void> updateStatus(bool isAutoLaunch) async {
    if (kDebugMode) {
      return;
    }
    final isEnable = await this.isEnable;
    if (isAutoLaunch == isEnable) {
      return;
    }
    if (isAutoLaunch) {
      await enable();
      return;
    }
    await disable();
  }
}

final autoLaunch = AutoLaunch();
