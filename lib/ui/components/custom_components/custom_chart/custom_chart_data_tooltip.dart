import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/utils/calculate_text_contrast.dart';
import 'package:minddy/system/utils/calculations.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomChartDataTooltip extends StatelessWidget {
  const CustomChartDataTooltip({
    super.key, 
    required this.color, 
    this.name, 
    required this.unit,
    this.secondaryValueUnit,
    this.secondaryValuePrefix,
    required this.value, 
    this.secondaryValue,
    required this.theme, 
    required this.child,
    this.waitDuration,
    this.maxWidth,
    this.preferBelow
  });

  final Color color;
  final String? name;
  final String? unit;
  final String? secondaryValueUnit;
  final String? secondaryValuePrefix;
  final num value;
  final num? secondaryValue;
  final Duration? waitDuration;
  final double? maxWidth;
  final bool? preferBelow;
  final Widget child;
  final StylesGetters theme;

  @override
  Widget build(BuildContext context) {
    Color textColor = color;
    if (!hasSufficientContrast(color, theme.primary)) {
      textColor = theme.onPrimary;
    }
    return Tooltip(
      waitDuration: waitDuration ?? Duration.zero,
      preferBelow: preferBelow,
      decoration: BoxDecoration(
        color: theme.primary,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            offset: const Offset(5, 5),
            blurRadius: 15,
            color: theme.shadow.withValues(alpha: 0.20),
          ),
        ],
      ),
      richMessage: WidgetSpan(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: maxWidth ?? 220,
            maxHeight: secondaryValue != null ? 80 : 60
          ),
          padding: const EdgeInsets.only(top: 5, right: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 15,
                    height: 15,
                    margin: const EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(7.5),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      name ?? S.current.projects_module_spreadsheet_value_unnamed, 
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.titleMedium.copyWith(
                        fontWeight: FontWeight.w600, 
                        color: theme.onPrimary
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      formatCalculation('${value.toStringAsFixed(2).replaceAll('.', ',')}${unit ?? ''}'), 
                      overflow: TextOverflow.ellipsis,
                      style: theme.titleMedium.copyWith(color: textColor),
                    ),
                    if (secondaryValue != null)
                      Text(
                        '$secondaryValuePrefix${formatCalculation('${secondaryValue!.toStringAsFixed(2).replaceAll('.', ',')}${secondaryValueUnit ?? ''}')}', 
                        overflow: TextOverflow.ellipsis,
                        style: theme.titleMedium.copyWith(color: textColor),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      child: child,
    );
  }
}