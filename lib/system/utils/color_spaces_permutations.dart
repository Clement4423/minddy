import 'package:flutter/material.dart';

Color mixColors(Color color1, Color color2, double ratio) {
  // Clamp ratio to [0, 1]
  ratio = ratio.clamp(0.0, 1.0);

  int r = (color1.red * ratio + color2.red * (1 - ratio)).round();
  int g = (color1.green * ratio + color2.green * (1 - ratio)).round();
  int b = (color1.blue * ratio + color2.blue * (1 - ratio)).round();
  int a = (color1.alpha * ratio + color2.alpha * (1 - ratio)).round();

  return Color.fromARGB(a, r, g, b);
}

String hslToHex(HSLColor hslColor) {

  final double h = hslColor.hue;
  final double s = hslColor.saturation;
  final double l = hslColor.lightness;

  double c = (1 - (2 * l - 1).abs()) * s;
  double x = c * (1 - ((h / 60) % 2 - 1).abs());
  double m = l - c / 2;

  double r = 0, g = 0, b = 0;

  if (0 <= h && h < 60) {
    r = c;
    g = x;
    b = 0;
  } else if (60 <= h && h < 120) {
    r = x;
    g = c;
    b = 0;
  } else if (120 <= h && h < 180) {
    r = 0;
    g = c;
    b = x;
  } else if (180 <= h && h < 240) {
    r = 0;
    g = x;
    b = c;
  } else if (240 <= h && h < 300) {
    r = x;
    g = 0;
    b = c;
  } else if (300 <= h && h < 360) {
    r = c;
    g = 0;
    b = x;
  }

  int rHex = ((r + m) * 255).round();
  int gHex = ((g + m) * 255).round();
  int bHex = ((b + m) * 255).round();
  int alphaHex = (hslColor.alpha * 255).clamp(0, 255).round();

  return '${rHex.toRadixString(16).padLeft(2, '0')}${gHex.toRadixString(16).padLeft(2, '0')}${bHex.toRadixString(16).padLeft(2, '0')}${alphaHex.toRadixString(16).padLeft(2, '0')}';
}

HSLColor hexToHsl(String hex) {
  // Remove the leading "#" if present
  hex = hex.replaceAll('#', '');

  // Check if alpha is included (8 characters for rgba, otherwise 6 characters)
  bool hasAlpha = hex.length == 8;

  // Extract RGB and Alpha values
  int r = int.parse(hex.substring(0, 2), radix: 16);
  int g = int.parse(hex.substring(2, 4), radix: 16);
  int b = int.parse(hex.substring(4, 6), radix: 16);
  double alpha = hasAlpha
      ? (int.parse(hex.substring(6), radix: 16) / 255).clamp(0, 1.0).toDouble()
      : 1.0;

  // Normalize RGB values
  double rPrime = r / 255;
  double gPrime = g / 255;
  double bPrime = b / 255;

  double max = [rPrime, gPrime, bPrime].reduce((a, b) => a > b ? a : b);
  double min = [rPrime, gPrime, bPrime].reduce((a, b) => a < b ? a : b);
  double delta = max - min;

  // Calculate luminance
  double l = (max + min) / 2;

  double h = 0;
  double s = 0;

  // Calculate saturation
  if (delta != 0) {
    s = delta / (1 - (2 * l - 1).abs());

    // Calculate hue
    if (max == rPrime) {
      h = 60 * (((gPrime - bPrime) / delta) % 6);
    } else if (max == gPrime) {
      h = 60 * (((bPrime - rPrime) / delta) + 2);
    } else if (max == bPrime) {
      h = 60 * (((rPrime - gPrime) / delta) + 4);
    }
  }

  if (h < 0) h += 360;

  // Return HSLColor with alpha
  return HSLColor.fromAHSL(alpha, h, s.clamp(0, 1.0), l.clamp(0, 1.0));
}

HSVColor hslToHsv(HSLColor color) {
  double v = color.lightness + color.saturation * (color.lightness < 0.5 ? color.lightness : 1 - color.lightness);
  double newS = v == 0 ? 0 : 2 * (1 - color.lightness / v);
  
  return HSVColor.fromAHSV(color.alpha, color.hue, newS, v);
}