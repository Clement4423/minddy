import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/files/app_config.dart';
import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/initialize/app_state.dart';


class PersonalizeViewController extends ChangeNotifier {

  // Theme settings
  static final String _lightModeTitle = S.current.settings_using_light_mode;
  static final String _darkModeTitle = S.current.settings_using_dark_mode;
  static final String _systemModeTitle = S.current.settings_using_system_theme;


  String _menuThemeTitle = _darkModeTitle;

  PersonalizeViewController() {
    _initializeThemeTitle();
    _initializeDateFormatValue();
    _initializeLanguageTitle();
  }

  String get menuThemeTitle => _menuThemeTitle;
  bool get isUsingBWMode => _isUsingBWMode;

  bool _isUsingBWMode = false;


  treatThemeValue(final value) async {
    try {
      switch (value) {
        case ThemeMode.system:
          _menuThemeTitle = _systemModeTitle;
          await _setThemeMode(true);
          notifyListeners();
          break;
        case ThemeMode.dark:
          _menuThemeTitle = _darkModeTitle;
          await _setDarkMode(true);
          await _setThemeMode(false);
          notifyListeners();
          break;
        case ThemeMode.light:
          _menuThemeTitle = _lightModeTitle;
          await _setDarkMode(false);
          await _setThemeMode(false);
          notifyListeners();
          break;
      }
    } catch(e) {
      await AppLogs.writeError(e, "settings_personalize_controller.dart");
    }
  }

  triggerBlackAndWhiteMode(bool value) async {
    if (value == true) {
      await AppConfig.modifyConfigValue("using_bw_theme", value);
    }
  }

  _setThemeMode(newValue) async {
    await AppConfig.modifyConfigValue("using_system_theme", newValue);
    AppState.stateChanged();
  }

  _setDarkMode(newValue) async {
    await AppConfig.modifyConfigValue("dark_mode", newValue);
    AppState.stateChanged();
  }

  setBWMode(bool newValue) async {
    await AppConfig.modifyConfigValue("using_bw_mode", newValue);
    AppState.stateChanged();
  }

  Future<bool> _getThemeMode() async {
    return await AppConfig.getConfigValue("using_system_theme");
  }

  Future<bool> _getTheme() async {
    return await AppConfig.getConfigValue("dark_mode");
  }

  Future<bool> _getBWMode() async {
    return await AppConfig.getConfigValue("using_bw_mode");
  }

  _initializeThemeTitle() async {
    bool isUsingSystem = true;
    bool isUsingDarkMode = false;
    await _getBWMode().then((value) => _isUsingBWMode = value);
    await _getTheme().then((value) => isUsingDarkMode = value);
    await _getThemeMode().then((value) => isUsingSystem = value);
    _menuThemeTitle = isUsingSystem 
    ? _systemModeTitle 
    : isUsingDarkMode 
      ? _darkModeTitle 
      : _lightModeTitle;
    notifyListeners();
  }

  

  List<DropdownMenuItem<dynamic>> getThemeItems(BuildContext context) {
    return [
      DropdownMenuItem(
        value: ThemeMode.system,
        child: Text(S.of(context).settings_using_system_theme),
      ),
      DropdownMenuItem(
        value: ThemeMode.dark,
        child: Text(S.of(context).settings_using_dark_mode),
      ),
      DropdownMenuItem(
        value: ThemeMode.light,
        child: Text(S.of(context).settings_using_light_mode),
      ),
    ];
  }

  // Date format setting

  bool get prefetUsDateFormat => _prefetUsDateFormat;
  bool _prefetUsDateFormat = false;

  Future<bool> _getDateFormatPreference() async {
    return await AppConfig.getConfigValue("prefer_us_date_format") ?? false;
  }

  _initializeDateFormatValue() async {
    await _getDateFormatPreference().then((value) => _prefetUsDateFormat = value);
    notifyListeners();
  }

  setDateFormat(bool value) async {
    await AppConfig.modifyConfigValue('prefer_us_date_format', value);
  }


  // Language settings
  static const Map<String, String> _languagesNames = {
    'fr_FR': 'Français (France)',
    'en': 'English',
    'es_ES': 'Español (España)'
  };


  String _menuLanguageTitle = _languagesNames.entries.first.value;

  String get menuLanguageTitle => _menuLanguageTitle;

  _setLanguage(newValue) async {
    await AppConfig.modifyConfigValue("language", newValue);
    AppState.stateChanged();
  }

  Future<String> _getLanguage() async {
    return await AppConfig.getConfigValue("language");
  }

  _initializeLanguageTitle() async {
    String languageCode = "en";
    await _getLanguage().then((value) => languageCode = value);
    _menuLanguageTitle = _languagesNames[languageCode] ?? 'English';
    notifyListeners();
  }

  treatLanguageValue(final String languageCode) async {
  try {
    _menuLanguageTitle = _languagesNames[languageCode] ?? 'English';
    _setLanguage(languageCode);
    S.load(Locale(languageCode));
    notifyListeners();
  } catch(e) {
    await AppLogs.writeError(e, "settings_personalize_controller.dart");
  }
}

  List<DropdownMenuItem<dynamic>> getLanguageItems(BuildContext context) {
    List<DropdownMenuItem<dynamic>> elements = [];
    _languagesNames.forEach((key, value) {
      elements.add(
        DropdownMenuItem(
          value: key,
          child: Text(value),
        ),
      );
    });
    return elements;
  }
}
