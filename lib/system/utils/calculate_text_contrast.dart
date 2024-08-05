import 'dart:math';
import 'dart:ui';

double _relativeLuminance(Color color) {
  num r = color.red / 255.0;
  num g = color.green / 255.0;
  num b = color.blue / 255.0;

  r = r <= 0.03928 ? r / 12.92 : pow((r + 0.055) / 1.055, 2.4);
  g = g <= 0.03928 ? g / 12.92 : pow((g + 0.055) / 1.055, 2.4);
  b = b <= 0.03928 ? b / 12.92 : pow((b + 0.055) / 1.055, 2.4);

  return 0.2126 * r + 0.7152 * g + 0.0722 * b;
}

double _contrastRatio(Color color1, Color color2) {
  final luminance1 = _relativeLuminance(color1);
  final luminance2 = _relativeLuminance(color2);

  final lighter = max(luminance1, luminance2);
  final darker = min(luminance1, luminance2);

  return (lighter + 0.05) / (darker + 0.05);
}

bool hasSufficientContrast(Color textColor, Color backgroundColor, {bool isLargeText = false}) {
  final ratio = _contrastRatio(textColor, backgroundColor);
  return isLargeText ? ratio >= 3.0 : ratio >= 4.5;
}