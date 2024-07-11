import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';

class DefaultAppColor {
  final Color color;
  final String colorName;

  DefaultAppColor({required this.color, required this.colorName});
}

class DefaultAppColors {
  static final DefaultAppColor grey = DefaultAppColor(
    color: const Color.fromARGB(255, 100, 100, 100),
    colorName: S.current.default_app_colors_grey
  );

  static final DefaultAppColor mintGreen = DefaultAppColor(
    color: const Color.fromARGB(255, 94, 151, 126),
    colorName: S.current.default_app_colors_mint_green
  );

  static final DefaultAppColor lightPink = DefaultAppColor(
    color: const Color.fromARGB(255, 174, 120, 132),
    colorName: S.current.default_app_colors_light_pink
  );

  static final DefaultAppColor lightYellow = DefaultAppColor(
    color: const Color.fromARGB(255, 184, 156, 88),
    colorName: S.current.default_app_colors_light_yellow
  );

  static final DefaultAppColor peach = DefaultAppColor(
    color: const Color.fromARGB(255, 184, 133, 113),
    colorName: S.current.default_app_colors_peach
  );

  static final DefaultAppColor softRed = DefaultAppColor(
    color: const Color.fromARGB(255, 164, 102, 102),
    colorName: S.current.default_app_colors_soft_red
  );

  static final DefaultAppColor lavender = DefaultAppColor(
    color: const Color.fromARGB(255, 123, 132, 162),
    colorName: S.current.default_app_colors_lavender
  );

  static final DefaultAppColor lightBlue = DefaultAppColor(
    color: const Color.fromARGB(255, 88, 131, 184),
    colorName: S.current.default_app_colors_light_blue
  );

  static final DefaultAppColor lightGreen = DefaultAppColor(
    color: const Color.fromARGB(255, 113, 161, 113),
    colorName: S.current.default_app_colors_light_green
  );

  static final DefaultAppColor lightPurple = DefaultAppColor(
    color: const Color.fromARGB(255, 138, 91, 143),
    colorName: S.current.default_app_colors_light_purple
  );

  static final List<DefaultAppColor> asList = [
    grey,
    mintGreen,
    lightPink,
    lightYellow,
    peach,
    softRed,
    lavender,
    lightBlue,
    lightGreen,
    lightPurple,
  ];
}