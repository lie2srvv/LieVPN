enum SpeedtestPhase {
  idle,
  download,
  upload,
  ping,
  completed,
  error,
}

enum SpeedtestSource {
  ookla,
  yandex,
}

class SpeedtestState {
  final SpeedtestPhase phase;
  final SpeedtestSource source;
  final double currentSpeedMbps;
  final double? downloadMbps;
  final double? uploadMbps;
  final int? pingMs;
  final String? errorMessage;

  const SpeedtestState({
    this.phase = SpeedtestPhase.idle,
    this.source = SpeedtestSource.yandex,
    this.currentSpeedMbps = 0.0,
    this.downloadMbps,
    this.uploadMbps,
    this.pingMs,
    this.errorMessage,
  });

  bool get isRunning =>
      phase == SpeedtestPhase.download ||
      phase == SpeedtestPhase.upload ||
      phase == SpeedtestPhase.ping;

  SpeedtestState copyWith({
    SpeedtestPhase? phase,
    SpeedtestSource? source,
    double? currentSpeedMbps,
    double? downloadMbps,
    double? uploadMbps,
    int? pingMs,
    String? errorMessage,
  }) {
    return SpeedtestState(
      phase: phase ?? this.phase,
      source: source ?? this.source,
      currentSpeedMbps: currentSpeedMbps ?? this.currentSpeedMbps,
      downloadMbps: downloadMbps ?? this.downloadMbps,
      uploadMbps: uploadMbps ?? this.uploadMbps,
      pingMs: pingMs ?? this.pingMs,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
