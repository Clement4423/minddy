import 'dart:io';
import 'package:minddy/system/initialize/static_variables.dart';

class AppLogs {
  static Future<bool> _createLogFile() async {
    String relativePath= 'logs/error_logs.log';
    bool createdLogsFile = await StaticVariables.fileSource.createFile(relativePath);
    return createdLogsFile;
  }

  static Future<bool> clearLogs() async {
    String completePath = 'logs/errors.log';
    bool removedLogFile = await StaticVariables.fileSource.removeFile(completePath);
    return removedLogFile;
  }

  static writeError(final errorMessage, String filename) async {
    try {
      String appDocumentsDirectoryPath = await StaticVariables.fileSource.getAppDirectoryPath();
      String completePath = '$appDocumentsDirectoryPath/logs/error_logs.log';
      File logsFile = File(completePath);
      if (await logsFile.exists()) {
        final sink = logsFile.openWrite(mode: FileMode.append);
        sink.writeln("\n${DateTime.now()} ERROR AT $filename : ${errorMessage.toString()}\n");
        sink.close();
      } else {
        await _createLogFile();
        await writeError(errorMessage, filename);
      }
    } catch(e) {
      return;
    }
  }
}