import 'dart:io';

import 'package:minddy/system/files/app_logs.dart';

Future<void> openFileExplorerAt(String path) async {
  try {
    if (await Directory(path).exists()) {
      String command;
      List<String> args;

      if (Platform.isMacOS) {
        command = 'open';
        args = [path];
      } else if (Platform.isWindows) {
        command = 'explorer';
        args = [path.replaceAll('/', '\\')];
      } else if (Platform.isLinux) {
        command = 'xdg-open';
        args = [path];
      } else {
        throw UnsupportedError('Unsupported platform');
      }

      final result = await Process.run(command, args);

      if (result.exitCode != 0) {
        await AppLogs.writeError(
          "Cannot open file explorer at $path. Error: ${result.stderr}",
          "open_file_explorer.dart - openFileExplorerAt",
        );
      }
    } else {
      await AppLogs.writeError(
        "Path does not exist: $path",
        "open_file_explorer.dart - openFileExplorerAt",
      );
    }
  } catch (e) {
    await AppLogs.writeError(
      "Exception: $e",
      "open_file_explorer.dart - openFileExplorerAt",
    );
  }
}
