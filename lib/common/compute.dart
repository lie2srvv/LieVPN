import 'package:collection/collection.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';

List<Group> computeSort({
  required List<Group> groups,
  required ProxiesSortType sortType,
  required DelayMap delayMap,
  required Map<String, String> selectedMap,
  required String defaultTestUrl,
}) {
  List<Proxy> sortOfDelay({
    required List<Group> groups,
    required List<Proxy> proxies,
    required DelayMap delayMap,
    required Map<String, String> selectedMap,
    required String testUrl,
  }) {
    return List.from(proxies)..sort((a, b) {
      final aDelayState = computeProxyDelayState(
        proxyName: a.name,
        testUrl: testUrl,
        groups: groups,
        selectedMap: selectedMap,
        delayMap: delayMap,
      );
      final bDelayState = computeProxyDelayState(
        proxyName: b.name,
        testUrl: testUrl,
        groups: groups,
        selectedMap: selectedMap,
        delayMap: delayMap,
      );
      return aDelayState.compareTo(bDelayState);
    });
  }

  List<Proxy> sortOfName(List<Proxy> proxies) {
    return List.of(proxies)..sort((a, b) => a.name.compareTo(b.name));
  }

  return groups.map((group) {
    final proxies = group.all;
    final newProxies = switch (sortType) {
      ProxiesSortType.none => proxies,
      ProxiesSortType.delay => sortOfDelay(
        groups: groups,
        proxies: proxies,
        delayMap: delayMap,
        selectedMap: selectedMap,
        testUrl: group.testUrl.takeFirstValid([defaultTestUrl]),
      ),
      ProxiesSortType.name => sortOfName(proxies),
    };
    return group.copyWith(all: newProxies);
  }).toList();
}

SelectedProxyState getRealSelectedProxyState(
  SelectedProxyState state, {
  required List<Group> groups,
  required Map<String, String> selectedMap,
}) {
  if (state.proxyName.isEmpty) return state;
  final index = groups.indexWhere((element) => element.name == state.proxyName);
  final newState = state.copyWith(group: true);
  if (index == -1) return newState;
  final group = groups[index];
  final currentSelectedName = group.getCurrentSelectedName(
    selectedMap[newState.proxyName] ?? '',
  );
  if (currentSelectedName.isEmpty) {
    return newState;
  }
  return getRealSelectedProxyState(
    newState.copyWith(proxyName: currentSelectedName, testUrl: group.testUrl),
    groups: groups,
    selectedMap: selectedMap,
  );
}

SelectedProxyState computeRealSelectedProxyState(
  String proxyName, {
  required List<Group> groups,
  required Map<String, String> selectedMap,
}) {
  return getRealSelectedProxyState(
    SelectedProxyState(proxyName: proxyName),
    groups: groups,
    selectedMap: selectedMap,
  );
}

String delayTestKey(String testUrl, String proxyName) {
  return '$testUrl\u0000$proxyName';
}

DelayState computeProxyDelayState({
  required String proxyName,
  required String testUrl,
  required List<Group> groups,
  required Map<String, String> selectedMap,
  required DelayMap delayMap,
}) {
  final state = computeRealSelectedProxyState(
    proxyName,
    groups: groups,
    selectedMap: selectedMap,
  );
  final currentDelayMap =
      delayMap[state.testUrl.takeFirstValid([testUrl])] ?? {};
  final delay = currentDelayMap[state.proxyName];
  return DelayState(delay: delay ?? 0, group: state.group);
}


String resolveConnectedServerName({
  required List<Group> groups,
  required Map<String, String> selectedMap,
}) {
  if (groups.isEmpty) {
    return '';
  }

  // In Rule mode, never pick Clash internal groups (GLOBAL, DIRECT, REJECT)
  final candidateGroups = groups.where((g) {
    final upper = g.name.toUpperCase();
    return upper != 'GLOBAL' && upper != 'DIRECT' && upper != 'REJECT' && g.hidden != true;
  }).toList();

  final effectiveGroups = candidateGroups.isNotEmpty ? candidateGroups : groups;

  final root = effectiveGroups.firstWhereOrNull((g) => g.name == 'PROXY') ??
      effectiveGroups.firstWhereOrNull((g) => g.type == GroupType.Selector || g.type.isComputedSelected) ??
      effectiveGroups.first;

  String current = root.type.isComputedSelected
      ? (root.now?.isNotEmpty == true && root.now != root.name ? root.now! : (selectedMap[root.name] ?? ''))
      : (selectedMap[root.name] ?? (root.now?.isNotEmpty == true && root.now != root.name ? root.now! : ''));

  if (current.isEmpty || current == 'DIRECT' || current == 'REJECT') {
    final validFirst = root.all.firstWhereOrNull(
      (p) => p.name != 'DIRECT' && p.name != 'REJECT' && p.name != 'GLOBAL',
    );
    current = validFirst?.name ?? '';
  }

  final visited = <String>{};
  while (current.isNotEmpty && !visited.contains(current)) {
    visited.add(current);
    if (current == 'DIRECT' || current == 'REJECT') {
      return '';
    }
    final group = groups.firstWhereOrNull((g) => g.name == current);
    if (group == null) {
      return current;
    }
    final next = group.type.isComputedSelected
        ? (group.now?.isNotEmpty == true && group.now != group.name ? group.now! : (selectedMap[group.name] ?? ''))
        : (selectedMap[group.name] ?? (group.now?.isNotEmpty == true && group.now != group.name ? group.now! : ''));

    if (next.isNotEmpty && next != current && next != 'DIRECT' && next != 'REJECT') {
      current = next;
    } else {
      final validChild = group.all.firstWhereOrNull(
        (p) => p.name != 'DIRECT' && p.name != 'REJECT' && p.name != 'GLOBAL' && !visited.contains(p.name),
      );
      if (validChild != null) {
        current = validChild.name;
      } else {
        break;
      }
    }
  }

  if (current == 'DIRECT' || current == 'REJECT') {
    return '';
  }
  return current;
}
