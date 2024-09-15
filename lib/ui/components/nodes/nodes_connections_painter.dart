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

      final dx = (endPoint.dx - startPoint.dx).abs().clamp(0, 150);
      final dy = (endPoint.dy - startPoint.dy).abs().clamp(0, 1);

      const bendFactor = 0.5;

      Offset controlPoint1, controlPoint2;
      if (startPoint.dx < endPoint.dx) {
        controlPoint1 = Offset((startPoint.dx + dx * 0.5), startPoint.dy);
        controlPoint2 = Offset((endPoint.dx - dx * 0.5), endPoint.dy);
      } else {
        controlPoint1 = Offset(startPoint.dx + dx * bendFactor, startPoint.dy - dy * bendFactor);
        controlPoint2 = Offset(endPoint.dx - dx * bendFactor, endPoint.dy + dy * bendFactor);
      }

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

    // Calculate the distance between the start and end points
    final dx = (end.dx - start.dx).abs().clamp(0, 150);
    final dy = (end.dy - start.dy).abs().clamp(0, 1);

    const bendFactor = 0.5;

    Offset controlPoint1, controlPoint2;
    if (start.dx < end.dx) {
      controlPoint1 = Offset(start.dx + dx * 0.5, start.dy);
      controlPoint2 = Offset(end.dx - dx * 0.5, end.dy);
    } else {
      controlPoint1 = Offset(start.dx + dx * bendFactor, start.dy - dy * bendFactor);
      controlPoint2 = Offset(end.dx - dx * bendFactor, end.dy + dy * bendFactor);
    }

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
      final plusPaint = Paint()
        ..color = plusSignColor
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 1;

      const double plusSize = 3;

      canvas.drawLine(
        Offset(end.dx - plusSize, end.dy - 10),
        Offset(end.dx + plusSize, end.dy - 10),
        plusPaint,
      );

      canvas.drawLine(
        Offset(end.dx, end.dy - 10 - plusSize),
        Offset(end.dx, end.dy - 10 + plusSize),
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