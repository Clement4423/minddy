import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/files/config.dart';
import 'package:minddy/system/files/app_logs.dart';


class PersonalizeViewController extends ChangeNotifier {

  // Theme settings
  static final String _lightModeTitle = S.current.settings_using_light_mode;
  static final String _darkModeTitle = S.current.settings_using_dark_mode;
  static final String _systemModeTitle = S.current.settings_using_system_theme;


  String _menuThemeTitle = _darkModeTitle;

  PersonalizeViewController() {
    _initializeThemeTitle();
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
  }

  _setDarkMode(newValue) async {
    await AppConfig.modifyConfigValue("dark_mode", newValue);
  }

  setBWMode(bool newValue) async {
    await AppConfig.modifyConfigValue("using_bw_mode", newValue);
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


  // Language settings
  static const Map<String, String> _languagesNames = {
    'fr': 'Français',
    'en': 'English',
    'es': 'Español'
  };

  static const Map<String, String> _languagesCodes = {
    'Français': 'fr',
    'English': 'en',
    'Español': 'es'
  };


  String _menuLanguageTitle = _languagesNames.entries.first.value;

  String get menuLanguageTitle => _menuLanguageTitle;

  _setLanguage(newValue) async {
    await AppConfig.modifyConfigValue("language", newValue);
  }

  Future<String> _getLanguage() async {
    return await AppConfig.getConfigValue("language");
  }

  _initializeLanguageTitle() async {
    String languageCode = "fr";
    await _getLanguage().then((value) => languageCode = value);
    _menuLanguageTitle = _languagesNames[languageCode] ?? 'English';
    notifyListeners();
  }

  treatLanguageValue(final value) async {
  try {
    String languageCode = _languagesCodes[value] ?? 'en';
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
          value: value,
          child: Text(value),
        ),
      );
    });
    return elements;
  }
}
