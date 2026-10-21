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
      // Primary engine: Yandex Internetometer (accurate & responsive, both with and without VPN)
      final success = await _runYandexSpeedtest(onUpdate, state);
      if (!success && !_isCanceled) {
        // High-reliability global fallback: Cloudflare Speed CDN
        await _runCloudflareSpeedtest(onUpdate, state);
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
  // YANDEX INTERNETOMETER ENGINE
  // Download -> Upload -> Ping
  // ========================================================
  Future<bool> _runYandexSpeedtest(
    void Function(SpeedtestState state) onUpdate,
    SpeedtestState initialState,
  ) async {
    SpeedtestState state = initialState;

    final List<String> downloadUrls = [
      'https://cdnrphoszsa2sp7ilm7a.svc.cdn.yandex.net/probes/50mb',
    ];
    String? ulPostUrl;
    String pingUrl = 'https://cdnrphoszsa2sp7ilm7a.svc.cdn.yandex.net/ping';

    // 1. Discover probes from Yandex Internetometer API
    try {
      final probeRes = await _dio.get<Map<String, dynamic>>(
        'https://yandex.ru/internet/api/v0/get-probes',
        options: Options(
          sendTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 6),
        ),
        cancelToken: _currentCancelToken,
      );
      final data = probeRes.data;
      if (data != null) {
        final dlProbes = (data['download']?['probes'] as List?)
            ?.cast<Map<dynamic, dynamic>>();
        if (dlProbes != null && dlProbes.isNotEmpty) {
          final urls = <String>[];
          for (final p in dlProbes) {
            final u = p['url']?.toString();
            if (u != null && u.isNotEmpty && (u.contains('50mb') || !u.contains('100kb'))) {
              urls.add(u);
            }
            final fb = p['fallbackUrl']?.toString();
            if (fb != null && fb.isNotEmpty && (fb.contains('50mb') || !fb.contains('100kb'))) {
              urls.add(fb);
            }
          }
          if (urls.isNotEmpty) {
            downloadUrls.clear();
            downloadUrls.addAll(urls);
          }
        }

        final ulProbes = (data['upload']?['probes'] as List?)
            ?.cast<Map<dynamic, dynamic>>();
        if (ulProbes != null && ulProbes.isNotEmpty) {
          for (final p in ulProbes) {
            final pUrl = p['postUrl']?.toString();
            if (pUrl != null && pUrl.isNotEmpty) {
              ulPostUrl = pUrl;
              break;
            }
          }
        }

        final latProbes = (data['latency']?['probes'] as List?)
            ?.cast<Map<dynamic, dynamic>>();
        if (latProbes != null && latProbes.isNotEmpty) {
          final first = latProbes.first['url']?.toString();
          if (first != null && first.isNotEmpty) pingUrl = first;
        }
      }
    } catch (_) {
      // Yandex API might fail or be unreachable on certain routes
    }

    if (_isCanceled) return false;

    // ================= STEP 1: DOWNLOAD =================
    state = state.copyWith(
      phase: SpeedtestPhase.download,
      currentSpeedMbps: 0.0,
    );
    onUpdate(state);

    final downloadStopwatch = Stopwatch()..start();
    double finalDownloadMbps = 0.0;
    int bytesReceived = 0;
    int lastWindowBytes = 0;
    int lastWindowMs = 0;

    int probeIndex = 0;
    while (downloadStopwatch.elapsedMilliseconds < 6500 && !_isCanceled) {
      final currentUrl = downloadUrls[probeIndex % downloadUrls.length];
      probeIndex++;

      try {
        final cancelToken = CancelToken();
        _currentCancelToken = cancelToken;

        final response = await _dio.get<ResponseBody>(
          currentUrl,
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
              return false;
            }
            bytesReceived += chunk.length;
            final elapsedMs = downloadStopwatch.elapsedMilliseconds;
            if (elapsedMs - lastWindowMs >= 200) {
              final windowDeltaMs = elapsedMs - lastWindowMs;
              final windowDeltaBytes = bytesReceived - lastWindowBytes;
              final windowSec = windowDeltaMs / 1000.0;
              final instantMbps =
                  (windowDeltaBytes * 8.0) / (windowSec * 1000000.0);

              final elapsedSec = elapsedMs / 1000.0;
              final cumulativeMbps =
                  (bytesReceived * 8.0) / (elapsedSec * 1000000.0);

              finalDownloadMbps = cumulativeMbps;
              onUpdate(state.copyWith(
                currentSpeedMbps: instantMbps,
                downloadMbps: cumulativeMbps,
              ));

              lastWindowMs = elapsedMs;
              lastWindowBytes = bytesReceived;
            }

            if (downloadStopwatch.elapsedMilliseconds >= 6500) {
              cancelToken.cancel();
              break;
            }
          }
        }
      } catch (_) {
        // If current stream failed and we already got sufficient bytes or test timed out, stop
        if (downloadStopwatch.elapsedMilliseconds >= 6500 || bytesReceived > 10 * 1024 * 1024) {
          break;
        }
      }
    }
    downloadStopwatch.stop();

    if (bytesReceived > 0) {
      final elapsedSec =
          (downloadStopwatch.elapsedMilliseconds / 1000.0).clamp(0.1, 10.0);
      finalDownloadMbps = (bytesReceived * 8.0) / (elapsedSec * 1000000.0);
    }

    state = state.copyWith(
      downloadMbps: finalDownloadMbps,
      currentSpeedMbps: 0.0,
      phase: SpeedtestPhase.upload,
    );
    onUpdate(state);

    if (_isCanceled) return false;

    // ================= STEP 2: UPLOAD =================
    final uploadStopwatch = Stopwatch()..start();
    double finalUploadMbps = 0.0;
    int bytesUploaded = 0;
    int lastUlWindowBytes = 0;
    int lastUlWindowMs = 0;

    String uploadTarget = ulPostUrl ?? 'https://speed.cloudflare.com/__up';
    final uploadPayload = Uint8List(1024 * 1024); // 1MB payload

    Future<void> runUploadWorker() async {
      while (uploadStopwatch.elapsedMilliseconds < 5000 && !_isCanceled) {
        try {
          final cancelToken = CancelToken();
          _currentCancelToken = cancelToken;

          await _dio.post(
            uploadTarget,
            data: Stream.fromIterable([uploadPayload]),
            options: Options(
              headers: {
                'Content-Type': 'application/octet-stream',
                'Content-Length': uploadPayload.length.toString(),
              },
              sendTimeout: const Duration(seconds: 4),
              receiveTimeout: const Duration(seconds: 4),
            ),
            cancelToken: cancelToken,
          );
          bytesUploaded += uploadPayload.length;
          final elapsedMs = uploadStopwatch.elapsedMilliseconds;
          if (elapsedMs - lastUlWindowMs >= 200) {
            final windowDeltaMs = elapsedMs - lastUlWindowMs;
            final windowDeltaBytes = bytesUploaded - lastUlWindowBytes;
            final windowSec = windowDeltaMs / 1000.0;
            final instantMbps =
                (windowDeltaBytes * 8.0) / (windowSec * 1000000.0);

            final elapsedSec = elapsedMs / 1000.0;
            final cumulativeMbps =
                (bytesUploaded * 8.0) / (elapsedSec * 1000000.0);

            finalUploadMbps = cumulativeMbps;
            onUpdate(state.copyWith(
              currentSpeedMbps: instantMbps,
              uploadMbps: cumulativeMbps,
            ));

            lastUlWindowMs = elapsedMs;
            lastUlWindowBytes = bytesUploaded;
          }
        } catch (_) {
          break;
        }
      }
    }

    // Run 2 concurrent upload streams to saturate upload pipeline over VPN/high-latency routes
    await Future.wait([runUploadWorker(), runUploadWorker()]);

    // If Yandex upload endpoint failed to accept any payload, retry with Cloudflare upload
    if (bytesUploaded == 0 && !_isCanceled && uploadTarget != 'https://speed.cloudflare.com/__up') {
      uploadTarget = 'https://speed.cloudflare.com/__up';
      await Future.wait([runUploadWorker(), runUploadWorker()]);
    }

    uploadStopwatch.stop();

    if (bytesUploaded > 0) {
      final elapsedSec =
          (uploadStopwatch.elapsedMilliseconds / 1000.0).clamp(0.1, 10.0);
      finalUploadMbps = (bytesUploaded * 8.0) / (elapsedSec * 1000000.0);
    }

    // ================= STEP 3: PING =================
    state = state.copyWith(
      uploadMbps: finalUploadMbps,
      currentSpeedMbps: 0.0,
      phase: SpeedtestPhase.ping,
    );
    onUpdate(state);

    if (_isCanceled) return false;

    int bestPing = 9999;
    for (int i = 0; i < 3; i++) {
      if (_isCanceled) return false;
      try {
        final sw = Stopwatch()..start();
        await _dio.get(
          pingUrl,
          options: Options(
            sendTimeout: const Duration(seconds: 3),
            receiveTimeout: const Duration(seconds: 3),
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

    // If neither download nor upload transferred any data, signal failure for fallback
    if (finalDownloadMbps <= 0.0 && finalUploadMbps <= 0.0) {
      return false;
    }

    state = state.copyWith(
      downloadMbps: finalDownloadMbps,
      uploadMbps: finalUploadMbps,
      pingMs: finalPing,
      currentSpeedMbps: 0.0,
      phase: SpeedtestPhase.completed,
    );
    onUpdate(state);
    return true;
  }

  // ========================================================
  // CLOUDFLARE SPEED ENGINE (Global Fallback)
  // Download -> Upload -> Ping
  // ========================================================
  Future<void> _runCloudflareSpeedtest(
    void Function(SpeedtestState state) onUpdate,
    SpeedtestState initialState,
  ) async {
    SpeedtestState state = initialState;

    // ================= STEP 1: DOWNLOAD =================
    state = state.copyWith(
      phase: SpeedtestPhase.download,
      currentSpeedMbps: 0.0,
    );
    onUpdate(state);

    final downloadStopwatch = Stopwatch()..start();
    double finalDownloadMbps = 0.0;
    int bytesReceived = 0;
    int lastWindowBytes = 0;
    int lastWindowMs = 0;

    try {
      final cancelToken = CancelToken();
      _currentCancelToken = cancelToken;

      final response = await _dio.get<ResponseBody>(
        'https://speed.cloudflare.com/__down?bytes=50000000',
        options: Options(
          sendTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 10),
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
          if (elapsedMs - lastWindowMs >= 200) {
            final windowDeltaMs = elapsedMs - lastWindowMs;
            final windowDeltaBytes = bytesReceived - lastWindowBytes;
            final windowSec = windowDeltaMs / 1000.0;
            final instantMbps =
                (windowDeltaBytes * 8.0) / (windowSec * 1000000.0);

            final elapsedSec = elapsedMs / 1000.0;
            final cumulativeMbps =
                (bytesReceived * 8.0) / (elapsedSec * 1000000.0);

            finalDownloadMbps = cumulativeMbps;
            onUpdate(state.copyWith(
              currentSpeedMbps: instantMbps,
              downloadMbps: cumulativeMbps,
            ));

            lastWindowMs = elapsedMs;
            lastWindowBytes = bytesReceived;
          }

          if (downloadStopwatch.elapsedMilliseconds >= 6500) {
            cancelToken.cancel();
            break;
          }
        }
      }
    } catch (_) {}
    downloadStopwatch.stop();

    if (bytesReceived > 0) {
      final elapsedSec =
          (downloadStopwatch.elapsedMilliseconds / 1000.0).clamp(0.1, 10.0);
      finalDownloadMbps = (bytesReceived * 8.0) / (elapsedSec * 1000000.0);
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
    int lastUlWindowBytes = 0;
    int lastUlWindowMs = 0;

    final uploadPayload = Uint8List(1024 * 1024); // 1MB payload

    Future<void> runUploadWorker() async {
      while (uploadStopwatch.elapsedMilliseconds < 5000 && !_isCanceled) {
        try {
          final cancelToken = CancelToken();
          _currentCancelToken = cancelToken;

          await _dio.post(
            'https://speed.cloudflare.com/__up',
            data: Stream.fromIterable([uploadPayload]),
            options: Options(
              headers: {
                'Content-Type': 'application/octet-stream',
                'Content-Length': uploadPayload.length.toString(),
              },
              sendTimeout: const Duration(seconds: 4),
              receiveTimeout: const Duration(seconds: 4),
            ),
            cancelToken: cancelToken,
          );
          bytesUploaded += uploadPayload.length;
          final elapsedMs = uploadStopwatch.elapsedMilliseconds;
          if (elapsedMs - lastUlWindowMs >= 200) {
            final windowDeltaMs = elapsedMs - lastUlWindowMs;
            final windowDeltaBytes = bytesUploaded - lastUlWindowBytes;
            final windowSec = windowDeltaMs / 1000.0;
            final instantMbps =
                (windowDeltaBytes * 8.0) / (windowSec * 1000000.0);

            final elapsedSec = elapsedMs / 1000.0;
            final cumulativeMbps =
                (bytesUploaded * 8.0) / (elapsedSec * 1000000.0);

            finalUploadMbps = cumulativeMbps;
            onUpdate(state.copyWith(
              currentSpeedMbps: instantMbps,
              uploadMbps: cumulativeMbps,
            ));

            lastUlWindowMs = elapsedMs;
            lastUlWindowBytes = bytesUploaded;
          }
        } catch (_) {
          break;
        }
      }
    }

    await Future.wait([runUploadWorker(), runUploadWorker()]);
    uploadStopwatch.stop();

    if (bytesUploaded > 0) {
      final elapsedSec =
          (uploadStopwatch.elapsedMilliseconds / 1000.0).clamp(0.1, 10.0);
      finalUploadMbps = (bytesUploaded * 8.0) / (elapsedSec * 1000000.0);
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
          'https://speed.cloudflare.com/__down?bytes=0',
          options: Options(
            sendTimeout: const Duration(seconds: 3),
            receiveTimeout: const Duration(seconds: 3),
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
