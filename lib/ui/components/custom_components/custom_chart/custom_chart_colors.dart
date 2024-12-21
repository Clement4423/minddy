import 'package:flutter/material.dart';

List<Color> generateCategoricalPalette(int count, [HSVColor? baseColor]) {
  List<Color> colors = [];
  HSVColor base = baseColor ?? const HSVColor.fromAHSV(1.0, 210, 0.7, 0.9);
  
  for (int i = 0; i < count + 1; i++) {
    double hue = (base.hue + (360 / count) * i) % 360;
    HSVColor hsvColor = HSVColor.fromAHSV(1.0, hue, base.saturation, base.value);
    colors.add(hsvColor.toColor());
  }

  return colors.sublist(1, count + 1);
}

List<Color> generateSequentialPalette(int count, Color startingColor, [Color? endingColor, double difference = 0.35]) {
  if (count < 2) {
    return [startingColor];
  }
  List<Color> colors = [];
  Color endColor = endingColor ?? startingColor.withValues(red: (startingColor.r - difference).clamp(0, 255)).withValues(green: (startingColor.g - difference).clamp(0, 255)).withValues(blue: (startingColor.b - difference).clamp(0, 255));

  for (int i = 0; i < count; i++) {
    double t = i / (count - 1);
    Color color = Color.lerp(startingColor, endColor, t)!;
    colors.add(color);
  }

  return colors;
}