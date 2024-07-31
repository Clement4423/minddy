import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashedLine extends StatelessWidget {
  const DashedLine({
    super.key,
    required this.color,
    required this.dashWidth,
    required this.dashSpace,
    this.lineWidth,
    this.lineHeight,
  });

  final Color color;
  final double dashWidth;
  final double dashSpace;
  final double? lineWidth;
  final double? lineHeight;

  @override
  Widget build(BuildContext context) {
    if (lineWidth != null) {
      // Horizontal dashed line
      return CustomPaint(
        size: Size(lineWidth!, lineHeight ?? 0),
        painter: _DashedLinePainter(
          color: color,
          dashWidth: dashWidth,
          dashSpace: dashSpace,
          isHorizontal: true,
        ),
      );
    } else {
      // Vertical dashed line
      return CustomPaint(
        size: Size(lineWidth ?? 0, lineHeight!),
        painter: _DashedLinePainter(
          color: color,
          dashWidth: dashWidth,
          dashSpace: dashSpace,
          isHorizontal: false,
        ),
      );
    }
  }
}

class _DashedLinePainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpace;
  final bool isHorizontal;

  _DashedLinePainter({
    required this.color,
    required this.dashWidth,
    required this.dashSpace,
    required this.isHorizontal,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    if (isHorizontal) {
      double startX = 0;
      while (startX < size.width) {
        canvas.drawLine(
          Offset(startX, 0),
          Offset(startX + dashWidth, 0),
          paint,
        );
        startX += dashWidth + dashSpace;
      }
    } else {
      double startY = 0;
      while (startY < size.height) {
        canvas.drawLine(
          Offset(0, startY),
          Offset(0, startY + dashWidth),
          paint,
        );
        startY += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}