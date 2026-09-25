enum SpeedtestPhase {
  idle,
  findingServer,
  ping,
  download,
  upload,
  completed,
  error,
}

enum SpeedtestSource {
  ookla,
  yandex,
}

extension SpeedtestSourceExt on SpeedtestSource {
  String get displayName => switch (this) {
        SpeedtestSource.ookla => 'через speedtest.net',
        SpeedtestSource.yandex => 'через Яндекс.Интернетометр',
      };
}

class SpeedtestState {
  final SpeedtestPhase phase;
  final SpeedtestSource source;
  final double currentSpeedMbps;
  final double progress; // 0.0 to 1.0
  final int? pingMs;
  final double? downloadMbps;
  final double? uploadMbps;
  final String? serverName;
  final String? errorMessage;

  const SpeedtestState({
    this.phase = SpeedtestPhase.idle,
    this.source = SpeedtestSource.yandex,
    this.currentSpeedMbps = 0.0,
    this.progress = 0.0,
    this.pingMs,
    this.downloadMbps,
    this.uploadMbps,
    this.serverName,
    this.errorMessage,
  });

  bool get isRunning =>
      phase == SpeedtestPhase.findingServer ||
      phase == SpeedtestPhase.ping ||
      phase == SpeedtestPhase.download ||
      phase == SpeedtestPhase.upload;

  SpeedtestState copyWith({
    SpeedtestPhase? phase,
    SpeedtestSource? source,
    double? currentSpeedMbps,
    double? progress,
    int? pingMs,
    double? downloadMbps,
    double? uploadMbps,
    String? serverName,
    String? errorMessage,
  }) {
    return SpeedtestState(
      phase: phase ?? this.phase,
      source: source ?? this.source,
      currentSpeedMbps: currentSpeedMbps ?? this.currentSpeedMbps,
      progress: progress ?? this.progress,
      pingMs: pingMs ?? this.pingMs,
      downloadMbps: downloadMbps ?? this.downloadMbps,
      uploadMbps: uploadMbps ?? this.uploadMbps,
      serverName: serverName ?? this.serverName,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
