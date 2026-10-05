import 'dart:async';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'speedtest_models.dart';

class SpeedtestService {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 8),
    receiveTimeout: const Duration(seconds: 12),
    headers: {
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
    },
  ));

  bool _isCanceled = false;
  CancelToken? _currentCancelToken;

  void cancel() {
    _isCanceled = true;
    _currentCancelToken?.cancel();
  }

  Future<void> runTest({
    required bool isVpnConnected,
    required void Function(SpeedtestState state) onUpdate,
  }) async {
    _isCanceled = false;
    _currentCancelToken = CancelToken();

    const state = SpeedtestState(
      phase: SpeedtestPhase.download,
      currentSpeedMbps: 0.0,
      downloadMbps: null,
      uploadMbps: null,
      pingMs: null,
      errorMessage: null,
    );
    onUpdate(state);

    try {
      if (isVpnConnected) {
        await _runOoklaSpeedtest(onUpdate, state);
      } else {
        await _runYandexSpeedtest(onUpdate, state);
      }
    } catch (e) {
      if (!_isCanceled) {
        onUpdate(state.copyWith(
          phase: SpeedtestPhase.error,
          currentSpeedMbps: 0.0,
          downloadMbps: 0.0,
          uploadMbps: 0.0,
          pingMs: 0,
          errorMessage: null,
        ));
      }
    }
  }

  // ========================================================
  // SPEEDTEST.NET (OOKLA) ENGINE (When VPN is Connected)
  // Download -> Upload -> Ping
  // ========================================================
  Future<void> _runOoklaSpeedtest(
    void Function(SpeedtestState state) onUpdate,
    SpeedtestState initialState,
  ) async {
    SpeedtestState state = initialState;

    // Default fast European CDN endpoint if Speedtest server listing fails
    String serverBase = 'https://fra.speedtest.clouvider.net/backend';
    String dlPath = 'garbage.php?ckSize=35';
    String ulPath = 'empty.php';
    String pingPath = 'empty.php';

    try {
      final res = await _dio.get<List<dynamic>>(
        'https://www.speedtest.net/api/js/servers?engine=js&limit=10',
        options: Options(
          headers: {
            'Referer': 'https://www.speedtest.net/',
            'Origin': 'https://www.speedtest.net',
            'Accept': 'application/json, text/plain, */*',
          },
          sendTimeout: const Duration(seconds: 4),
          receiveTimeout: const Duration(seconds: 4),
        ),
        cancelToken: _currentCancelToken,
      );

      if (res.data != null && res.data!.isNotEmpty) {
        final candidates = res.data!.take(6).toList();
        int lowestPing = 99999;
        String? chosenBase;

        for (final s in candidates) {
          if (_isCanceled) return;
          final rawUrl = (s['url'] ?? '').toString();
          if (rawUrl.isEmpty) continue;
          final base = rawUrl.split('/speedtest')[0].replaceAll(RegExp(r'/+$'), '');
          if (base.isEmpty) continue;

          try {
            final sw = Stopwatch()..start();
            await _dio.get(
              '$base/speedtest/latency.txt',
              options: Options(
                headers: {
                  'Referer': 'https://www.speedtest.net/',
                  'Origin': 'https://www.speedtest.net',
                },
                sendTimeout: const Duration(seconds: 2),
                receiveTimeout: const Duration(seconds: 2),
                responseType: ResponseType.bytes,
              ),
              cancelToken: _currentCancelToken,
            );
            sw.stop();
            if (sw.elapsedMilliseconds > 0 && sw.elapsedMilliseconds < lowestPing) {
              lowestPing = sw.elapsedMilliseconds;
              chosenBase = base;
            }
          } catch (_) {}
        }

        if (chosenBase != null) {
          serverBase = chosenBase;
          dlPath = 'speedtest/random2500x2500.jpg';
          ulPath = 'speedtest/upload.php';
          pingPath = 'speedtest/latency.txt';
        }
      }
    } catch (_) {}

    if (_isCanceled) return;

    // ================= STEP 1: DOWNLOAD =================
    state = state.copyWith(
      phase: SpeedtestPhase.download,
      currentSpeedMbps: 0.0,
    );
    onUpdate(state);

    final downloadStopwatch = Stopwatch()..start();
    double finalDownloadMbps = 0.0;
    int bytesReceived = 0;

    try {
      final cancelToken = CancelToken();
      _currentCancelToken = cancelToken;

      final downloadUrl = '$serverBase/$dlPath';
      final response = await _dio.get<ResponseBody>(
        downloadUrl,
        options: Options(
          headers: {
            'Referer': 'https://www.speedtest.net/',
            'Origin': 'https://www.speedtest.net',
          },
          responseType: ResponseType.stream,
        ),
        cancelToken: cancelToken,
      );

      final stream = response.data?.stream;
      if (stream != null) {
        await for (final chunk in stream) {
          if (_isCanceled) {
            cancelToken.cancel();
            return;
          }
          bytesReceived += chunk.length;
          final elapsedMs = downloadStopwatch.elapsedMilliseconds;
          if (elapsedMs > 150) {
            final elapsedSec = elapsedMs / 1000.0;
            final mbps = (bytesReceived * 8.0) / (elapsedSec * 1000000.0);
            finalDownloadMbps = mbps;
            onUpdate(state.copyWith(
              currentSpeedMbps: mbps,
              downloadMbps: mbps,
            ));
          }
          if (downloadStopwatch.elapsedMilliseconds > 6500) {
            cancelToken.cancel();
            break;
          }
        }
      }
    } catch (_) {}
    downloadStopwatch.stop();

    if (finalDownloadMbps <= 0.0 && bytesReceived > 0) {
      final elapsedSec =
          (downloadStopwatch.elapsedMilliseconds / 1000.0).clamp(0.1, 10.0);
      finalDownloadMbps = (bytesReceived * 8.0) / (elapsedSec * 1000000.0);
    }
    if (finalDownloadMbps < 0.0 || bytesReceived == 0) {
      finalDownloadMbps = 0.0;
    }

    state = state.copyWith(
      downloadMbps: finalDownloadMbps,
      currentSpeedMbps: 0.0,
      phase: SpeedtestPhase.upload,
    );
    onUpdate(state);

    if (_isCanceled) return;

    // ================= STEP 2: UPLOAD =================
    final uploadStopwatch = Stopwatch()..start();
    double finalUploadMbps = 0.0;
    int bytesUploaded = 0;

    final uploadUrl = '$serverBase/$ulPath';
    final chunkData = Uint8List(512 * 1024); // 512KB payload

    while (uploadStopwatch.elapsedMilliseconds < 5000 && !_isCanceled) {
      try {
        final cancelToken = CancelToken();
        _currentCancelToken = cancelToken;

        await _dio.post(
          uploadUrl,
          data: Stream.fromIterable([chunkData]),
          options: Options(
            headers: {
              'Referer': 'https://www.speedtest.net/',
              'Origin': 'https://www.speedtest.net',
              'Content-Type': 'application/octet-stream',
              'Content-Length': chunkData.length.toString(),
            },
          ),
          cancelToken: cancelToken,
        );
        bytesUploaded += chunkData.length;
        final elapsedMs = uploadStopwatch.elapsedMilliseconds;
        if (elapsedMs > 150) {
          final elapsedSec = elapsedMs / 1000.0;
          final mbps = (bytesUploaded * 8.0) / (elapsedSec * 1000000.0);
          finalUploadMbps = mbps;
          onUpdate(state.copyWith(
            currentSpeedMbps: mbps,
            uploadMbps: mbps,
          ));
        }
      } catch (_) {
        break;
      }
    }
    uploadStopwatch.stop();

    if (finalUploadMbps <= 0.0 && bytesUploaded > 0) {
      final elapsedSec =
          (uploadStopwatch.elapsedMilliseconds / 1000.0).clamp(0.1, 10.0);
      finalUploadMbps = (bytesUploaded * 8.0) / (elapsedSec * 1000000.0);
    }
    if (finalUploadMbps < 0.0 || bytesUploaded == 0) {
      finalUploadMbps = 0.0;
    }

    // ================= STEP 3: PING =================
    state = state.copyWith(
      uploadMbps: finalUploadMbps,
      currentSpeedMbps: 0.0,
      phase: SpeedtestPhase.ping,
    );
    onUpdate(state);

    if (_isCanceled) return;

    final pingUrl = '$serverBase/$pingPath';
    int bestPing = 9999;
    for (int i = 0; i < 3; i++) {
      if (_isCanceled) return;
      try {
        final sw = Stopwatch()..start();
        await _dio.get(
          pingUrl,
          options: Options(
            headers: {
              'Referer': 'https://www.speedtest.net/',
              'Origin': 'https://www.speedtest.net',
            },
            sendTimeout: const Duration(seconds: 2),
            receiveTimeout: const Duration(seconds: 2),
            responseType: ResponseType.bytes,
          ),
          cancelToken: _currentCancelToken,
        );
        sw.stop();
        if (sw.elapsedMilliseconds > 0 && sw.elapsedMilliseconds < bestPing) {
          bestPing = sw.elapsedMilliseconds;
        }
      } catch (_) {}
    }
    final int finalPing = (bestPing == 9999) ? 0 : bestPing;

    if (finalDownloadMbps <= 0.0 && finalUploadMbps <= 0.0) {
      state = state.copyWith(
        downloadMbps: 0.0,
        uploadMbps: 0.0,
        pingMs: 0,
        currentSpeedMbps: 0.0,
        phase: SpeedtestPhase.error,
        errorMessage: null,
      );
      onUpdate(state);
      return;
    }

    state = state.copyWith(
      downloadMbps: finalDownloadMbps,
      uploadMbps: finalUploadMbps,
      pingMs: finalPing,
      currentSpeedMbps: 0.0,
      phase: SpeedtestPhase.completed,
    );
    onUpdate(state);
  }

  // ========================================================
  // YANDEX INTERNETOMETER ENGINE (When VPN is Disconnected)
  // Download -> Upload -> Ping
  // ========================================================
  Future<void> _runYandexSpeedtest(
    void Function(SpeedtestState state) onUpdate,
    SpeedtestState initialState,
  ) async {
    SpeedtestState state = initialState;

    String dlUrl = 'https://cdnrphoszsa2sp7ilm7a.svc.cdn.yandex.net/probes/50mb';
    String? ulPostUrl;
    String pingUrl = 'https://cdnrphoszsa2sp7ilm7a.svc.cdn.yandex.net/ping';

    try {
      final probeRes = await _dio.get<Map<String, dynamic>>(
        'https://yandex.ru/internet/api/v0/get-probes',
        options: Options(
          sendTimeout: const Duration(seconds: 3),
          receiveTimeout: const Duration(seconds: 3),
        ),
        cancelToken: _currentCancelToken,
      );
      final data = probeRes.data;
      if (data != null) {
        final dlProbes = (data['download']?['probes'] as List?)?.cast<Map<dynamic, dynamic>>();
        if (dlProbes != null && dlProbes.isNotEmpty) {
          final first = dlProbes.first['url']?.toString();
          if (first != null && first.isNotEmpty) dlUrl = first;
        }
        final ulProbes = (data['upload']?['probes'] as List?)?.cast<Map<dynamic, dynamic>>();
        if (ulProbes != null && ulProbes.isNotEmpty) {
          final first = ulProbes.first['postUrl']?.toString();
          if (first != null && first.isNotEmpty) ulPostUrl = first;
        }
        final latProbes = (data['latency']?['probes'] as List?)?.cast<Map<dynamic, dynamic>>();
        if (latProbes != null && latProbes.isNotEmpty) {
          final first = latProbes.first['url']?.toString();
          if (first != null && first.isNotEmpty) pingUrl = first;
        }
      }
    } catch (_) {}

    if (_isCanceled) return;

    // ================= STEP 1: DOWNLOAD =================
    state = state.copyWith(
      phase: SpeedtestPhase.download,
      currentSpeedMbps: 0.0,
    );
    onUpdate(state);

    final downloadStopwatch = Stopwatch()..start();
    double finalDownloadMbps = 0.0;
    int bytesReceived = 0;

    try {
      final cancelToken = CancelToken();
      _currentCancelToken = cancelToken;

      final response = await _dio.get<ResponseBody>(
        dlUrl,
        options: Options(
          sendTimeout: const Duration(seconds: 4),
          receiveTimeout: const Duration(seconds: 8),
          responseType: ResponseType.stream,
        ),
        cancelToken: cancelToken,
      );

      final stream = response.data?.stream;
      if (stream != null) {
        await for (final chunk in stream) {
          if (_isCanceled) {
            cancelToken.cancel();
            return;
          }
          bytesReceived += chunk.length;
          final elapsedMs = downloadStopwatch.elapsedMilliseconds;
          if (elapsedMs > 150) {
            final elapsedSec = elapsedMs / 1000.0;
            final mbps = (bytesReceived * 8.0) / (elapsedSec * 1000000.0);
            finalDownloadMbps = mbps;
            onUpdate(state.copyWith(
              currentSpeedMbps: mbps,
              downloadMbps: mbps,
            ));
          }
          if (downloadStopwatch.elapsedMilliseconds > 7000) {
            cancelToken.cancel();
            break;
          }
        }
      }
    } catch (_) {}
    downloadStopwatch.stop();

    if (finalDownloadMbps <= 0.0 && bytesReceived > 0) {
      final elapsedSec =
          (downloadStopwatch.elapsedMilliseconds / 1000.0).clamp(0.1, 10.0);
      finalDownloadMbps = (bytesReceived * 8.0) / (elapsedSec * 1000000.0);
    }
    if (finalDownloadMbps < 0.0 || bytesReceived == 0) {
      finalDownloadMbps = 0.0;
    }

    state = state.copyWith(
      downloadMbps: finalDownloadMbps,
      currentSpeedMbps: 0.0,
      phase: SpeedtestPhase.upload,
    );
    onUpdate(state);

    if (_isCanceled) return;

    // ================= STEP 2: UPLOAD =================
    final uploadStopwatch = Stopwatch()..start();
    double finalUploadMbps = 0.0;
    int bytesUploaded = 0;

    if (ulPostUrl != null && ulPostUrl.isNotEmpty) {
      final uploadPayload = Uint8List(512 * 1024); // 512KB probe

      while (uploadStopwatch.elapsedMilliseconds < 5000 && !_isCanceled) {
        try {
          final cancelToken = CancelToken();
          _currentCancelToken = cancelToken;

          await _dio.post(
            ulPostUrl,
            data: Stream.fromIterable([uploadPayload]),
            options: Options(
              headers: {
                'Content-Type': 'application/octet-stream',
                'Content-Length': uploadPayload.length.toString(),
              },
            ),
            cancelToken: cancelToken,
          );
          bytesUploaded += uploadPayload.length;
          final elapsedMs = uploadStopwatch.elapsedMilliseconds;
          if (elapsedMs > 150) {
            final elapsedSec = elapsedMs / 1000.0;
            final mbps = (bytesUploaded * 8.0) / (elapsedSec * 1000000.0);
            finalUploadMbps = mbps;
            onUpdate(state.copyWith(
              currentSpeedMbps: mbps,
              uploadMbps: mbps,
            ));
          }
        } catch (_) {
          break;
        }
      }
    }
    uploadStopwatch.stop();

    if (finalUploadMbps <= 0.0 && bytesUploaded > 0) {
      final elapsedSec =
          (uploadStopwatch.elapsedMilliseconds / 1000.0).clamp(0.1, 10.0);
      finalUploadMbps = (bytesUploaded * 8.0) / (elapsedSec * 1000000.0);
    }
    if (finalUploadMbps < 0.0 || bytesUploaded == 0) {
      finalUploadMbps = 0.0;
    }

    // ================= STEP 3: PING =================
    state = state.copyWith(
      uploadMbps: finalUploadMbps,
      currentSpeedMbps: 0.0,
      phase: SpeedtestPhase.ping,
    );
    onUpdate(state);

    if (_isCanceled) return;

    int bestPing = 9999;
    for (int i = 0; i < 3; i++) {
      if (_isCanceled) return;
      try {
        final sw = Stopwatch()..start();
        await _dio.get(
          pingUrl,
          options: Options(
            sendTimeout: const Duration(seconds: 2),
            receiveTimeout: const Duration(seconds: 2),
            responseType: ResponseType.bytes,
          ),
          cancelToken: _currentCancelToken,
        );
        sw.stop();
        if (sw.elapsedMilliseconds > 0 && sw.elapsedMilliseconds < bestPing) {
          bestPing = sw.elapsedMilliseconds;
        }
      } catch (_) {}
    }
    final int finalPing = (bestPing == 9999) ? 0 : bestPing;

    if (finalDownloadMbps <= 0.0 && finalUploadMbps <= 0.0) {
      state = state.copyWith(
        downloadMbps: 0.0,
        uploadMbps: 0.0,
        pingMs: 0,
        currentSpeedMbps: 0.0,
        phase: SpeedtestPhase.error,
        errorMessage: null,
      );
      onUpdate(state);
      return;
    }

    state = state.copyWith(
      downloadMbps: finalDownloadMbps,
      uploadMbps: finalUploadMbps,
      pingMs: finalPing,
      currentSpeedMbps: 0.0,
      phase: SpeedtestPhase.completed,
    );
    onUpdate(state);
  }
}
