class UptimeMonitor {
  final int id;
  final String name;
  final String type;

  const UptimeMonitor({
    required this.id,
    required this.name,
    required this.type,
  });

  factory UptimeMonitor.fromJson(Map<String, dynamic> json) {
    return UptimeMonitor(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      type: json['type'] as String? ?? 'ping',
    );
  }
}

class Heartbeat {
  final int status; // 1 = up, 0 = down, 2 = pending/maintenance
  final DateTime? time;
  final double ping;
  final String msg;

  const Heartbeat({
    required this.status,
    this.time,
    required this.ping,
    required this.msg,
  });

  bool get isUp => status == 1;

  factory Heartbeat.fromJson(Map<String, dynamic> json) {
    DateTime? parsedTime;
    final timeStr = json['time'] as String?;
    if (timeStr != null && timeStr.isNotEmpty) {
      try {
        // Uptime Kuma sends timezone-naive UTC string like "2026-09-25 11:25:13.804"
        final normalized = timeStr.endsWith('Z')
            ? timeStr
            : '${timeStr.replaceAll(' ', 'T')}Z';
        parsedTime = DateTime.parse(normalized).toUtc();
      } catch (_) {
        parsedTime = null;
      }
    }

    return Heartbeat(
      status: json['status'] as int? ?? 0,
      time: parsedTime,
      ping: (json['ping'] as num?)?.toDouble() ?? 0.0,
      msg: json['msg'] as String? ?? '',
    );
  }
}

class MonitorStatusData {
  final UptimeMonitor monitor;
  final List<Heartbeat> heartbeats;
  final double? uptime24h;

  const MonitorStatusData({
    required this.monitor,
    required this.heartbeats,
    this.uptime24h,
  });

  Heartbeat? get latestHeartbeat =>
      heartbeats.isNotEmpty ? heartbeats.last : null;

  bool get isUp => latestHeartbeat?.isUp ?? false;

  String get uptimeText =>
      uptime24h != null ? '${(uptime24h! * 100).toStringAsFixed(2)}%' : '—';
}

class ServerStatusState {
  final bool isLoading;
  final String? error;
  final List<MonitorStatusData> monitors;
  final DateTime? lastUpdated;

  const ServerStatusState({
    this.isLoading = false,
    this.error,
    this.monitors = const [],
    this.lastUpdated,
  });

  int get upCount => monitors.where((m) => m.isUp).length;
  int get downCount => monitors.length - upCount;
  bool get allUp => monitors.isNotEmpty && downCount == 0;
  bool get allDown => monitors.isNotEmpty && upCount == 0;
  bool get hasPartialIssues => monitors.isNotEmpty && !allUp && !allDown;
}
