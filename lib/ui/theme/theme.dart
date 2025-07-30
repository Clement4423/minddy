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

import 'package:flutter/material.dart';
import 'package:minddy/system/files/app_config.dart';

enum UsableThemes {
  light,
  dark,
  system,
  bwLight,
  bwDark
}

class AppTheme{
  static ThemeData get getLightTheme => _isUsingBWMode ? _bwLightThemeData : _themeData;
  static ThemeData get getDarkTheme => _isUsingBWMode ? _bwDarkThemeData : _darkThemeData;
  static ThemeData get getBWLightTheme => _bwLightThemeData;
  static ThemeData get getBWDarkThemeData => _bwDarkThemeData;

  static bool _isUsingBWMode = false;

  static bool get isUsingBWMode => _isUsingBWMode;

  static bool initializeTheme() {
    try {
      bool? usingBWMode = AppConfig.data.usingBlackAndWhiteMode;
      _isUsingBWMode = usingBWMode;
      return true;      
    } catch (e) {
      return false;  
    }
  }

  static ThemeMode getCurrentThemeMode() {
    bool isDarkModeEnabled = AppConfig.data.usingDarkMode;
    bool isUsingSystem = AppConfig.data.usingSystemTheme;
    ThemeMode mode = isUsingSystem 
      ? ThemeMode.system 
      : isDarkModeEnabled 
        ? ThemeMode.dark 
        : ThemeMode.light;
    return mode;
  }

  static final ThemeData _themeData = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      secondaryContainer: Color.fromARGB(255, 116, 232, 255),
      primaryContainer: Color.fromARGB(99, 255, 255, 255),
      primary: Colors.white,
      onPrimary: Colors.black,
      secondary: Color.fromARGB(255, 0, 133, 255,),
      onSecondary: Colors.white,
      surface: Color.fromARGB(255, 215, 245, 255,),
      onSurface: Colors.black,
      error: Colors.red,
      onError: Colors.white,
      shadow: Color.fromARGB(99, 0, 0, 0),
      ),

    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: Colors.white,
    ),

    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontFamily: 'Montserrat', fontSize: 40, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontFamily: 'Montserrat', fontSize: 25, fontWeight: FontWeight.normal),
      bodyMedium: TextStyle(fontFamily: 'Montserrat', fontSize: 16, fontWeight: FontWeight.normal),
      bodySmall: TextStyle(fontFamily: 'Montserrat', fontSize: 12, fontWeight: FontWeight.normal),
      titleLarge: TextStyle(fontFamily: 'Montserrat', fontSize: 25, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontFamily: 'Montserrat', fontSize: 16, fontWeight: FontWeight.bold),
      titleSmall: TextStyle(fontFamily: 'Montserrat', fontSize: 12, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(fontFamily: 'Montserrat', fontSize: 12, fontWeight: FontWeight.w600),
    )
  );

  static final ThemeData _darkThemeData = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      secondaryContainer: Color.fromARGB(255, 34, 48, 52),
      primaryContainer: Color.fromARGB(99, 31, 31, 31),
      primary: Color.fromARGB(255, 31, 31, 31),
      onPrimary: Color.fromARGB(255, 241, 241, 241),
      secondary: Color.fromARGB(255, 0, 133, 255),
      onSecondary: Color.fromARGB(255, 241, 241, 241),
      surface: Color.fromARGB(255, 34, 48, 52),
      onSurface: Color.fromARGB(255, 241, 241, 241),
      error: Colors.red,
      onError: Colors.white,
      shadow: Color.fromARGB(99, 0, 0, 0),
    ),

    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: Color.fromARGB(255, 0, 133, 255),
    ),

    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontFamily: 'Montserrat', fontSize: 40, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontFamily: 'Montserrat', fontSize: 25, fontWeight: FontWeight.normal),
      bodyMedium: TextStyle(fontFamily: 'Montserrat', fontSize: 16, fontWeight: FontWeight.normal),
      bodySmall: TextStyle(fontFamily: 'Montserrat', fontSize: 12, fontWeight: FontWeight.normal),
      titleLarge: TextStyle(fontFamily: 'Montserrat', fontSize: 25, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontFamily: 'Montserrat', fontSize: 16, fontWeight: FontWeight.bold),
      titleSmall: TextStyle(fontFamily: 'Montserrat', fontSize: 12, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(fontFamily: 'Montserrat', fontSize: 12, fontWeight: FontWeight.w600),
    )
  );

  static final ThemeData _bwLightThemeData = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      secondaryContainer: Color.fromARGB(255, 255, 255, 255),
      primaryContainer: Color.fromARGB(99, 255, 255, 255),
      primary: Colors.white,
      onPrimary: Colors.black,
      secondary: Color.fromARGB(255, 0, 0, 0),
      onSecondary: Colors.white,
      surface: Color.fromARGB(255, 220, 220, 220),
      onSurface: Colors.black,
      error: Colors.red,
      onError: Colors.white,
      shadow: Color.fromARGB(99, 0, 0, 0),
      ),

    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: Colors.white,
    ),

    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontFamily: 'Montserrat', fontSize: 40, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontFamily: 'Montserrat', fontSize: 25, fontWeight: FontWeight.normal),
      bodyMedium: TextStyle(fontFamily: 'Montserrat', fontSize: 16, fontWeight: FontWeight.normal),
      bodySmall: TextStyle(fontFamily: 'Montserrat', fontSize: 12, fontWeight: FontWeight.normal),
      titleLarge: TextStyle(fontFamily: 'Montserrat', fontSize: 25, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontFamily: 'Montserrat', fontSize: 16, fontWeight: FontWeight.bold),
      titleSmall: TextStyle(fontFamily: 'Montserrat', fontSize: 12, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(fontFamily: 'Montserrat', fontSize: 12, fontWeight: FontWeight.w600),
    )
  );

  static final ThemeData _bwDarkThemeData = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      secondaryContainer: Color.fromARGB(255, 40, 40, 40),
      primaryContainer: Color.fromARGB(99, 31, 31, 31),
      primary: Color.fromARGB(255, 31, 31, 31),
      onPrimary: Color.fromARGB(255, 241, 241, 241),
      secondary: Color.fromARGB(255, 220, 220, 220),
      onSecondary: Color.fromARGB(255, 31, 31, 31),
      surface: Color.fromARGB(255, 70, 70, 70),
      onSurface: Color.fromARGB(255, 241, 241, 241),
      error: Colors.red,
      onError: Colors.white,
      shadow: Color.fromARGB(99, 0, 0, 0),
    ),

    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: Color.fromARGB(255, 0, 133, 255),
    ),

    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontFamily: 'Montserrat', fontSize: 40, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontFamily: 'Montserrat', fontSize: 25, fontWeight: FontWeight.normal),
      bodyMedium: TextStyle(fontFamily: 'Montserrat', fontSize: 16, fontWeight: FontWeight.normal),
      bodySmall: TextStyle(fontFamily: 'Montserrat', fontSize: 12, fontWeight: FontWeight.normal),
      titleLarge: TextStyle(fontFamily: 'Montserrat', fontSize: 25, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontFamily: 'Montserrat', fontSize: 16, fontWeight: FontWeight.bold),
      titleSmall: TextStyle(fontFamily: 'Montserrat', fontSize: 12, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(fontFamily: 'Montserrat', fontSize: 12, fontWeight: FontWeight.w600),
    )
  );
}

class ButtonThemes {
  static ButtonStyle primaryButtonStyle(BuildContext context) {
    final StylesGetters theme = StylesGetters(context);
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.all(theme.secondary),
      textStyle: WidgetStateProperty.all(theme.bodyMedium.copyWith(color: theme.onSecondary)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        )
      ),
      shadowColor: WidgetStateProperty.all(theme.shadow),
    );
  }

  static ButtonStyle secondaryButtonStyle(BuildContext context) {
    final StylesGetters theme = StylesGetters(context);
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.all(theme.primary),
      textStyle: WidgetStateProperty.all(theme.bodyMedium.copyWith(color: theme.onPrimary)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        )
      ),
      shadowColor: WidgetStateProperty.all(theme.shadow),
    );
  }

  static ButtonStyle crititcButtonTheme(BuildContext context) {
    final StylesGetters theme = StylesGetters(context);
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.all(theme.error),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        )
      ),
      shadowColor: WidgetStateProperty.all(theme.shadow),
    );
  }
}


class StylesGetters{
  final BuildContext context;

  StylesGetters(this.context);

  Brightness get brightness => Theme.of(context).colorScheme.brightness;

  Color get primary => Theme.of(context).colorScheme.primary;
  Color get secondaryContainer => Theme.of(context).colorScheme.secondaryContainer;
  Color get primaryContainer => Theme.of(context).colorScheme.primaryContainer;
  Color get secondary => Theme.of(context).colorScheme.secondary;
  Color get onPrimary => Theme.of(context).colorScheme.onPrimary;
  Color get onSecondary => Theme.of(context).colorScheme.onSecondary;
  Color get surface => Theme.of(context).colorScheme.surface;
  Color get onSurface => Theme.of(context).colorScheme.onSurface;
  Color get error => Theme.of(context).colorScheme.error;
  Color get onError => Theme.of(context).colorScheme.onError;
  Color get shadow => Theme.of(context).colorScheme.shadow;

  TextStyle get headlineLarge => Theme.of(context).textTheme.headlineLarge!;
  TextStyle get headlineSmall => Theme.of(context).textTheme.headlineSmall!;
  TextStyle get bodyLarge => Theme.of(context).textTheme.bodyLarge!;
  TextStyle get bodyMedium => Theme.of(context).textTheme.bodyMedium!;
  TextStyle get bodySmall => Theme.of(context).textTheme.bodySmall!;
  TextStyle get titleLarge => Theme.of(context).textTheme.titleLarge!;
  TextStyle get titleMedium => Theme.of(context).textTheme.titleMedium!;
  TextStyle get titleSmall => Theme.of(context).textTheme.titleSmall!;
}