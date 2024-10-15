import 'package:flutter/material.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomColorPickerHueSlider extends StatefulWidget {
  final double hue;
  final Function(double) onHueChanged;
  final double width;
  final double height;
  final StylesGetters theme;

  const CustomColorPickerHueSlider({
    super.key,
    required this.hue,
    required this.onHueChanged,
    required this.width,
    required this.height,
    required this.theme
  });

  @override
  State<CustomColorPickerHueSlider> createState() =>_CustomColorPickerHueSliderState();
}

class _CustomColorPickerHueSliderState extends State<CustomColorPickerHueSlider> {
  late double _thumbPosition;
  late Color _thumbColor;

  @override
  void initState() {
    super.initState();
    _thumbPosition = widget.hue / 360 * (widget.width - widget.height); // Updated to consider thumb size
    _thumbColor = HSVColor.fromAHSV(1, widget.hue, 1, 1).toColor();
  }

  void _onDragUpdate(Offset localPosition) {
    setState(() {
      // Make sure the thumb stays within the gradient's width minus the radius of the thumb
      _thumbPosition = (localPosition.dx - (widget.height / 2)).clamp(0.0, widget.width - widget.height);
      double newHue = (_thumbPosition / (widget.width - widget.height)) * 360;
      widget.onHueChanged(newHue);

      // Update thumb color based on hue
      _thumbColor = HSVColor.fromAHSV(1, newHue, 1, 1).toColor();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) => _onDragUpdate(details.localPosition),
      child: CustomPaint(
        size: Size(widget.width, widget.height),
        painter: _HueSliderPainter(
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

class _HueSliderPainter extends CustomPainter {
  final double thumbPosition;
  final Color thumbColor;
  final double width;
  final double height;
  final StylesGetters theme;

  _HueSliderPainter({
    required this.thumbPosition,
    required this.thumbColor,
    required this.width,
    required this.height,
    required this.theme
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw the hue gradient
    const gradient = LinearGradient(
      colors: [
        Color.fromARGB(255, 255, 0, 0),
        Color.fromARGB(255, 255, 255, 0),
        Color.fromARGB(255, 0, 255, 0),
        Color.fromARGB(255, 0, 225, 255),
        Color.fromARGB(255, 0, 0, 255),
        Color.fromARGB(255, 166, 0, 255),
        Color.fromARGB(255, 255, 36, 226),
        Color.fromARGB(255, 255, 0, 0),
      ],
      stops: [
        0.0,   // Red (0 degrees)
        1 / 6, // Yellow (60 degrees)
        2 / 6, // Green (120 degrees)
        3 / 6, // Cyan (180 degrees)
        4 / 6, // Blue (240 degrees)
        4.5 / 6, // Purple (300 degrees)
        0.9, // Pink (300 degrees)
        1.0  // Back to Red (360 degrees)
      ],
    );

    final rect = Rect.fromLTWH(0, 0, width, height);
    final paint = Paint()..shader = gradient.createShader(rect);
    final borderRadius = BorderRadius.circular(height / 2);
    
    // Draw slider track (rounded rectangle with gradient)
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

    // Draw the thumb (make sure it fits within the slider bounds)
    final thumbRadius = height / 2;
    final thumbPaint = Paint()..color = thumbColor;
    canvas.drawCircle(
      Offset(thumbPosition + thumbRadius, height / 2), // Position adjusted by thumb radius
      thumbRadius,
      thumbPaint,
    );

    // Draw thumb border (optional for clarity)
    final thumbBorderPaint = Paint()
      ..color = theme.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = height / 5;
    canvas.drawCircle(
      Offset(thumbPosition + thumbRadius, height / 2),
      thumbRadius,
      thumbBorderPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}