import 'package:flutter/material.dart';
import 'package:minddy/system/files/app_config.dart';
import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:minddy/ui/theme/theme.dart';

class _InitialisationStep {
  Future<bool> Function() execute;
  String errorMessage;

  _InitialisationStep({
    required this.execute, required this.errorMessage
  });
}

_InitialisationStep _loadConfigFile = _InitialisationStep(
  execute: () async {
    bool isLoaded = await AppConfig.loadConfigFile();
    StaticVariables.fileSource.documentDirectoryPath = await StaticVariables.fileSource.getAppDirectoryPath();
    return isLoaded;
  },
  errorMessage: 'Failed to initialize config file'
);

_InitialisationStep _initalizeTheme = _InitialisationStep(
  execute: () async {
    return await AppTheme.initializeTheme();
  },
  errorMessage: 'Failed to initialize theme'
);

/// This method will initlalize all apps components, so that later on, they will work properly.
Future<bool> initializeApp() async {
  List<_InitialisationStep> steps = [
    _loadConfigFile,
    _initalizeTheme
  ];

  for (_InitialisationStep step in steps) {
    bool isInitialized = await step.execute();
    if (!isInitialized) {
      await AppLogs.writeError(step.errorMessage, 'initialize.dart');
      return false;
    }
  }

  return true;
}

const List<String> supportedLocales = [
  "fr_FR",
  "en",
  "es_ES"
];

// Language initialization
Future<Locale> getCurrentLocale() async {
  String? actualLanguage = await _getActualLanguage();
  String locale;
  if (actualLanguage == null) {
    String systemLocale = getSystemLocale();
    if (supportedLocales.contains(systemLocale.replaceAll(RegExp(r'[-]'), '_'))) {
      AppConfig.modifyConfigValue("language", systemLocale);
      locale = systemLocale;
    } else {
      AppConfig.modifyConfigValue("language", "en");
      locale = "en";
    }
    String languageCode = locale.substring(0, 2);
    String? countryCode = locale.length > 2 ? locale.split('_').last : null;
    return Locale(languageCode, countryCode);
  } else {
    String languageCode = actualLanguage.substring(0, 2);
    String? countryCode = actualLanguage.length > 2 ? actualLanguage.split('_').last : null;
    return Locale(languageCode, countryCode);
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