import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';

class DefaultAppColor {
  final Color color;
  final String colorName;

  DefaultAppColor({required this.color, required this.colorName});
}

class DefaultAppColors {
  static final DefaultAppColor grey = DefaultAppColor(
    color: const Color.fromARGB(255, 130, 130, 130),
    colorName: S.current.default_app_colors_grey
  );

  static final DefaultAppColor mintGreen = DefaultAppColor(
    color: const Color.fromARGB(255, 0, 215, 122),
    colorName: S.current.default_app_colors_mint_green
  );

  static final DefaultAppColor pink = DefaultAppColor(
    color: const Color.fromARGB(255, 232, 49, 89),
    colorName: S.current.default_app_colors_light_pink
  );

  static final DefaultAppColor yellow = DefaultAppColor(
    color: const Color.fromARGB(255, 216, 160, 19),
    colorName: S.current.default_app_colors_light_yellow
  );

  static final DefaultAppColor peach = DefaultAppColor(
    color: const Color.fromARGB(255, 255, 133, 85),
    colorName: S.current.default_app_colors_peach
  );

  static final DefaultAppColor softRed = DefaultAppColor(
    color: const Color.fromARGB(255, 226, 58, 58),
    colorName: S.current.default_app_colors_soft_red
  );

  static final DefaultAppColor lavender = DefaultAppColor(
    color: const Color.fromARGB(255, 123, 132, 162),
    colorName: S.current.default_app_colors_lavender
  );

  static final DefaultAppColor blue = DefaultAppColor(
    color: const Color.fromARGB(255, 40, 122, 222),
    colorName: S.current.default_app_colors_light_blue
  );

  static final DefaultAppColor lightGreen = DefaultAppColor(
    color: const Color.fromARGB(255, 125, 252, 125),
    colorName: S.current.default_app_colors_light_green
  );

  static final DefaultAppColor lightPurple = DefaultAppColor(
    color: const Color.fromARGB(255, 210, 36, 229),
    colorName: S.current.default_app_colors_light_purple
  );

  static final List<DefaultAppColor> asList = [
    grey,
    mintGreen,
    pink,
    yellow,
    peach,
    softRed,
    lavender,
    blue,
    lightGreen,
    lightPurple,
  ];
}