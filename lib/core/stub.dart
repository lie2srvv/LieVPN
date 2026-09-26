import 'dart:async';


import 'desktop/model.dart';
import 'interface.dart';
import 'method.dart';

class StubCoreHandler extends CoreHandlerInterface {
  int _revision = 0;

  @override
  Future<CoreLifecycleResult> start() async {
    return CoreLifecycleResult(
      revision: ++_revision,
      outcome: CoreLifecycleOutcome.applied,
    );
  }

  @override
  Future<CoreLifecycleResult> restart() async {
    return CoreLifecycleResult(
      revision: ++_revision,
      outcome: CoreLifecycleOutcome.applied,
    );
  }

  @override
  Future<CoreLifecycleResult> stop() async {
    return CoreLifecycleResult(
      revision: ++_revision,
      outcome: CoreLifecycleOutcome.applied,
    );
  }

  @override
  Future<CoreLifecycleResult> close() async {
    return CoreLifecycleResult(
      revision: ++_revision,
      outcome: CoreLifecycleOutcome.applied,
    );
  }

  @override
  Future<T?> invokeMethod<T>({
    required CoreMethod method,
    Object? arguments,
    Duration? timeout,
  }) async {
    if (T == bool) {
      return true as T;
    }
    if (T == String) {
      return '' as T;
    }
    if (T == int) {
      return 0 as T;
    }
    if (method == CoreMethod.getProxies) {
      return {'proxies': <String, dynamic>{}, 'all': <dynamic>[]} as T?;
    }
    if (method == CoreMethod.getConfig) {
      return <String, dynamic>{} as T?;
    }
    if (method == CoreMethod.getConnections) {
      return {'connections': <dynamic>[]} as T?;
    }
    if (method == CoreMethod.getTraffic ||
        method == CoreMethod.getTotalTraffic) {
      return {'up': 0, 'down': 0} as T?;
    }
    return null;
  }
}
