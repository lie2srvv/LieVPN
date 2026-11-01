import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';

import 'model.dart';

typedef CoreProcessStarter =
    Future<Process> Function(String executable, List<String> arguments);

abstract interface class CoreProcessLauncher {
  Future<CoreProcessLease> start({
    required String sessionId,
    required String address,
  });
}

abstract interface class DesktopCoreLauncherResolver {
  Future<CoreProcessLauncher> resolve();
}

final class DirectCoreLauncher implements CoreProcessLauncher {
  final CoreProcessStarter _startProcess;
  final String? _corePath;

  DirectCoreLauncher({CoreProcessStarter? startProcess, String? corePath})
    : _startProcess = startProcess ?? Process.start,
      _corePath = corePath;

  String get corePath => _corePath ?? appPath.corePath;

  @override
  Future<CoreProcessLease> start({
    required String sessionId,
    required String address,
  }) async {
    final process = await _startProcess(corePath, [address]);
    process.stdout.listen((_) {});
    process.stderr.listen((data) {
      final error = utf8.decode(data);
      if (error.isNotEmpty) {
        commonPrint.log(error, logLevel: LogLevel.warning);
      }
    });
    return DirectCoreLease(sessionId: sessionId, process: process);
  }
}

final class DirectCoreLease implements CoreProcessLease {
  @override
  final String sessionId;

  final Process _process;
  Future<CoreProcessStopResult>? _stopOperation;

  DirectCoreLease({required this.sessionId, required Process process})
    : _process = process;

  @override
  CoreProcessOwner get owner => CoreProcessOwner.direct;

  @override
  int get pid => _process.pid;

  @override
  Future<CoreProcessStopResult> stop(Duration timeout) {
    final stopOperation = _stopOperation;
    if (stopOperation != null) {
      return stopOperation;
    }
    final nextOperation = _stop(timeout).then((result) {
      if (!result.exitConfirmed) {
        _stopOperation = null;
      }
      return result;
    });
    _stopOperation = nextOperation;
    return nextOperation;
  }

  Future<CoreProcessStopResult> _stop(Duration timeout) async {
    // Send SIGTERM on Unix-like systems so Clash core cleans up TUN routing rules and tables before exit
    final bool signaled;
    if (Platform.isLinux || Platform.isMacOS) {
      signaled = _process.kill(ProcessSignal.sigterm);
    } else {
      signaled = _process.kill();
    }

    try {
      await _process.exitCode.timeout(timeout);
      return CoreProcessStopResult(stopped: signaled, exitConfirmed: true);
    } on TimeoutException {
      // If graceful termination timed out, forcibly kill
      final killed = _process.kill(ProcessSignal.sigkill);
      try {
        await _process.exitCode.timeout(const Duration(milliseconds: 1500));
        return CoreProcessStopResult(stopped: killed, exitConfirmed: true);
      } on TimeoutException {
        return CoreProcessStopResult(stopped: killed, exitConfirmed: false);
      }
    }
  }
}
