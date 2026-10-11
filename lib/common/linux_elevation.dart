import 'dart:io';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';

const String _wrapperPath = '/usr/local/bin/lievpn';
const String _configDir = '/etc/lievpn';
const String _targetFilePath = '$_configDir/appimage_path';

bool isLinuxRoot() {
  if (!Platform.isLinux) return true;
  try {
    final result = Process.runSync('id', ['-u']);
    return result.exitCode == 0 && result.stdout.toString().trim() == '0';
  } catch (_) {
    return false;
  }
}

String getLinuxCurrentExecutable() {
  final envAppImage = Platform.environment['APPIMAGE'];
  if (envAppImage != null && envAppImage.isNotEmpty) {
    return envAppImage;
  }
  return Platform.resolvedExecutable;
}

Future<bool> canSudoWithoutPassword() async {
  try {
    final result = await Process.run('sudo', ['-n', _wrapperPath, '--check']);
    return result.exitCode == 0;
  } catch (_) {
    return false;
  }
}

Future<bool> setupPasswordlessRootOnce() async {
  final currentExec = getLinuxCurrentExecutable();
  final sourceCore = appPath.bundledCorePath;

  // Staging core binary to /tmp for pkexec access
  final stagePath = '/tmp/.lievpn_core_stage_$pid';
  try {
    if (await File(sourceCore).exists()) {
      await File(sourceCore).copy(stagePath);
    }
  } catch (_) {}

  final setupScript = '''
set -e
mkdir -p "$_configDir"
echo "$currentExec" > "$_targetFilePath"
chmod 644 "$_targetFilePath"

mkdir -p /opt/flclash
if [ -f "$stagePath" ]; then
    mv -f "$stagePath" /opt/flclash/FlClashCore
    chown root:root /opt/flclash/FlClashCore
    chmod 4755 /opt/flclash/FlClashCore
    setcap cap_net_admin,cap_net_bind_service,cap_dac_override,cap_dac_read_search+ep /opt/flclash/FlClashCore 2>/dev/null || true
fi

cat << 'EOF' > "$_wrapperPath"
#!/bin/bash
if [ "\$1" = "--check" ]; then
    exit 0
fi

CONFIG_DIR="$_configDir"
TARGET_FILE="$_targetFilePath"

if [ "\$1" = "--set-target" ] && [ -n "\$2" ]; then
    mkdir -p "\$CONFIG_DIR"
    echo "\$2" > "\$TARGET_FILE"
    chmod 644 "\$TARGET_FILE"
    exit 0
fi

APP_PATH=""
if [ -f "\$TARGET_FILE" ]; then
    APP_PATH=\$(cat "\$TARGET_FILE")
fi

if [ -z "\$APP_PATH" ] || [ ! -f "\$APP_PATH" ]; then
    echo "LieVPN executable not found at \$APP_PATH" >&2
    exit 1
fi

# Ensure GUI runs in user session context so D-Bus and Wayland work properly
if [ "\$(id -u)" -eq 0 ] && [ -n "\$SUDO_USER" ] && [ "\$SUDO_USER" != "root" ]; then
    exec sudo -u "\$SUDO_USER" "\$APP_PATH" "\$@"
fi

exec "\$APP_PATH" "\$@"
EOF

chmod 755 "$_wrapperPath"
''';

  try {
    final result =
        await Process.run('pkexec', ['/bin/bash', '-c', setupScript]);
    return result.exitCode == 0;
  } catch (e) {
    commonPrint.log('pkexec setup failed: $e', logLevel: LogLevel.error);
    return false;
  } finally {
    try {
      final f = File(stagePath);
      if (await f.exists()) await f.delete();
    } catch (_) {}
  }
}

Future<bool> handleLinuxElevation(List<String> args) async {
  // GUI must run in user desktop session to preserve D-Bus session and Wayland integration.
  // TUN privileges are delegated directly to /opt/flclash/FlClashCore.
  return false;
}
