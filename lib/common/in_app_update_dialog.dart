import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/plugins/app.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

enum UpdateStatus {
  idle,
  downloading,
  readyToRestart,
  installing,
  error,
}

class InAppUpdateDialog extends StatefulWidget {
  final AppUpdateInfo updateInfo;

  const InAppUpdateDialog({
    super.key,
    required this.updateInfo,
  });

  @override
  State<InAppUpdateDialog> createState() => _InAppUpdateDialogState();
}

class _InAppUpdateDialogState extends State<InAppUpdateDialog> {
  UpdateStatus _status = UpdateStatus.idle;
  double _progress = 0.0;
  String _downloadedSizeStr = '';
  String _totalSizeStr = '';
  String? _errorMessage;
  String? _downloadedFilePath;
  CancelToken? _cancelToken;

  @override
  void dispose() {
    _cancelToken?.cancel();
    super.dispose();
  }

  String _formatBytes(int bytes) {
    if (bytes <= 0) return '0 B';
    const suffixes = ['B', 'KB', 'MB', 'GB'];
    double size = bytes.toDouble();
    int unitIndex = 0;
    while (size >= 1024 && unitIndex < suffixes.length - 1) {
      size /= 1024;
      unitIndex++;
    }
    return '${size.toStringAsFixed(1)} ${suffixes[unitIndex]}';
  }

  Future<void> _startDownload() async {
    setState(() {
      _status = UpdateStatus.downloading;
      _progress = 0.0;
      _errorMessage = null;
    });

    _cancelToken = CancelToken();

    try {
      final downloadUrl = widget.updateInfo.downloadUrl;
      final tempDir = await getTemporaryDirectory();
      String savePath;

      if (Platform.isAndroid) {
        savePath = p.join(tempDir.path, 'LieVPN-update-${widget.updateInfo.version}.apk');
      } else if (Platform.isWindows) {
        savePath = p.join(tempDir.path, 'LieVPN-update-${widget.updateInfo.version}.exe');
      } else if (Platform.isLinux) {
        savePath = p.join(tempDir.path, 'LieVPN-update-${widget.updateInfo.version}.AppImage');
      } else {
        savePath = p.join(tempDir.path, 'LieVPN-update-${widget.updateInfo.version}.bin');
      }

      final file = File(savePath);
      if (await file.exists()) {
        await file.delete();
      }

      final dio = Dio();
      await dio.download(
        downloadUrl,
        savePath,
        cancelToken: _cancelToken,
        onReceiveProgress: (received, total) {
          if (!mounted) return;
          if (total > 0) {
            setState(() {
              _progress = received / total;
              _downloadedSizeStr = _formatBytes(received);
              _totalSizeStr = _formatBytes(total);
            });
          } else {
            setState(() {
              _downloadedSizeStr = _formatBytes(received);
            });
          }
        },
      );

      if (!mounted) return;

      _downloadedFilePath = savePath;

      if (Platform.isAndroid) {
        setState(() {
          _status = UpdateStatus.readyToRestart;
        });
        // On Android, immediately trigger APK install prompt
        await _installAndroidApk(savePath);
      } else {
        setState(() {
          _status = UpdateStatus.readyToRestart;
        });
      }
    } catch (e) {
      if (CancelToken.isCancel(e as dynamic)) return;
      if (!mounted) return;
      setState(() {
        _status = UpdateStatus.error;
        _errorMessage = e.toString();
      });
    }
  }

  Future<void> _installAndroidApk(String filePath) async {
    try {
      final success = await App().installApk(filePath);
      if (!success && mounted) {
        setState(() {
          _status = UpdateStatus.error;
          _errorMessage = 'Не удалось запустить установщик пакета';
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _status = UpdateStatus.error;
          _errorMessage = e.toString();
        });
      }
    }
  }

  Future<void> _applyDesktopUpdateAndRestart() async {
    final filePath = _downloadedFilePath;
    if (filePath == null || !File(filePath).existsSync()) {
      setState(() {
        _status = UpdateStatus.error;
        _errorMessage = 'Файл обновления не найден';
      });
      return;
    }

    setState(() {
      _status = UpdateStatus.installing;
    });

    if (Platform.isLinux) {
      try {
        // 1. Give executable permissions to downloaded file
        await Process.run('chmod', ['+x', filePath]);

        // 2. If running from AppImage, replace the current AppImage file
        final envAppImage = Platform.environment['APPIMAGE'];
        if (envAppImage != null && envAppImage.isNotEmpty) {
          // In Linux, we can overwrite or rename over a running AppImage
          final target = File(envAppImage);
          await File(filePath).copy(target.path);
          await Process.run('chmod', ['+x', target.path]);

          // Detach and launch updated AppImage
          await Process.start(
            target.path,
            [],
            mode: ProcessStartMode.detached,
          );
        } else {
          // If running raw binary, launch the new AppImage detached
          await Process.start(
            filePath,
            [],
            mode: ProcessStartMode.detached,
          );
        }

        // Exit immediately so only the new instance remains
        exit(0);
      } catch (e) {
        if (mounted) {
          setState(() {
            _status = UpdateStatus.error;
            _errorMessage = 'Ошибка установки обновления: $e';
          });
        }
      }
    } else if (Platform.isWindows) {
      try {
        final currentExePath = Platform.resolvedExecutable;

        // Batch script to wait 1 second, copy new exe over old exe, and restart
        final updaterScriptPath = p.join(p.dirname(filePath), 'lievpn_update.bat');
        final scriptContent = '''
@echo off
timeout /t 1 /nobreak > NUL
copy /y "$filePath" "$currentExePath" > NUL
start "" "$currentExePath"
del "%~f0"
''';
        await File(updaterScriptPath).writeAsString(scriptContent);

        // Run batch script detached via cmd.exe
        await Process.start(
          'cmd.exe',
          ['/c', updaterScriptPath],
          mode: ProcessStartMode.detached,
        );

        // Exit immediately to release file lock on LieVPN.exe
        exit(0);
      } catch (e) {
        if (mounted) {
          setState(() {
            _status = UpdateStatus.error;
            _errorMessage = 'Ошибка установки обновления: $e';
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final loc = context.appLocalizations;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
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
                        loc.newVersionAvailable(widget.updateInfo.version),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'LieVPN ${widget.updateInfo.version}',
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

            // Release Notes
            if (widget.updateInfo.releaseNotes != null &&
                widget.updateInfo.releaseNotes!.isNotEmpty &&
                _status == UpdateStatus.idle) ...[
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
                  widget.updateInfo.releaseNotes!,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],

            // Progress / Status display
            if (_status == UpdateStatus.downloading) ...[
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: _progress > 0 ? _progress : null,
                  minHeight: 8,
                  backgroundColor: Colors.white.withValues(alpha: 0.1),
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF22C55E)),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _progress > 0
                        ? '${(_progress * 100).toStringAsFixed(0)}%'
                        : 'Загрузка...',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF22C55E),
                    ),
                  ),
                  if (_totalSizeStr.isNotEmpty)
                    Text(
                      '$_downloadedSizeStr / $_totalSizeStr',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    )
                  else if (_downloadedSizeStr.isNotEmpty)
                    Text(
                      _downloadedSizeStr,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
            ],

            if (_status == UpdateStatus.readyToRestart) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF22C55E).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF22C55E).withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle_rounded,
                      color: Color(0xFF22C55E),
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        Platform.isAndroid
                            ? 'Обновление загружено. Нажмите для завершения установки.'
                            : 'Обновление загружено и готово к установке.',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],

            if (_status == UpdateStatus.installing) ...[
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF22C55E)),
                        ),
                      ),
                      SizedBox(width: 14),
                      Text(
                        'Перезапуск и установка обновления...',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],

            if (_status == UpdateStatus.error) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.errorContainer.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: colorScheme.error, size: 22),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _errorMessage ?? 'Произошла ошибка при обновлении',
                        style: TextStyle(
                          fontSize: 12,
                          color: colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Action Buttons
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
                    onPressed: () => Navigator.pop(context),
                    child: Text(_status == UpdateStatus.readyToRestart ? 'Позже' : loc.updateLater),
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
                    onPressed: _status == UpdateStatus.downloading || _status == UpdateStatus.installing
                        ? null
                        : () {
                            if (_status == UpdateStatus.readyToRestart) {
                              if (Platform.isAndroid && _downloadedFilePath != null) {
                                _installAndroidApk(_downloadedFilePath!);
                              } else {
                                _applyDesktopUpdateAndRestart();
                              }
                            } else {
                              _startDownload();
                            }
                          },
                    child: Text(
                      _status == UpdateStatus.readyToRestart
                          ? (Platform.isAndroid ? 'Установить' : 'Перезапустить')
                          : (_status == UpdateStatus.error ? 'Повторить' : loc.updateNow),
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
    );
  }
}
