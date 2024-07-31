import 'package:flutter/cupertino.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/custom_components/custom_chart/custom_chart_data_tooltip.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomChartBar extends StatelessWidget {
  const CustomChartBar({
    super.key, 
    required this.color, 
    required this.theme,
    required this.height, 
    required this.width,
    required this.value,
    required this.isHorizontal,
    required this.shouldOffsetUp,
    required this.unit,
    this.secondaryValueForTooltip,
    this.borderRadius,
    this.name
  });

  final Color color;

  final StylesGetters theme;

  final String? name;
  final String? unit;
  final num value;
  final num? secondaryValueForTooltip;
  final BorderRadius? borderRadius;
  final bool shouldOffsetUp;
  final bool isHorizontal;

  final double height;
  final double width;

  double getVerticalOffset() {
    if (isHorizontal) {
      return 0;
    }

    double verticalOffset = 0; 
    if (value.isNegative) {
      verticalOffset = height / 2;
    } else if (shouldOffsetUp) {
      verticalOffset = -(height / 2);
    }
    return verticalOffset;
  }

  double getHorizontalOffset() {
    if (!isHorizontal) {
      return 0;
    }

    double horizontalOffset = 0;
    if (value.isNegative) {
      horizontalOffset = -(width / 2);
    } else if (shouldOffsetUp) {
      horizontalOffset = width / 2;
    }

    return horizontalOffset;
  }

  Widget buildBar() {
    return Transform.translate(
      offset: Offset(getHorizontalOffset(), getVerticalOffset()),
      child: CustomChartDataTooltip(
        color: color,
        name: name,
        value: value,
        secondaryValue: secondaryValueForTooltip,
        secondaryValuePrefix: '${S.current.custom_chart_donut_total}: ',
        secondaryValueUnit: unit,
        unit: unit,
        theme: theme,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: borderRadius ?? BorderRadius.circular(isHorizontal ? height / 5 : width / 5)
          ),
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return isHorizontal 
    ? Row(
      mainAxisAlignment: value.isNegative 
        ? MainAxisAlignment.center
        : shouldOffsetUp
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        buildBar()
      ],
    ) 
    : Column(
      mainAxisAlignment: value.isNegative 
          ? MainAxisAlignment.center
          : shouldOffsetUp
            ? MainAxisAlignment.center
            : MainAxisAlignment.end,
      children: [
        buildBar()
      ], 
    );
  }
}