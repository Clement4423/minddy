import 'package:flutter/material.dart';
import 'package:minddy/ui/theme/theme.dart';

class NodeEditorGridPainter extends CustomPainter {
  final double scale;
  final double pointRadius;
  final StylesGetters theme;

  NodeEditorGridPainter({
    required this.scale,
    this.pointRadius = 0.5,
    required this.theme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = theme.onPrimary.withOpacity(0.4)
      ..style = PaintingStyle.fill;

    double gridSize = 10 * scale;

    for (int i = 0; i * gridSize < size.width; i++) {
      for (int j = 0; j * gridSize < size.height; j++) {
        double x = i * gridSize;
        double y = j * gridSize;

        bool isBrighterPoint = (i % 5 == 0) && (j % 5 == 0);

        if (isBrighterPoint) {
          // Make the point bigger and brighter
          double brighterPointRadius = pointRadius * 1.5;
          Paint brighterPaint = Paint()
            ..color = theme.onPrimary.withOpacity(0.7) // Brighter color
            ..style = PaintingStyle.fill;

          canvas.drawCircle(Offset(x, y), brighterPointRadius, brighterPaint);
        } else {
          // Draw normal circles
          canvas.drawCircle(Offset(x, y), pointRadius, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}