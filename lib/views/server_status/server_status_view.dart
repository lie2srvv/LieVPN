import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'status_page_models.dart';
import 'status_page_service.dart';

class ServerStatusView extends StatefulWidget {
  const ServerStatusView({super.key});

  @override
  State<ServerStatusView> createState() => _ServerStatusViewState();
}

class _ServerStatusViewState extends State<ServerStatusView> {
  final ServerStatusService _service = ServerStatusService();
  ServerStatusState _state = const ServerStatusState(isLoading: true);
  Timer? _autoRefreshTimer;

  @override
  void initState() {
    super.initState();
    _loadStatus();
    // Auto-refresh every 30 seconds while screen is open
    _autoRefreshTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (mounted) {
        _loadStatus();
      }
    });
  }

  Future<void> _loadStatus() async {
    if (!mounted) return;
    setState(() {
      _state = ServerStatusState(
        isLoading: true,
        monitors: _state.monitors,
        lastUpdated: _state.lastUpdated,
      );
    });

    final res = await _service.fetchStatus();
    if (!mounted) return;
    setState(() {
      _state = res;
    });
  }

  @override
  void dispose() {
    _autoRefreshTimer?.cancel();
    super.dispose();
  }

  String _formatMoscowTime(DateTime? utcTime) {
    if (utcTime == null) return '—';
    // Moscow is UTC+3
    final moscowTime = utcTime.toUtc().add(const Duration(hours: 3));
    final h = moscowTime.hour.toString().padLeft(2, '0');
    final m = moscowTime.minute.toString().padLeft(2, '0');
    final s = moscowTime.second.toString().padLeft(2, '0');
    return '$h:$m:$s MSK';
  }

  @override
  Widget build(BuildContext context) {
    final state = _state;
    final appLocalizations = context.appLocalizations;

    return CommonScaffold(
      title: appLocalizations.serverStatus,
      actions: [
        IconButton(
          tooltip: appLocalizations.update,
          icon: state.isLoading
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.refresh_rounded),
          onPressed: state.isLoading ? null : () => _loadStatus(),
        ),
      ],
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF060A08),
        ),
        child: RefreshIndicator(
          onRefresh: () => _loadStatus(),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            children: [
              _buildOverallBanner(context, state),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    appLocalizations.statusMonitors,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                      color: Colors.white.withValues(alpha: 0.4),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (state.monitors.isEmpty && state.isLoading)
                _buildLoadingSkeletons()
              else if (state.monitors.isEmpty)
                _buildEmptyState(context)
              else
                ...state.monitors.map((m) => _buildMonitorCard(context, m)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverallBanner(BuildContext context, ServerStatusState state) {
    final appLocalizations = context.appLocalizations;
    final bool isDegraded = state.hasPartialIssues;
    final bool isAllDown = state.allDown;

    Color borderColor;
    Color bgColor;
    Color iconColor;
    IconData iconData;
    String title;
    String subtitle;

    if (isAllDown) {
      borderColor = const Color(0xFFEF4444).withValues(alpha: 0.35);
      bgColor = const Color(0xFF261014);
      iconColor = const Color(0xFFEF4444);
      iconData = Icons.cancel_outlined;
      title = appLocalizations.statusAllDown;
      subtitle = appLocalizations.statusAllDownDesc;
    } else if (isDegraded) {
      borderColor = const Color(0xFFF59E0B).withValues(alpha: 0.35);
      bgColor = const Color(0xFF271C0F);
      iconColor = const Color(0xFFF59E0B);
      iconData = Icons.warning_amber_rounded;
      title = appLocalizations.statusPartialOutages;
      subtitle = appLocalizations.statusPartialOutagesDesc(state.upCount, state.monitors.length);
    } else {
      borderColor = const Color(0xFF22C55E).withValues(alpha: 0.3);
      bgColor = const Color(0xFF0D1F17);
      iconColor = const Color(0xFF22C55E);
      iconData = Icons.check_circle_outline_rounded;
      title = appLocalizations.statusAllSystemsOperational;
      subtitle = appLocalizations.statusAllSystemsOperationalDesc;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: iconColor.withValues(alpha: 0.12),
            blurRadius: 16,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, color: iconColor, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.65),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                appLocalizations.statusUpdated,
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: Colors.white.withValues(alpha: 0.35),
                  fontSize: 10,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                _formatMoscowTime(state.lastUpdated),
                style: const TextStyle(
                  fontFamily: 'monospace',
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMonitorCard(BuildContext context, MonitorStatusData data) {
    final appLocalizations = context.appLocalizations;
    final isUp = data.isUp;
    final dotColor = isUp ? const Color(0xFF22C55E) : const Color(0xFFEF4444);
    final badgeBg = isUp
        ? const Color(0xFF22C55E).withValues(alpha: 0.15)
        : const Color(0xFFEF4444).withValues(alpha: 0.15);
    final badgeText = isUp ? appLocalizations.statusOperational : appLocalizations.statusDown;

    final recentBeats = data.heartbeats.length > 35
        ? data.heartbeats.sublist(data.heartbeats.length - 35)
        : data.heartbeats;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF101614),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: dotColor.withValues(alpha: 0.6),
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  data.monitor.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                data.uptimeText,
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: data.uptime24h != null && data.uptime24h! >= 0.99
                      ? const Color(0xFF22C55E)
                      : (data.uptime24h != null && data.uptime24h! >= 0.95
                          ? const Color(0xFFF59E0B)
                          : const Color(0xFFEF4444)),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeBg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  badgeText,
                  style: TextStyle(
                    color: dotColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Heartbeat timeline bars
          SizedBox(
            height: 24,
            child: Row(
              children: recentBeats.map((b) {
                final barColor = b.isUp
                    ? const Color(0xFF22C55E)
                    : const Color(0xFFEF4444);
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1.5),
                    decoration: BoxDecoration(
                      color: barColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                appLocalizations.statusCheckHistory,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.3),
                  fontSize: 10,
                  fontFamily: 'monospace',
                ),
              ),
              if (data.latestHeartbeat?.ping != null && data.latestHeartbeat!.ping > 0)
                Text(
                  '${data.latestHeartbeat!.ping.toStringAsFixed(1)} ms',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.4),
                    fontSize: 10,
                    fontFamily: 'monospace',
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingSkeletons() {
    return Column(
      children: List.generate(
        3,
        (index) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Text(
          context.appLocalizations.statusNoMonitors,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.4),
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
