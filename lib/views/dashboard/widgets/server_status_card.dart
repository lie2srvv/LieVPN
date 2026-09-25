import 'package:flutter/material.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/views/server_status/status_page_service.dart';
import 'package:fl_clash/views/server_status/server_status_view.dart';
import 'package:fl_clash/widgets/widgets.dart';

class ServerStatusCard extends StatefulWidget {
  const ServerStatusCard({super.key});

  @override
  State<ServerStatusCard> createState() => _ServerStatusCardState();
}

class _ServerStatusCardState extends State<ServerStatusCard> {
  final ServerStatusService _service = ServerStatusService();
  bool _isLoading = true;
  int _upCount = 0;
  int _totalCount = 0;
  bool _isAllDown = false;

  @override
  void initState() {
    super.initState();
    _fetchQuickStatus();
  }

  Future<void> _fetchQuickStatus() async {
    final status = await _service.fetchStatus();
    if (mounted) {
      setState(() {
        _isLoading = false;
        _totalCount = status.monitors.length;
        _upCount = status.upCount;
        _isAllDown = status.allDown;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    final appLocalizations = context.appLocalizations;

    Color iconColor;
    IconData iconData;
    String statusTitle;

    if (_isLoading) {
      iconColor = const Color(0xFF22C55E);
      iconData = Icons.wifi_tethering;
      statusTitle = appLocalizations.statusChecking;
    } else if (_isAllDown && _totalCount > 0) {
      iconColor = const Color(0xFFEF4444);
      iconData = Icons.cancel_outlined;
      statusTitle = appLocalizations.statusAllDown;
    } else if (_upCount < _totalCount) {
      iconColor = const Color(0xFFF59E0B);
      iconData = Icons.warning_amber_rounded;
      statusTitle = appLocalizations.statusPartialOutagesDesc(_upCount, _totalCount);
    } else {
      iconColor = const Color(0xFF22C55E);
      iconData = Icons.check_circle_outline_rounded;
      statusTitle = appLocalizations.statusAllAvailable(_totalCount);
    }

    return CommonCard(
      radius: AppCorner.lg,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const ServerStatusView(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(AppCorner.md),
              ),
              child: Icon(
                iconData,
                size: 22,
                color: iconColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appLocalizations.serverStatus,
                    style: textTheme.titleMedium?.toBold,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    statusTitle,
                    style: textTheme.bodySmall?.copyWith(
                      color: iconColor,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: colorScheme.onSurfaceVariant.opacity50,
            ),
          ],
        ),
      ),
    );
  }
}
