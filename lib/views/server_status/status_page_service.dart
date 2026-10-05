import 'dart:convert';
import 'package:dio/dio.dart';
import 'status_page_models.dart';

const String _kStatusBaseUrl = 'https://uptime.lie2srvv.com';
const String _kStatusSlug = 'lievpn';

class ServerStatusService {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  Future<ServerStatusState> fetchStatus() async {
    try {
      final configResponse = await _dio.get('$_kStatusBaseUrl/api/status-page/$_kStatusSlug');
      final heartbeatResponse = await _dio.get('$_kStatusBaseUrl/api/status-page/heartbeat/$_kStatusSlug');

      final configData = configResponse.data is String ? jsonDecode(configResponse.data) : configResponse.data;
      final heartbeatData = heartbeatResponse.data is String ? jsonDecode(heartbeatResponse.data) : heartbeatResponse.data;

      final publicGroups = (configData['publicGroupList'] as List?) ?? [];
      final List<UptimeMonitor> monitors = [];
      for (final group in publicGroups) {
        final list = (group['monitorList'] as List?) ?? [];
        for (final m in list) {
          monitors.add(UptimeMonitor.fromJson(Map<String, dynamic>.from(m)));
        }
      }

      final heartbeatMap = (heartbeatData['heartbeatList'] as Map?) ?? {};
      final uptimeMap = (heartbeatData['uptimeList'] as Map?) ?? {};

      final List<MonitorStatusData> monitorDataList = [];
      for (final monitor in monitors) {
        final rawBeats = (heartbeatMap[monitor.id.toString()] as List?) ?? [];
        final beats = rawBeats
            .map((b) => Heartbeat.fromJson(Map<String, dynamic>.from(b)))
            .toList();

        final rawUptime = uptimeMap['${monitor.id}_24'];
        final double? uptime24h = rawUptime != null ? (rawUptime as num).toDouble() : null;

        monitorDataList.add(
          MonitorStatusData(
            monitor: monitor,
            heartbeats: beats,
            uptime24h: uptime24h,
          ),
        );
      }

      return ServerStatusState(
        isLoading: false,
        monitors: monitorDataList,
        lastUpdated: DateTime.now().toUtc(),
      );
    } catch (e) {
      return ServerStatusState(
        isLoading: false,
        error: e.toString(),
        lastUpdated: DateTime.now().toUtc(),
      );
    }
  }
}
