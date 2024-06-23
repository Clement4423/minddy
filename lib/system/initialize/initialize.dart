import 'package:flutter/material.dart';
import 'package:minddy/system/files/app_config.dart';
import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:minddy/ui/theme/theme.dart';

/// This method will initlalize all apps components, so that later on, they will work properly.
Future<bool> initializeApp() async {
  bool isConfigFileLoaded = await AppConfig.loadConfigFile();
  if (isConfigFileLoaded) {
    StaticVariables.fileSource.documentDirectoryPath = await StaticVariables.fileSource.getAppDirectoryPath();
    bool isThemeInitialized = await AppTheme.initializeTheme();
    if (isThemeInitialized) {
      return true;
    }
  }
  return false;
}

const List<String> supportedLocales = [
  "fr",
  "en",
  "es"
];

// Language initialization
Future<Locale> getCurrentLocale() async {
  String? actualLanguage = await _getActualLanguage();
  Locale locale;
  if (actualLanguage == null) {
    String systemLocale = getSystemLocale();
    if (supportedLocales.contains(systemLocale)) {
      AppConfig.modifyConfigValue("language", systemLocale);
      locale = Locale(systemLocale);
    } else {
      AppConfig.modifyConfigValue("language", "en");
      locale = const Locale("en");
    }
    return locale;
  } else {
    return Locale(actualLanguage);
  }
}

Future<String> getFirstPageRouteName() async {
  try {
    bool isFirstStart = await AppConfig.getConfigValue("is_first_start");
    String username = await AppConfig.getConfigValue('username');
    return isFirstStart 
      ? username.isNotEmpty
        ? '/create_password'
        : '/welcome'  
      : '/home';
  } catch (e) {
    await AppLogs.writeError(e, "Initialize.dart - getFirstPage");
    return '/';
  }
}

Future<String?> _getActualLanguage() async {
  return await AppConfig.getConfigValue("language");
}

String getSystemLocale() {
  return WidgetsBinding.instance.platformDispatcher.locale.languageCode;
}