import 'dart:async';
import 'dart:io';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:flutter/foundation.dart';

/// Keeps two processes off one data directory. Raising the running window is
/// the platform's job: LaunchServices reopen, GApplication activation, or the
/// app_links hand-off in the Windows runner, backed by local IPC socket on Linux.
class SingleInstanceLock {
  static SingleInstanceLock? _instance;
  RandomAccessFile? _accessFile;
  ServerSocket? _ipcServer;

  SingleInstanceLock._internal();

  factory SingleInstanceLock() {
    _instance ??= SingleInstanceLock._internal();
    return _instance!;
  }

  @visibleForTesting
  static Future<String> Function() resolvePath = () => appPath.lockFilePath;

  Future<bool> acquire() async {
    try {
      final lockFilePath = await resolvePath();
      final lockFile = File(lockFilePath);
      await lockFile.create();
      _accessFile = await lockFile.open(mode: FileMode.write);
      await _accessFile?.lock();
      return true;
    } catch (e) {
      commonPrint.log(
        'single instance lock acquire failed ${e.toString()}',
        logLevel: LogLevel.warning,
      );
      return false;
    }
  }

  Future<void> startListening(void Function() onRestore) async {
    if (!Platform.isLinux) return;
    try {
      final homeDirPath = await appPath.homeDirPath;
      final socketPath = '$homeDirPath/single_instance.sock';
      final socketFile = File(socketPath);
      if (await socketFile.exists()) {
        try {
          await socketFile.delete();
        } catch (_) {}
      }
      _ipcServer = await ServerSocket.bind(
        InternetAddress(socketPath, type: InternetAddressType.unix),
        0,
      );
      _ipcServer?.listen((socket) {
        socket.listen((data) {
          final message = String.fromCharCodes(data).trim();
          if (message == 'restore') {
            onRestore();
          }
        });
      });
    } catch (e) {
      commonPrint.log(
        'Failed to start single instance IPC server: $e',
        logLevel: LogLevel.warning,
      );
    }
  }

  Future<void> notifyRunningInstance() async {
    if (!Platform.isLinux) return;
    try {
      final homeDirPath = await appPath.homeDirPath;
      final socketPath = '$homeDirPath/single_instance.sock';
      final socketFile = File(socketPath);
      if (!await socketFile.exists()) return;
      final socket = await Socket.connect(
        InternetAddress(socketPath, type: InternetAddressType.unix),
        0,
        timeout: const Duration(milliseconds: 500),
      );
      socket.write('restore\n');
      await socket.flush();
      await socket.close();
      socket.destroy();
    } catch (e) {
      commonPrint.log(
        'Failed to notify running instance: $e',
        logLevel: LogLevel.warning,
      );
    }
  }

  @visibleForTesting
  Future<void> release() async {
    try {
      await _ipcServer?.close();
    } catch (_) {}
    _ipcServer = null;
    await _accessFile?.close();
    _accessFile = null;
  }
}

final singleInstanceLock = SingleInstanceLock();
