import 'package:flutter/material.dart';
import 'package:minddy/system/model/default_app_color.dart';
import 'package:minddy/system/model/node_connection.dart';
import 'package:minddy/ui/theme/theme.dart';

class NodeConnectionPainter extends CustomPainter {
  final List<NodeConnection> connections;
  final List<NodeConnection> selectedConnections;
  final StylesGetters theme;

  NodeConnectionPainter({required this.connections, required this.selectedConnections, required this.theme});

  @override
  void paint(Canvas canvas, Size size) {
    final normalConnectionPaint = Paint()
      ..color = theme.onSurface
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final selectedConnectionPaint = Paint()
      ..color = DefaultAppColors.blue.color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    for (var connection in connections) {
      Offset startPoint = connection.startNode.outputsOffsets.elementAtOrNull(connection.startOutputIndex) ?? const Offset(0, 0);
      Offset endPoint = connection.endNode.inputsOffsets.elementAtOrNull(connection.endInputIndex) ?? const Offset(0, 0);

      if (startPoint == const Offset(0, 0) || endPoint == const Offset(0, 0)) {
        return;
      }

      startPoint += connection.startNode.position;
      endPoint += connection.endNode.position;

      // Calculate control points for the curve
      final controlPoint1 = Offset(startPoint.dx + (endPoint.dx - startPoint.dx) / 2, startPoint.dy);
      final controlPoint2 = Offset(endPoint.dx - (endPoint.dx - startPoint.dx) / 2, endPoint.dy);

      final path = Path()
        ..moveTo(startPoint.dx, startPoint.dy)
        ..cubicTo(
          controlPoint1.dx, controlPoint1.dy,
          controlPoint2.dx, controlPoint2.dy,
          endPoint.dx, endPoint.dy,
        );

      final Paint paint = selectedConnections.contains(connection) ? selectedConnectionPaint : normalConnectionPaint;

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CurvedLinePainter extends CustomPainter {
  final Offset start;
  final Offset end;
  final Color color;
  final double strokeWidth;
  final bool isHoveringANodePort;
  final Color plusSignColor;

  CurvedLinePainter({
    required this.start,
    required this.end,
    required this.isHoveringANodePort,
    this.color = Colors.black,
    this.plusSignColor = Colors.black,
    this.strokeWidth = 2.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final controlPoint1 = Offset(start.dx + (end.dx - start.dx) / 2, start.dy);
    final controlPoint2 = Offset(end.dx - (end.dx - start.dx) / 2, end.dy);

    final path = Path()
      ..moveTo(start.dx, start.dy)
      ..cubicTo(
        controlPoint1.dx, controlPoint1.dy,
        controlPoint2.dx, controlPoint2.dy,
        end.dx, end.dy,
      );

    canvas.drawPath(path, paint);

    final circlePainter = Paint()
      ..color = color
      ..strokeWidth = 4;

    canvas.drawCircle(start, 3, circlePainter);

    if (!isHoveringANodePort) {
      // Draw a plus sign at the end of the line
      final plusPaint = Paint()
        ..color = plusSignColor
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 1;

      const double plusSize = 3;

      // Draw horizontal line of the plus sign
      canvas.drawLine(
        Offset(end.dx - plusSize, (end.dy - 10)),
        Offset(end.dx + plusSize, (end.dy - 10)),
        plusPaint,
      );

      // Draw vertical line of the plus sign
      canvas.drawLine(
        Offset(end.dx, (end.dy - 10) - plusSize),
        Offset(end.dx, (end.dy - 10) + plusSize),
        plusPaint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // Return true to repaint when necessary (e.g., when start or end changes)
    return true;
  }
}