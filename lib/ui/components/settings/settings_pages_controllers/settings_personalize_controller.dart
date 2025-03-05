import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/files/app_config.dart';
import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/initialize/app_state.dart';
import 'package:minddy/system/notifications/notification_handler.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/components/custom_components/switch_tile.dart';
import 'package:minddy/ui/components/notifications/notification_widget.dart';
import 'package:minddy/ui/theme/theme.dart';


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
      Future.delayed(const Duration(milliseconds: 260), () { // Duration for the selection menu to close + 10ms
        AppState.stateChanged();
      });
    } catch(e) {
      await AppLogs.writeError(e, "settings_personalize_controller.dart");
    }
  }

  _setThemeMode(value) async {
    AppConfig.data.usingSystemTheme = value;
    await AppConfig.saveConfig();
  }

  _setDarkMode(value) async {
    AppConfig.data.usingDarkMode = value;
    await AppConfig.saveConfig();
  }

  setBWMode(bool newValue) async {
    AppConfig.data.usingBlackAndWhiteMode = newValue;
    await AppConfig.saveConfig();
    _isUsingBWMode = newValue;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 150), () {
      AppState.stateChanged();
    });
  }

  bool _getThemeMode() {
    return AppConfig.data.usingSystemTheme;
  }

  bool _getTheme() {
    return AppConfig.data.usingDarkMode;
  }

  bool _getBWMode() {
    return AppConfig.data.usingBlackAndWhiteMode;
  }

  _initializeThemeTitle() {
    bool isUsingSystem = true;
    bool isUsingDarkMode = false;
    _isUsingBWMode = _getBWMode();
    isUsingDarkMode = _getTheme();
    isUsingSystem = _getThemeMode();
    _menuThemeTitle = isUsingSystem 
    ? _systemModeTitle 
    : isUsingDarkMode 
      ? _darkModeTitle 
      : _lightModeTitle;
  }

  

  List<CustomSelectionMenuItem> getThemeItems(BuildContext context, StylesGetters theme) {
    return [
      CustomSelectionMenuItem(
        label: S.of(context).settings_using_system_theme, 
        foregroundColor: menuThemeTitle == S.of(context).settings_using_system_theme 
          ? theme.secondary 
          : theme.onPrimary,
        icon: null, 
        onTap: () async {
          await treatThemeValue(ThemeMode.system);
        }
      ),
      CustomSelectionMenuItem(
        label: S.of(context).settings_using_dark_mode, 
        foregroundColor: menuThemeTitle == S.of(context).settings_using_dark_mode
          ? theme.secondary 
          : theme.onPrimary,
        icon: null, 
        onTap: () async {
          await treatThemeValue(ThemeMode.dark);
        }
      ),
      CustomSelectionMenuItem(
        label: S.of(context).settings_using_light_mode, 
        foregroundColor: menuThemeTitle == S.of(context).settings_using_light_mode
          ? theme.secondary 
          : theme.onPrimary,
        icon: null, 
        onTap: () async {
          await treatThemeValue(ThemeMode.light);
        }
      )
    ];
  }

  // Date format setting

  bool get prefetUsDateFormat => _prefetUsDateFormat;
  bool _prefetUsDateFormat = false;

  bool _getDateFormatPreference() {
    return AppConfig.data.preferUsDateFormat;
  }

  _initializeDateFormatValue() {
    _prefetUsDateFormat = _getDateFormatPreference();
  }

  setDateFormat(bool value) async {
    AppConfig.data.preferUsDateFormat = value;
    await AppConfig.saveConfig();
  }


  // Language settings
  static const Map<String, String> _languagesNames = {
    'en': 'English',
    'es_ES': 'Español (España)',
    'fr_FR': 'Français (France)',
  };


  String _menuLanguageTitle = _languagesNames.entries.first.value;

  String get menuLanguageTitle => _menuLanguageTitle;

  _setLanguage(newValue) async {
    AppConfig.data.language = newValue;
    await AppConfig.saveConfig();
    AppState.stateChanged();
  }

  String _getLanguage() {
    return AppConfig.data.language ?? 'en';
  }

  _initializeLanguageTitle() async {
    String languageCode = "en";
    languageCode = _getLanguage();
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

  List<CustomSelectionMenuItem> getLanguageItems(BuildContext context, StylesGetters theme) {
    List<CustomSelectionMenuItem> elements = [];
    _languagesNames.forEach((languageCode, languageFullName) {
      elements.add(
        CustomSelectionMenuItem(
          label: languageFullName,
          foregroundColor: menuLanguageTitle == languageFullName ? theme.secondary : theme.onPrimary,
          icon: null,
          onTap: () async {
            if (languageFullName != menuLanguageTitle) {
              await treatLanguageValue(languageCode);
                if (context.mounted) {
                  NotificationHandler.addNotification(
                    NotificationModel(
                      content: S.of(context).snackbar_restart_needed_text,
                      action: closeApp, 
                      actionLabel: S.of(context).snackbar_restart_button, 
                      duration: NotificationDuration.long
                    )
                  );
                }
            }
          }
        )
      );
    });
    return elements;
  }
}
