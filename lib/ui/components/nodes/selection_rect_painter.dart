import 'package:flutter/material.dart';

class SelectionRectPainter extends CustomPainter {
  final Rect rect;
  final Color color;
  double borderRadius;

  SelectionRectPainter(this.rect, this.color, {this.borderRadius = 5.0});

  @override
  void paint(Canvas canvas, Size size) {

    if (rect.width < borderRadius) {
      borderRadius = rect.width / 2;
    } else if (rect.height < borderRadius) {
      borderRadius = rect.height / 2;
    }

    final paint = Paint()
      ..color = color.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Create RRect for rounded rectangle
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    // Draw the rounded rectangle
    canvas.drawRRect(rrect, paint);
    canvas.drawRRect(rrect, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
