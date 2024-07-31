import 'dart:math';
import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/utils/calculations.dart';
import 'package:minddy/ui/components/custom_components/custom_chart/custom_chart_data.dart';
import 'package:minddy/ui/components/custom_components/custom_chart/custom_chart_data_tooltip.dart';
import 'package:minddy/ui/theme/theme.dart';

// ignore: must_be_immutable
class DonutChart extends StatefulWidget {
  List<CustomChartData> values;
  List<Color> colorPalette;
  final double width;
  final double height;
  final String? unit;
  final double innerRadiusRatio;
  final Color? innerCircleColor;

  DonutChart({
    super.key,
    required this.values,
    required this.colorPalette,
    required this.width,
    required this.unit,
    required this.height,
    this.innerRadiusRatio = 0.5,
    this.innerCircleColor = Colors.white
  });

  @override
  State<DonutChart> createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart> {
  int? hoveredIndex;
  int? lastHoveredIndex;
  Key tooltipKey = UniqueKey();

  CustomChartData? getHoveredSectionData() {
    if (hoveredIndex == null) {
      return null;
    }

    return widget.values[hoveredIndex!];
  }

  List<num> _getValuesAsNum() {
    List<num> valuesAsNum = widget.values.map((data) {
      if (data.value is num) {
        return data.value as num;
      } else {
        try {
          return num.tryParse(data.value) ?? 0;
        } catch (e) {
          return 0;
        }
      }
    }).toList();
    
    valuesAsNum.sort();

    valuesAsNum = valuesAsNum.reversed.toList();

    return valuesAsNum;
  }

  late List<num> valuesAsNum;

  late num valuesAsNumTotal;

  @override
  void initState() {
    widget.values.sort((x, y) {
      num a = x.value as num;
      num b = y.value as num;

      return a.compareTo(b);
    });
    widget.values = widget.values.reversed.toList();

    valuesAsNum = _getValuesAsNum();

    valuesAsNumTotal = sum(valuesAsNum);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);

    CustomChartData? hoveredSectionData = getHoveredSectionData();

    bool shouldChangeTooltip = true;


    if (hoveredIndex == lastHoveredIndex) {
      shouldChangeTooltip = false;
    } else {
      lastHoveredIndex = hoveredIndex;
    }

    return CustomChartDataTooltip(
      key: shouldChangeTooltip ? UniqueKey() : tooltipKey,
      value: hoveredSectionData?.value ?? 0,
      secondaryValue: hoveredSectionData?.value != null ? (hoveredSectionData?.value / valuesAsNumTotal) * 100 : null,
      secondaryValuePrefix: '${S.current.custom_chart_donut_share}: ',
      secondaryValueUnit: '%',
      name: hoveredSectionData?.title,
      preferBelow: true,
      maxWidth: widget.width * 0.4,
      unit: widget.unit,
      theme: theme,
      color: widget.colorPalette[hoveredIndex ?? 0],
      waitDuration: hoveredSectionData == null ? const Duration(hours: 1) : Duration.zero,
      child: Transform.rotate(
        angle: -(pi / 2),
        child: MouseRegion(
          onHover: (event) {
            final renderBox = context.findRenderObject() as RenderBox;
            final localPosition = renderBox.globalToLocal(event.position);
            _handleHover(localPosition);
          },
          onExit: (event) {
            setState(() {
              hoveredIndex = null;
            });
          },
          child: CustomPaint(
            size: Size(widget.width, widget.height),
            painter: DonutChartPainter(
              valuesAsNum, 
              0, 
              widget.innerRadiusRatio, 
              widget.innerCircleColor ?? Colors.white, 
              widget.unit,
              theme,
              widget.colorPalette
            ),
          ),
        ),
      ),
    );
  }

  void _handleHover(Offset localPosition) {
    final center = Offset(widget.width / 2, widget.height / 2);
    final touchAngle = ((atan2(localPosition.dy - center.dy, localPosition.dx - center.dx) + 2 * pi) % (2 * pi));
    final radius = (localPosition - center).distance;

    setState(() {
      hoveredIndex = _getHoveredIndex(radius, touchAngle);
    });
  }

  int? _getHoveredIndex(double radius, double angle) {
    final outerRadius = widget.width * 0.9 / 2;
    final innerRadius = outerRadius * widget.innerRadiusRatio;

    if (radius < innerRadius || radius > outerRadius) {
      return null;
    }

    double startAngle = -(pi / 2);
    for (int i = 0; i < widget.values.length; i++) {
      final sweepAngle = (valuesAsNum[i] / valuesAsNumTotal) * 2 * pi;
      final endAngle = startAngle + sweepAngle;

      final normalizedStartAngle = startAngle < 0 ? startAngle + 2 * pi : startAngle;
      final normalizedEndAngle = endAngle < 0 ? endAngle + 2 * pi : endAngle;
      final normalizedAngle = angle < 0 ? angle + 2 * pi : angle;

      bool isWithinSlice = (normalizedAngle >= normalizedStartAngle && normalizedAngle < normalizedEndAngle);

      if (normalizedStartAngle > normalizedEndAngle) {
        isWithinSlice = (normalizedAngle >= normalizedStartAngle || normalizedAngle < normalizedEndAngle);
      }

      if (isWithinSlice) {
        return i;
      }

      startAngle += sweepAngle;
    }
    return null;
  }
}

class DonutChartPainter extends CustomPainter {
  final List<num> values;
  final List<Color> colorPalette;
  double startAngle;
  final double innerRadiusRatio;
  final Color innerCircleColor;
  final String? unit;
  final StylesGetters theme;

  DonutChartPainter(this.values, this.startAngle, this.innerRadiusRatio, this.innerCircleColor, this.unit, this.theme, this.colorPalette);


  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.9 / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < values.length; i++) {
      final sweepAngle = (values[i] / values.reduce((a, b) => a + b)) * 2 * pi;
      paint.color = colorPalette[i];
      canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
      startAngle += sweepAngle;
    }

    final innerCirclePaint = Paint()
    ..color = innerCircleColor;


    canvas.drawCircle(center, radius * innerRadiusRatio, innerCirclePaint);
    // This below will help to rotate the centered text, as it is rotated at 90degrees with the chart.
    canvas.save();

    canvas.translate(center.dx, center.dy);

    canvas.rotate(pi / 2);

    canvas.translate(-center.dx, -center.dy);

    drawTextCentered(
      canvas, 
      center, 
      '${S.current.custom_chart_donut_total}: ${formatCalculation(sum(values).toStringAsFixed(2).replaceAll('.', ','))}${unit ?? ''}', 
      theme.titleMedium, 
      (size.width * innerRadiusRatio - 5)
    );

    canvas.restore();
  }

  TextPainter measureText(
    String s, TextStyle style, double maxWidth, TextAlign align) {
    final span = TextSpan(text: s, style: style);
    final tp = TextPainter(
      text: span, textAlign: align, textDirection: TextDirection.ltr
    );
    tp.layout (minWidth: 0, maxWidth: maxWidth); 
    
    return tp;
}

  Size drawTextCentered (Canvas canvas, Offset position, String text, TextStyle style, double maxWidth){
    final tp = measureText(text, style, maxWidth, TextAlign.center);
    final pos = position + Offset(-tp.width / 2.0, -tp.height / 2.0);

    tp.paint(canvas, pos);
    return tp.size;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}