import 'dart:async';
import 'dart:io';

import 'package:fl_clash/common/common.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class AppPath {
  static AppPath? _instance;
  Completer<Directory> dataDir = Completer();
  late final Future<Directory?> _downloadDir = downloadDirectory();
  Completer<Directory> tempDir = Completer();
  Completer<Directory> cacheDir = Completer();
  late String appDirPath;

  @visibleForTesting
  static Future<Directory> Function() supportDirectory =
      getApplicationSupportDirectory;

  @visibleForTesting
  static Future<Directory> Function() temporaryDirectory =
      getTemporaryDirectory;

  @visibleForTesting
  static Future<Directory> Function() cacheDirectory =
      getApplicationCacheDirectory;

  @visibleForTesting
  static Future<Directory?> Function() downloadDirectory =
      getDownloadsDirectory;

  AppPath._internal() {
    appDirPath = join(dirname(Platform.resolvedExecutable));
    supportDirectory().then((value) async {
      if (Platform.isLinux) {
        try {
          await _migrateLegacyLinuxDataDir(value);
        } catch (_) {}
      }
      dataDir.complete(value);
    });
    temporaryDirectory().then((value) {
      tempDir.complete(value);
    });
    cacheDirectory().then((value) {
      cacheDir.complete(value);
    });
  }

  factory AppPath() {
    _instance ??= AppPath._internal();
    return _instance!;
  }

  String get executableExtension {
    return system.isWindows ? '.exe' : '';
  }

  String get executableDirPath {
    final currentExecutablePath = Platform.resolvedExecutable;
    return dirname(currentExecutablePath);
  }

  String get bundledCorePath {
    return join(executableDirPath, 'FlClashCore$executableExtension');
  }

  static const String linuxExternalCorePath = '/opt/flclash/FlClashCore';

  String get corePath {
    if (system.isLinux) {
      if (File(linuxExternalCorePath).existsSync()) {
        return linuxExternalCorePath;
      }
    }
    return bundledCorePath;
  }

  String get helperPath {
    return join(executableDirPath, '$appHelperService$executableExtension');
  }

  Future<String> get downloadDirPath async {
    final directory = await _downloadDir;
    return directory?.path ?? await homeDirPath;
  }

  Future<String> get homeDirPath async {
    final directory = await dataDir.future;
    return directory.path;
  }

  Future<String> get databasePath async {
    final mHomeDirPath = await homeDirPath;
    return join(mHomeDirPath, 'database.sqlite');
  }

  Future<String> get backupFilePath async {
    final mHomeDirPath = await homeDirPath;
    return join(mHomeDirPath, 'backup.zip');
  }

  Future<String> get restoreDirPath async {
    final mHomeDirPath = await homeDirPath;
    return join(mHomeDirPath, 'restore');
  }

  Future<String> get tempFilePath async {
    final mTempDir = await tempDir.future;
    return join(mTempDir.path, 'temp$uniqueId');
  }

  Future<String> get lockFilePath async {
    final homeDirPath = await appPath.homeDirPath;
    return join(homeDirPath, 'FlClash.lock');
  }

  Future<String> get configFilePath async {
    final mHomeDirPath = await homeDirPath;
    return join(mHomeDirPath, 'config.yaml');
  }

  Future<String> get sharedPreferencesPath async {
    final directory = await dataDir.future;
    return join(directory.path, 'shared_preferences.json');
  }

  Future<String> get profilesPath async {
    final directory = await dataDir.future;
    return join(directory.path, profilesDirectoryName);
  }

  Future<String> getProfilePath(String fileName) async {
    return join(await profilesPath, '$fileName.yaml');
  }

  Future<String> get scriptsDirPath async {
    final path = await homeDirPath;
    return join(path, 'scripts');
  }

  Future<String> getScriptPath(String fileName) async {
    final path = await scriptsDirPath;
    return join(path, '$fileName.js');
  }

  Future<String> getProvidersRootPath() async {
    final directory = await profilesPath;
    return join(directory, providersDirectoryName);
  }

  Future<String> getProviderDirPath(int profileId, String type) async {
    final directory = await getProvidersRootPath();
    return join(directory, profileId.toString(), type);
  }

  Future<void> ensureProviderDirs(int profileId) async {
    for (final type in const [
      proxiesProviderDirectoryName,
      rulesProviderDirectoryName,
    ]) {
      final directory = Directory(await getProviderDirPath(profileId, type));
      if (await directory.exists()) {
        continue;
      }
      await directory.create(recursive: true);
    }
  }

  Future<String> get tempPath async {
    final directory = await tempDir.future;
    return directory.path;
  }

  static Future<void> _migrateLegacyLinuxDataDir(Directory targetDir) async {
    final parent = targetDir.parent;
    final legacyDir = Directory(join(parent.path, 'com.follow.clash'));
    if (!await legacyDir.exists()) {
      return;
    }

    if (!await targetDir.exists()) {
      await targetDir.create(recursive: true);
    }

    final targetEntities = targetDir.listSync();
    final hasExistingData = targetEntities.any((e) =>
        basename(e.path) == 'database.sqlite' ||
        basename(e.path) == 'config.yaml' ||
        basename(e.path) == 'profiles');

    if (hasExistingData) {
      return;
    }

    await _copyDirectory(legacyDir, targetDir);
  }

  static Future<void> _copyDirectory(Directory source, Directory destination) async {
    await for (final entity in source.list(recursive: false)) {
      final name = basename(entity.path);
      if (name.endsWith('.lock') || name.endsWith('.sock')) {
        continue;
      }
      final newPath = join(destination.path, name);
      if (entity is Directory) {
        final newDir = Directory(newPath);
        if (!await newDir.exists()) {
          await newDir.create(recursive: true);
        }
        await _copyDirectory(entity, newDir);
      } else if (entity is File) {
        try {
          await entity.copy(newPath);
        } catch (_) {}
      }
    }
  }

}

final appPath = AppPath();

String getBackupFileName() {
  return '${appName}_backup_${DateTime.now().show}.zip';
}

String get logFileName {
  return '${appName}_${DateTime.now().show}.log';
}
