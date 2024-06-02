import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:minddy/ui/components/snackbar/snackbar.dart';

class AppConfig {

  static late Map<String, dynamic> _configFileContent;
  static const String _configFilePath = "config/config.json";
  static const Map<String, dynamic> _defaultConfigData = {
    "username": "",
    "language": null,
    "using_bw_mode": false,
    "using_system_theme": true,
    "dark_mode": false,
    "is_first_start": true
  };

  static Future<bool> loadConfigFile() async {
    try {
      Map<String, dynamic>? configFileContent = await StaticVariables.fileSource.readJsonFile(_configFilePath, decrypt: false);
      if (configFileContent != null) {
        _configFileContent = configFileContent;
        return true;
      } else {
        if (File(_configFilePath).existsSync()) {
          await StaticVariables.fileSource.removeFile(_configFilePath);
        }
        await StaticVariables.fileSource.createFile(_configFilePath);
        await StaticVariables.fileSource.writeJsonFile(_configFilePath, _defaultConfigData, encrypt: false);
        await loadConfigFile();
        return true;
      }
    } catch (e) {
      await AppLogs.writeError(e, "config.dart");
      return false;
    }
  }

  static dynamic getConfigValue(String key) async {
    final value = _configFileContent[key];
    return value;
  }

  static Future<bool> modifyConfigValue(String key, final newValue) async {
    try {
      _configFileContent[key] = newValue;
      return await _saveConfigFile();
    } catch (e) {
      await AppLogs.writeError(e, "config.dart");
      return false;
    }
  }

  static Future<bool> _saveConfigFile() async {
    try {
      await StaticVariables.fileSource.writeJsonFile(_configFilePath, _configFileContent, encrypt: false);
      return true;
    } catch(e) {
      await AppLogs.writeError(e, "config.dart");
      return false;
    }
  }

  static resetConfigFile(BuildContext context) async {
    try {
      await StaticVariables.fileSource.writeJsonFile(_configFilePath, await _getResetConfigData(), encrypt: false);
      if (context.mounted) {
        showBottomSnackBar(
          context, 
          S.current.snackbar_restart_needed_text, 
          S.current.snackbar_restart_button, 
          () {SystemNavigator.pop();}, 
          20,
        );
      }
    } catch (e) {
      AppLogs.writeError(e, "config.dart - resetConfigFile");
    }
  }

  static Future<Map<String, dynamic>> _getResetConfigData() async {
    return {
      "username": await AppConfig.getConfigValue("username"),
      "language": null,
      "using_bw_mode": false,
      "using_system_theme": true,
      "dark_mode": false,
      "is_first_start": false
    };
  }
}
