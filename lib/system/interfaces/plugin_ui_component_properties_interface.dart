import 'package:flutter/material.dart';
import 'package:minddy/system/router/app_router.dart';
import 'package:minddy/system/utils/color_spaces_permutations.dart';

abstract class IPluginUiComponentProperties {
  String toJson() {
    throw UnimplementedError();
  }

  static IPluginUiComponentProperties? fromJson(String string) {
    throw UnimplementedError();
  }

  static String colorToText(Color color) {
    return hslToHex(HSLColor.fromColor(color));
  } 

  static Color colorFromText(String text) {
    BuildContext context = AppRouter.router.navigatorKey.currentContext!;
    if (text.length >= 6) {
      return hexToHsl(text).toColor();
    } else {
      return getThemeColorNames(text, context);
    }
  }

  static Color getThemeColorNames(String text, BuildContext context) {
    Map<String, Color> map = {
      'pr': Theme.of(context).colorScheme.primary,
      'prc': Theme.of(context).colorScheme.primaryContainer,
      'onpr': Theme.of(context).colorScheme.onPrimary,
      'se': Theme.of(context).colorScheme.secondary,
      'onse': Theme.of(context).colorScheme.onSecondary,
      'su': Theme.of(context).colorScheme.surface, // TODO : Fill the list
      'onsu': Theme.of(context).colorScheme.onSurface,
    };

    return map[text] ?? Colors.amber;
  }
}
