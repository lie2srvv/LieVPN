import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_clash/common/common.dart';
import 'status_page_models.dart';
import 'status_page_service.dart';

Future<void> showServerStatusSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppCorner.xxl)),
    ),
    builder: (_) => const ServerStatusSheet(),
  );
}

class ServerStatusSheet extends StatefulWidget {
  const ServerStatusSheet({super.key});

  @override
  State<ServerStatusSheet> createState() => _ServerStatusSheetState();
}

class _ServerStatusSheetState extends State<ServerStatusSheet> {
  final ServerStatusService _service = ServerStatusService();
  ServerStatusState _state = const ServerStatusState(isLoading: true);
  Timer? _autoRefreshTimer;

  @override
  void initState() {
    super.initState();
    _loadStatus();
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
    final moscowTime = utcTime.toUtc().add(const Duration(hours: 3));
    final h = moscowTime.hour.toString().padLeft(2, '0');
    final m = moscowTime.minute.toString().padLeft(2, '0');
    final s = moscowTime.second.toString().padLeft(2, '0');
    return '$h:$m:$s MSK';
  }

  @override
  Widget build(BuildContext context) {
    final state = _state;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = context.appLocalizations;
    final maxHeight = MediaQuery.of(context).size.height * 0.85;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 20),
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
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(AppCorner.md),
                    ),
                    child: Icon(
                      Icons.dns_rounded,
                      color: colorScheme.onPrimaryContainer,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appLocalizations.serverStatus,
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${appLocalizations.statusUpdated}: ${_formatMoscowTime(state.lastUpdated)}',
                          style: textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: appLocalizations.update,
                    icon: state.isLoading
                        ? SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: colorScheme.primary,
                            ),
                          )
                        : Icon(Icons.refresh_rounded, color: colorScheme.primary),
                    onPressed: state.isLoading ? null : () => _loadStatus(),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Content List
              Flexible(
                child: RefreshIndicator(
                  onRefresh: () => _loadStatus(),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      _buildOverallBanner(context, state),
                      const SizedBox(height: 16),
                      Text(
                        appLocalizations.statusMonitors.toUpperCase(),
                        style: textTheme.labelSmall?.copyWith(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (state.monitors.isEmpty && state.isLoading)
                        _buildLoadingSkeletons(context)
                      else if (state.monitors.isEmpty)
                        _buildEmptyState(context)
                      else
                        ...state.monitors.map((m) => _buildMonitorCard(context, m)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverallBanner(BuildContext context, ServerStatusState state) {
    final appLocalizations = context.appLocalizations;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final bool isDegraded = state.hasPartialIssues;
    final bool isAllDown = state.allDown;

    Color statusColor;
    IconData iconData;
    String title;
    String subtitle;

    if (isAllDown) {
      statusColor = colorScheme.error;
      iconData = Icons.cancel_outlined;
      title = appLocalizations.statusAllDown;
      subtitle = appLocalizations.statusAllDownDesc;
    } else if (isDegraded) {
      statusColor = const Color(0xFFF59E0B);
      iconData = Icons.warning_amber_rounded;
      title = appLocalizations.statusPartialOutages;
      subtitle = appLocalizations.statusPartialOutagesDesc(
        state.upCount,
        state.monitors.length,
      );
    } else {
      statusColor = const Color(0xFF10B981);
      iconData = Icons.check_circle_outline_rounded;
      title = appLocalizations.statusAllSystemsOperational;
      subtitle = appLocalizations.statusAllSystemsOperationalDesc;
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(AppCorner.lg),
        border: Border.all(
          color: statusColor.withValues(alpha: 0.35),
          width: 1.2,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, color: statusColor, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonitorCard(BuildContext context, MonitorStatusData data) {
    final appLocalizations = context.appLocalizations;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final isUp = data.isUp;
    final dotColor = isUp ? const Color(0xFF10B981) : colorScheme.error;
    final badgeBg = dotColor.withValues(alpha: 0.15);
    final badgeText = isUp ? appLocalizations.statusOperational : appLocalizations.statusDown;

    final recentBeats = data.heartbeats.length > 35
        ? data.heartbeats.sublist(data.heartbeats.length - 35)
        : data.heartbeats;

    final uptimeVal = data.uptime24h;
    final Color uptimeColor = uptimeVal != null && uptimeVal >= 0.99
        ? const Color(0xFF10B981)
        : (uptimeVal != null && uptimeVal >= 0.95
            ? const Color(0xFFF59E0B)
            : colorScheme.error);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(AppCorner.lg),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: dotColor.withValues(alpha: 0.6),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  data.monitor.name,
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
              Text(
                data.uptimeText,
                style: textTheme.bodySmall?.copyWith(
                  fontFamily: 'monospace',
                  color: uptimeColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: badgeBg,
                  borderRadius: BorderRadius.circular(AppCorner.sm),
                ),
                child: Text(
                  badgeText,
                  style: TextStyle(
                    color: dotColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Heartbeat timeline bars
          SizedBox(
            height: 20,
            child: Row(
              children: recentBeats.map((b) {
                final barColor = b.isUp
                    ? const Color(0xFF10B981)
                    : colorScheme.error;
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1.5),
                    decoration: BoxDecoration(
                      color: barColor,
                      borderRadius: BorderRadius.circular(AppCorner.sm / 3),
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
                style: textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                  fontSize: 10,
                  fontFamily: 'monospace',
                ),
              ),
              if (data.latestHeartbeat?.ping != null && data.latestHeartbeat!.ping > 0)
                Text(
                  '${data.latestHeartbeat!.ping.toStringAsFixed(1)} ms',
                  style: textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
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

  Widget _buildLoadingSkeletons(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: List.generate(
        3,
        (index) => Container(
          margin: const EdgeInsets.only(bottom: 10),
          height: 72,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(AppCorner.lg),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Text(
          context.appLocalizations.statusNoMonitors,
          style: TextStyle(
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
