import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

const _allTargets = <String, String>{
  'android': 'apk',
  'linux': 'deb,appimage,rpm',
  'macos': 'dmg',
  'windows': 'exe,zip',
};

const _androidFlutterTarget = {
  'arm': 'android-arm',
  'arm64': 'android-arm64',
  'amd64': 'android-x64',
};

const _hostPlatform = {
  'linux': 'linux',
  'macos': 'macos',
  'windows': 'windows',
};

Future<void> main(List<String> args) async {
  final parser = createSetupArgParser();

  if (args.contains('--help') || args.contains('-h')) {
    _showHelp(parser);
    exit(0);
  }

  final results = parser.parse(args);
  final rest = results.rest;

  final hostOs = Platform.operatingSystem;
  final host = _hostPlatform[hostOs];
  if (host == null) {
    stderr.writeln('Unsupported host platform: $hostOs');
    exit(1);
  }

  final platform = rest.isNotEmpty ? rest.first : host;

  if (platform != host && platform != 'android') {
    stderr.writeln(
      'Cannot build "$platform" on $hostOs. Allowed: $host, android',
    );
    _showHelp(parser);
    exit(1);
  }

  final env = results['env'] as String;
  final rootDir = Directory.current.path;
  final skipped = packagesNotBuildingAssets(
    File(p.join(rootDir, 'pubspec.yaml')).readAsStringSync(),
  );
  if (skipped.isNotEmpty) {
    stderr.writeln(
      'pubspec.yaml sets hooks.user_defines.<package>.build_assets: false '
      'for ${skipped.join(', ')}; a package built this way would ship '
      'whatever is left in libclash/ and no Rust library. '
      'Restore "build_assets: true".',
    );
    exit(1);
  }
  final arch = _detectArch();
  final targets = createPackageTargets(platform, results['targets']);
  final androidArch = results['arch'] as String?;
  final verbose = results['verbose'] as bool;

  final exitCode = await _package(
    platform,
    env,
    targets,
    rootDir,
    arch,
    androidArch: androidArch,
    verbose: verbose,
  );
  exit(exitCode);
}

ArgParser createSetupArgParser() {
  return ArgParser()
    ..addOption(
      'env',
      defaultsTo: 'pre',
      allowed: ['dev', 'pre', 'stable'],
      help: 'Application environment',
    )
    ..addOption(
      'targets',
      valueHelp: 'exe,zip,dmg,apk,...',
      help: 'Package targets (default: all for platform)',
    )
    ..addOption(
      'arch',
      valueHelp: 'arm,arm64,amd64',
      allowed: ['arm', 'arm64', 'amd64'],
      help: 'Target architecture (Android only)',
    )
    ..addFlag(
      'verbose',
      abbr: 'v',
      negatable: false,
      help: 'Enable verbose Flutter build output',
    );
}

List<String> createFlutterBuildArgs({
  required String platform,
  required bool verbose,
}) {
  final flutterBuildArgs = <String>[
    if (verbose) 'verbose',
    'dart-define-from-file=env.json',
  ];
  if (platform == 'android') {
    flutterBuildArgs.add('split-per-abi');
  }
  return flutterBuildArgs;
}

Map<String, String> createBuildEnvironment(String env) {
  return {'APP_ENV': env};
}

/// Packages whose build hook `pubspec.yaml` turns into a no-op.
List<String> packagesNotBuildingAssets(String pubspec) {
  final document = loadYaml(pubspec);
  if (document is! Map) return const [];
  final defines = (document['hooks'] as Map?)?['user_defines'];
  if (defines is! Map) return const [];
  return [
    for (final MapEntry(:key, :value) in defines.entries)
      if (value is Map && value['build_assets'] == false) key.toString(),
  ]..sort();
}

String createPackageTargets(String platform, String? customTargets) {
  return customTargets ?? _allTargets[platform]!;
}

void _showHelp(ArgParser parser) {
  stderr.writeln('Usage: dart setup.dart [platform] [options]');
  stderr.writeln('Platform: current host platform (default) or android');
  stderr.writeln();
  stderr.writeln('Default package targets:');
  _allTargets.forEach((p, t) => stderr.writeln('  $p: $t'));
  stderr.writeln();
  stderr.writeln(parser.usage);
}

/// Removes .note.gnu.property section from Linux ELF binaries so they run on older CPUs/LTS kernels
Future<void> _sanitizeLinuxElfBinaries(String rootDir) async {
  if (!Platform.isLinux) return;
  final bundleDir = Directory(p.join(rootDir, 'build', 'linux', 'x64', 'release', 'bundle'));
  if (!bundleDir.existsSync()) return;

  final elfPaths = <String>[];
  for (final entity in bundleDir.listSync(recursive: true)) {
    if (entity is File) {
      final name = p.basename(entity.path);
      if (name == 'LieVPN' || name.startsWith('FlClash') || name.endsWith('.so')) {
        elfPaths.add(entity.path);
      }
    }
  }

  for (final elfPath in elfPaths) {
    try {
      final res = await Process.run('objcopy', ['--remove-section=.note.gnu.property', elfPath]);
      if (res.exitCode == 0) {
        stdout.writeln('Sanitized CPU ISA constraints for ${p.basename(elfPath)}');
      }
    } catch (_) {}
  }
}

Future<int> _package(
  String platform,
  String env,
  String targets,
  String rootDir,
  String arch, {
  String? androidArch,
  required bool verbose,
}) async {
  final file = File(p.join(rootDir, 'env.json'));
  await file.writeAsString(jsonEncode(createBuildEnvironment(env)));

  final flutterBuildArgs = createFlutterBuildArgs(
    platform: platform,
    verbose: verbose,
  );
  final descriptionArgs = <String>[];
  if (platform != 'android') {
    descriptionArgs.addAll(['--description', arch]);
  }

  final depExit = await _ensureDependencies(platform);
  if (depExit != 0) return depExit;

  // On Linux: build bundle first if packaging AppImage/deb to sanitize binaries before packaging
  if (platform == 'linux') {
    stdout.writeln('Pre-building Linux bundle to sanitize CPU architecture requirements...');
    final buildBundleArgs = [
      'build',
      'linux',
      '--release',
      if (flutterBuildArgs.isNotEmpty)
        for (final arg in flutterBuildArgs)
          if (arg == 'verbose') '-v' else '--$arg',
    ];
    final buildProcess = await Process.start('flutter', buildBundleArgs, runInShell: true);
    buildProcess.stdout.listen((data) => stdout.write(utf8.decode(data)));
    buildProcess.stderr.listen((data) => stderr.write(utf8.decode(data)));
    final buildExit = await buildProcess.exitCode;
    if (buildExit != 0) {
      return buildExit;
    }
    await _sanitizeLinuxElfBinaries(rootDir);
  }

  String distributorCmd = 'flutter_distributor';
  if (!await _hasCommand(distributorCmd)) {
    final home = Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'] ?? '';
    final pubDistributor = p.join(home, '.pub-cache', 'bin', Platform.isWindows ? 'flutter_distributor.bat' : 'flutter_distributor');
    if (File(pubDistributor).existsSync()) {
      distributorCmd = pubDistributor;
    } else {
      final activateResult = await Process.run('dart', [
        'pub',
        'global',
        'activate',
        '-s',
        'git',
        'https://github.com/chen08209/flutter_distributor.git',
        '--git-ref',
        'v0.6.11-flclash.2',
        '--git-path',
        'packages/flutter_distributor',
      ]);
      if (activateResult.exitCode != 0) {
        stderr.write(activateResult.stderr);
        return activateResult.exitCode;
      }
      if (File(pubDistributor).existsSync()) {
        distributorCmd = pubDistributor;
      }
    }
  }

  final process = await Process.start(
    distributorCmd,
    [
      'package',
      '--skip-clean',
      '--platform',
      platform,
      '--targets',
      targets,
      if (androidArch != null)
        '--build-target-platform=${_androidFlutterTarget[androidArch]!}',
      if (flutterBuildArgs.isNotEmpty)
        '--flutter-build-args=${flutterBuildArgs.join(',')}',
      ...descriptionArgs,
    ],
    includeParentEnvironment: true,
    runInShell: Platform.isWindows,
  );

  process.stdout.listen((data) {
    stdout.write(utf8.decode(data));
  });
  process.stderr.listen((data) {
    stderr.write(utf8.decode(data));
  });
  final exitCode = await process.exitCode;
  return exitCode;
}

String _detectArch() {
  if (Platform.isWindows) {
    final pa = Platform.environment['PROCESSOR_ARCHITECTURE'] ?? 'AMD64';
    return pa.toUpperCase() == 'ARM64' ? 'arm64' : 'amd64';
  }
  final result = Process.runSync('uname', ['-m']);
  final machine = (result.stdout as String).trim();
  if (machine == 'aarch64') return 'arm64';
  if (machine == 'x86_64') return 'amd64';
  return machine;
}

Future<bool> _hasCommand(String cmd) async {
  final which = Platform.isWindows ? 'where' : 'which';
  final args = [cmd];
  try {
    final result = await Process.run(which, args);
    return result.exitCode == 0;
  } catch (_) {
    return false;
  }
}

Future<int> _ensureDependencies(String platform) async {
  if (platform != 'linux') return 0;
  final appimagetool = await _hasCommand('appimagetool');
  if (!appimagetool) {
    stderr.writeln(
      'Warning: appimagetool not found in PATH. Make sure it is installed if building AppImage.',
    );
  }
  return 0;
}
