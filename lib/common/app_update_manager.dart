import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';

class AppUpdateInfo {
  final String version;
  final String downloadUrl;
  final String? releaseNotes;

  const AppUpdateInfo({
    required this.version,
    required this.downloadUrl,
    this.releaseNotes,
  });

  /// Parses platform-specific update info with fallback to legacy flat format
  factory AppUpdateInfo.fromPlatformJson(Map<String, dynamic> json) {
    String platformKey;
    String defaultUrl;
    if (Platform.isAndroid) {
      platformKey = 'android';
      defaultUrl = 'https://clck.lie2srvv.com/files/lievpn.apk';
    } else if (Platform.isWindows) {
      platformKey = 'windows';
      defaultUrl = 'https://clck.lie2srvv.com/files/LieVPN-Windows.zip';
    } else if (Platform.isLinux) {
      platformKey = 'linux';
      defaultUrl = 'https://clck.lie2srvv.com/files/LieVPN-Linux.AppImage';
    } else {
      platformKey = 'other';
      defaultUrl = 'https://clck.lie2srvv.com/files/lievpn.apk';
    }

    if (json[platformKey] is Map<String, dynamic>) {
      final pMap = json[platformKey] as Map<String, dynamic>;
      return AppUpdateInfo(
        version: pMap['version'] as String? ?? json['version'] as String? ?? '1.0.0',
        downloadUrl: pMap['url'] as String? ?? defaultUrl,
        releaseNotes: pMap['releaseNotes'] as String? ?? json['releaseNotes'] as String?,
      );
    }

    // Legacy fallback
    final legacyUrl = Platform.isWindows
        ? (json['windowsUrl'] as String? ?? defaultUrl)
        : Platform.isLinux
            ? (json['linuxUrl'] as String? ?? defaultUrl)
            : (json['apkUrl'] as String? ?? defaultUrl);

    return AppUpdateInfo(
      version: json['version'] as String? ?? '1.0.0',
      downloadUrl: legacyUrl,
      releaseNotes: json['releaseNotes'] as String?,
    );
  }
}

class AppUpdateManager {
  static const String _versionUrl = 'https://clck.lie2srvv.com/files/version.json';

  static bool isNewerVersion(String latest, String current) {
    final l = latest
        .replaceFirst(RegExp(r'^[vV]'), '')
        .split('.')
        .map((e) => int.tryParse(e) ?? 0)
        .toList();
    final c = current
        .replaceFirst(RegExp(r'^[vV]'), '')
        .split('.')
        .map((e) => int.tryParse(e) ?? 0)
        .toList();

    while (l.length < 3) {
      l.add(0);
    }
    while (c.length < 3) {
      c.add(0);
    }

    for (int i = 0; i < 3; i++) {
      if (l[i] > c[i]) return true;
      if (l[i] < c[i]) return false;
    }
    return false;
  }

  static Future<AppUpdateInfo?> fetchUpdate() async {
    try {
      final dio = Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 6),
          receiveTimeout: const Duration(seconds: 8),
        ),
      );

      final response = await dio.get<Map<String, dynamic>>(
        _versionUrl,
        options: Options(responseType: ResponseType.json),
      );

      if (response.statusCode == 200 && response.data != null) {
        final updateInfo = AppUpdateInfo.fromPlatformJson(response.data!);
        final currentVersion = globalState.packageInfo.version;
        if (isNewerVersion(updateInfo.version, currentVersion)) {
          return updateInfo;
        }
      }
    } catch (_) {}
    return null;
  }

  /// Automatically triggered on application startup
  static Future<void> autoCheckUpdate(WidgetRef ref) async {
    final autoCheck = ref.read(appSettingProvider).autoCheckUpdate;
    if (!autoCheck) return;

    // Wait 3 seconds after startup to not compete with network initialization
    await Future.delayed(const Duration(seconds: 3));

    final update = await fetchUpdate();
    if (update != null) {
      final loc = currentAppLocalizations;

      dialogs.showNotifier(
        loc.newVersionAvailable(update.version),
        level: MessageLevel.info,
        actionState: MessageActionState(
          actionText: loc.updateNow,
          action: () {
            final activeContext = globalState.navigatorKey.currentContext;
            if (activeContext != null && activeContext.mounted) {
              showUpdateDialog(activeContext, update);
            }
          },
        ),
      );
    }
  }

  /// Manually triggered from Tools -> Other -> Check Updates
  static Future<void> manualCheckUpdate(BuildContext context) async {
    final loc = context.appLocalizations;
    context.showNotifier(loc.statusChecking, level: MessageLevel.info);

    try {
      final update = await fetchUpdate();
      if (!context.mounted) return;
      final currentLoc = context.appLocalizations;

      if (update != null) {
        showUpdateDialog(context, update);
      } else {
        context.showNotifier(
          currentLoc.latestVersionInstalled,
          level: MessageLevel.success,
        );
      }
    } catch (_) {
      if (context.mounted) {
        context.showNotifier(
          context.appLocalizations.updateCheckError,
          level: MessageLevel.error,
        );
      }
    }
  }

  static void showUpdateDialog(BuildContext context, AppUpdateInfo update) {
    final loc = context.appLocalizations;
    final downloadUrl = update.downloadUrl;

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF22C55E).withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.system_update_rounded,
                      color: Color(0xFF22C55E),
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc.newVersionAvailable(update.version),
                          style: Theme.of(sheetContext)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'LieVPN ${update.version}',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (update.releaseNotes != null && update.releaseNotes!.isNotEmpty) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                  ),
                  child: Text(
                    update.releaseNotes!,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => Navigator.pop(sheetContext),
                      child: Text(loc.updateLater),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF22C55E),
                        foregroundColor: const Color(0xFF060A08),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(sheetContext);
                        dialogs.openUrl(downloadUrl);
                      },
                      child: Text(
                        loc.updateNow,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
