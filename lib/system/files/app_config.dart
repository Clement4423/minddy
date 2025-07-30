/*
 * minddy - Free project management
 * Copyright (C) 2025 mangué
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 */

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:minddy/system/notifications/notification_handler.dart';
import 'package:minddy/ui/components/notifications/notification_widget.dart';

class AppConfigValues {
  String username;
  String? language;
  bool usingBlackAndWhiteMode;
  bool usingSystemTheme;
  bool usingDarkMode;
  bool preferUsDateFormat;
  bool isFirstAppStart;

  AppConfigValues({
    required this.username,
    required this.language,
    required this.usingBlackAndWhiteMode,
    required this.usingSystemTheme,
    required this.usingDarkMode,
    required this.preferUsDateFormat,
    required this.isFirstAppStart
  });

  static AppConfigValues getDefaultValues() {
    return AppConfigValues(
      username: '', 
      language: null, 
      usingBlackAndWhiteMode: false, 
      usingSystemTheme: true, 
      usingDarkMode: false, 
      preferUsDateFormat: WidgetsBinding.instance.platformDispatcher.locale.languageCode.toLowerCase().contains('us'), 
      isFirstAppStart: true
    );
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'language': language,
      'using_bw_mode': usingBlackAndWhiteMode,
      'using_system_theme': usingSystemTheme,
      'usingDarkMode': usingDarkMode,
      'prefer_us_date_format': preferUsDateFormat,
      'is_first_start': isFirstAppStart
    };
  } 

  static Future<AppConfigValues?> fromJson(String json) async {
    try {
      Map<String, dynamic> map = jsonDecode(json);

      return AppConfigValues(
        username: map['username'], 
        language: map['language'], 
        usingBlackAndWhiteMode: map['using_bw_mode'], 
        usingSystemTheme: map['using_system_theme'], 
        usingDarkMode: map['usingDarkMode'], 
        preferUsDateFormat: map['prefer_us_date_format'], 
        isFirstAppStart: map['is_first_start']
      );

    } catch (e) {
      await AppLogs.writeError(e, 'config.dart - AppConfigValues.fromJson');
      return null;
    }
  }
}

class AppConfig {
  static late AppConfigValues data;
  static const String _configFilePath = "config/config.json";
  static final AppConfigValues _defaultConfigData = AppConfigValues.getDefaultValues();

  static Future<bool> loadConfigFile() async {
    try {
      Map<String, dynamic>? configFileContent = await StaticVariables.fileSource.readJsonFile(_configFilePath, decrypt: false);
      if (configFileContent != null) {
        data = (await AppConfigValues.fromJson(jsonEncode(configFileContent)))!;
        return true;
      } else {
        if (File(_configFilePath).existsSync()) {
          await StaticVariables.fileSource.removeFile(_configFilePath);
        }
        await StaticVariables.fileSource.createFile(_configFilePath);
        await StaticVariables.fileSource.writeJsonFile(_configFilePath, _defaultConfigData.toMap(), encrypt: false);
        await loadConfigFile();
        return true;
      }
    } catch (e) {
      await AppLogs.writeError(e, "config.dart");
      return false;
    }
  }

  static Future<bool> saveConfig() async {
    try {
      await StaticVariables.fileSource.writeJsonFile(_configFilePath, data.toMap(), encrypt: false);
      return true;
    } catch(e) {
      await AppLogs.writeError(e, "config.dart");
      return false;
    }
  }

  static resetConfig(BuildContext context) async {
    try {
      await StaticVariables.fileSource.writeJsonFile(_configFilePath, _defaultConfigData.toMap(), encrypt: false);
      if (context.mounted) {
        NotificationHandler.addNotification(
          NotificationModel(
            content: S.of(context).snackbar_restart_needed_text, 
            action: () {
              SystemNavigator.pop();
            }, 
            actionLabel: S.of(context).snackbar_restart_button, 
            duration: NotificationDuration.long
          )
        );
      }
    } catch (e) {
      AppLogs.writeError(e, "config.dart - resetConfigFile");
    }
  }
}