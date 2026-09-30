import 'dart:io';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';

const String _wrapperPath = '/usr/local/bin/lievpn';
const String _sudoersPath = '/etc/sudoers.d/lievpn';
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

  final setupScript = '''
set -e
mkdir -p "$_configDir"
echo "$currentExec" > "$_targetFilePath"
chmod 644 "$_targetFilePath"

cat << 'EOF' > "$_wrapperPath"
#!/bin/bash
if [ "\$1" = "--check" ]; then
    exit 0
fi

if [ "\$(id -u)" -ne 0 ]; then
    exec sudo "$_wrapperPath" "\$@"
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

if [ -n "\$SUDO_USER" ] && [ "\$SUDO_USER" != "root" ]; then
    USER_HOME=\$(getent passwd "\$SUDO_USER" | cut -d: -f6)
    if [ -n "\$USER_HOME" ]; then
        export HOME="\$USER_HOME"
        export XDG_DATA_HOME="\$USER_HOME/.local/share"
        export XDG_CONFIG_HOME="\$USER_HOME/.config"
        export XDG_CACHE_HOME="\$USER_HOME/.cache"
    fi
fi

export DISPLAY="\${DISPLAY:-:0}"
if [ -n "\$XDG_RUNTIME_DIR" ]; then
    export XDG_RUNTIME_DIR="\$XDG_RUNTIME_DIR"
fi
if [ -n "\$WAYLAND_DISPLAY" ]; then
    export WAYLAND_DISPLAY="\$WAYLAND_DISPLAY"
fi
if [ -n "\$DBUS_SESSION_BUS_ADDRESS" ]; then
    export DBUS_SESSION_BUS_ADDRESS="\$DBUS_SESSION_BUS_ADDRESS"
fi

if [ -z "\$XAUTHORITY" ] && [ -n "\$USER_HOME" ]; then
    if [ -f "\$USER_HOME/.Xauthority" ]; then
        export XAUTHORITY="\$USER_HOME/.Xauthority"
    fi
fi

if [ -n "\$DISPLAY" ] && command -v xhost >/dev/null 2>&1; then
    xhost +si:localuser:root >/dev/null 2>&1 || true
fi

exec "\$APP_PATH" "\$@"
EOF

chmod 755 "$_wrapperPath"

cat << 'EOF' > "$_sudoersPath"
Defaults env_keep += "DISPLAY XAUTHORITY WAYLAND_DISPLAY XDG_RUNTIME_DIR DBUS_SESSION_BUS_ADDRESS"
ALL ALL=(ALL) NOPASSWD: SETENV: $_wrapperPath
EOF

chmod 440 "$_sudoersPath"
''';

  try {
    final result =
        await Process.run('pkexec', ['/bin/bash', '-c', setupScript]);
    return result.exitCode == 0;
  } catch (e) {
    commonPrint.log('pkexec setup failed: $e', logLevel: LogLevel.error);
    return false;
  }
}

Future<bool> handleLinuxElevation(List<String> args) async {
  if (!Platform.isLinux || isLinuxRoot()) {
    return false;
  }

  try {
    await Process.run('xhost', ['+si:localuser:root']);
  } catch (_) {}

  final currentExec = getLinuxCurrentExecutable();

  // 1. Check if passwordless sudo is already configured
  final hasSudo = await canSudoWithoutPassword();
  if (hasSudo) {
    try {
      await Process.run(
        'sudo',
        ['-n', _wrapperPath, '--set-target', currentExec],
      );
      final proc = await Process.start(
        'sudo',
        [_wrapperPath, ...args],
        mode: ProcessStartMode.inheritStdio,
      );
      final exitCode = await proc.exitCode;
      exit(exitCode);
    } catch (e) {
      commonPrint.log('Failed to start via sudo: $e', logLevel: LogLevel.error);
    }
  }

  // 2. First time setup: request elevation once via pkexec
  final setupOk = await setupPasswordlessRootOnce();
  if (setupOk) {
    try {
      final proc = await Process.start(
        'sudo',
        [_wrapperPath, ...args],
        mode: ProcessStartMode.inheritStdio,
      );
      final exitCode = await proc.exitCode;
      exit(exitCode);
    } catch (e) {
      commonPrint.log(
        'Failed to start after setup: $e',
        logLevel: LogLevel.error,
      );
    }
  }

  return false;
}
