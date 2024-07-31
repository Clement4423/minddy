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

List<Color> generateSequentialPalette(int count, [Color? startingColor, Color? endingColor]) {
  if (count < 2) {
    return startingColor != null 
      ? [startingColor] 
      : [Colors.blue[100]!];
  }
  List<Color> colors = [];
  Color startColor = startingColor ?? Colors.blue[100]!;
  Color endColor = endingColor ?? Colors.blue[800]!;

  for (int i = 0; i < count; i++) {
    double t = i / (count - 1);
    Color color = Color.lerp(startColor, endColor, t)!;
    colors.add(color);
  }

  return colors;
}