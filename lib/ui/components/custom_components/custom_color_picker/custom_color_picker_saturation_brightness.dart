import 'package:flutter/material.dart';
import 'package:minddy/ui/theme/theme.dart';

class SaturationBrightnessBox extends StatefulWidget {
  final double hue;
  final double saturation;
  final double brightness;
  final Function(double, double) onSaturationBrightnessChanged;
  final double width;
  final double height;
  final StylesGetters theme;

  const SaturationBrightnessBox({
    super.key,
    required this.hue,
    required this.saturation,
    required this.brightness,
    required this.onSaturationBrightnessChanged,
    required this.width,
    required this.height,
    required this.theme
  });

  @override
  State<SaturationBrightnessBox> createState() =>_SaturationBrightnessBoxState();
}

class _SaturationBrightnessBoxState extends State<SaturationBrightnessBox> {
  late Offset _thumbPosition;
  late Color _thumbColor;

  late double _saturation;
  late double _brightness;

  @override
  void initState() {
    super.initState();

    _brightness = widget.brightness;

    _saturation = widget.saturation;
    // Initial thumb position based on saturation and brightness
    _thumbPosition = Offset(
      widget.saturation * widget.width,
      (1 - widget.brightness) * widget.height,
    );
    _updateThumbColor();
  }

  void _onDragUpdate(Offset localPosition) {
    setState(() {
      // Calculate new saturation and brightness based on thumb position
      _saturation = (localPosition.dx / widget.width).clamp(0.0, 1.0); // X-axis is saturation
      _brightness = (1 - localPosition.dy / widget.height).clamp(0.0, 1.0); // Y-axis is brightness

      _thumbPosition = Offset(
        _saturation * widget.width,
        (1 - _brightness) * widget.height,
      );

      // Update the thumb color dynamically
      widget.onSaturationBrightnessChanged(_saturation, _brightness);
      _updateThumbColor();
    });
  }

  void _updateThumbColor() {
    _thumbColor = HSVColor.fromAHSV(1.0, widget.hue, _saturation, _brightness).toColor();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) => _onDragUpdate(details.localPosition),
      child: CustomPaint(
        size: Size(widget.width, widget.height),
        painter: _SaturationBrightnessBoxPainter(
          hue: widget.hue,
          thumbPosition: _thumbPosition,
          thumbColor: _thumbColor,
          width: widget.width,
          height: widget.height,
          theme: widget.theme
        ),
      ),
    );
  }
}

class _SaturationBrightnessBoxPainter extends CustomPainter {
  final double hue;
  final Offset thumbPosition;
  final Color thumbColor;
  final double width;
  final double height;
  final StylesGetters theme;

  _SaturationBrightnessBoxPainter({
    required this.hue,
    required this.thumbPosition,
    required this.thumbColor,
    required this.width,
    required this.height,
    required this.theme
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw saturation-brightness box gradient
    final saturationGradient = LinearGradient(
      colors: [
        Colors.white,
        HSVColor.fromAHSV(1, hue, 1, 1).toColor(),
      ],
    );

    const brightnessGradient = LinearGradient(
      colors: [
        Colors.transparent,
        Colors.black,
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    final rect = Rect.fromLTWH(0, 0, width, height);
    final paint = Paint();
    final borderRadius = BorderRadius.circular(8);

    // Draw saturation gradient (left to right, white to full hue)
    paint.shader = saturationGradient.createShader(rect);
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        rect,
        topLeft: borderRadius.topLeft,
        topRight: borderRadius.topRight,
        bottomLeft: borderRadius.bottomLeft,
        bottomRight: borderRadius.bottomRight,
      ),
      paint
    );

    // Overlay brightness gradient (top to bottom, transparent to black)
    paint.shader = brightnessGradient.createShader(rect);
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        rect,
        topLeft: borderRadius.topLeft,
        topRight: borderRadius.topRight,
        bottomLeft: borderRadius.bottomLeft,
        bottomRight: borderRadius.bottomRight,
      ),
      paint
    );

    // Draw the thumb
    const thumbRadius = 10.0; // Adjust thumb size here
    final thumbPaint = Paint()..color = thumbColor;
    canvas.drawCircle(
      thumbPosition,
      thumbRadius,
      thumbPaint,
    );

    // Draw thumb border (optional for clarity)
    final thumbBorderPaint = Paint()
      ..color = theme.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawCircle(
      thumbPosition,
      thumbRadius,
      thumbBorderPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}