import 'package:flutter/material.dart';
import 'package:minddy/system/utils/calculations.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_table_view.dart';
import 'package:minddy/ui/components/menus/custom_tooltip.dart';
import 'package:minddy/ui/theme/theme.dart';

class CalculationViewer extends StatefulWidget {
  const CalculationViewer({super.key, required this.calculationName, required this.numbers, required this.theme, required this.onFunctionSelected, required this.isFromLastCell});

  final String calculationName;
  final List<num> numbers;
  final bool isFromLastCell;

  final Function(String) onFunctionSelected;

  final StylesGetters theme;

  @override
  State<CalculationViewer> createState() => _CalculationViewerState();
}

class _CalculationViewerState extends State<CalculationViewer> {

  num performCalculation() {
    switch (widget.calculationName.toLowerCase()) {
      case 'sum':
        return sum(widget.numbers);
      case 'average':
        return average(widget.numbers);
      case 'maximum':
        return maximum(widget.numbers);
      case 'minimum':
        return minimum(widget.numbers);
      case 'interval':
        return interval(widget.numbers);
      case 'median':
        return median(widget.numbers);
      case 'standarddeviation':
        return standardDeviation(widget.numbers);
    }
    return 0;
  }

  String result = '';

  String calculationOpetationTitle = '';

  @override
  void initState() {
    calculationOpetationTitle = calculationsOperationsTitles[widget.calculationName] ?? '';
    result = performCalculation().toStringAsFixed(2).endsWith('00') 
      ? performCalculation().toStringAsFixed(0) 
      : performCalculation().toStringAsFixed(2);
    if (result.length > 9) {
      result = result.substring(0, 7).padRight(11, '.');
    } else if (result == 'NaN') {
      result = '0';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) {
        widget.onFunctionSelected(value);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13)
      ),
      color: widget.theme.primary,
      itemBuilder: (context) {
        return getCalculationsMenuItems(widget.theme, widget.calculationName);
      },
      child: Container(
        decoration: BoxDecoration(
          border: widget.isFromLastCell ? null : Border.symmetric(vertical: BorderSide(color: widget.theme.onPrimary, width: 0.25))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Tooltip(
              message: calculationOpetationTitle.length > 7 ? calculationOpetationTitle : '',
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(calculationOpetationTitle.length > 7 ? calculationOpetationTitle.substring(0, 4).padRight(7, '.') : calculationOpetationTitle, style: widget.theme.bodyMedium
                  .copyWith(color: widget.theme.onPrimary)
                ),
              ),
            ),
            CustomTooltip(
              message: performCalculation().toString().replaceAll('.', ','),
              lengthTreshold: 9,
              child: Padding(
                padding: const EdgeInsets.only(right: 13),
                child: Text(
                  result.replaceAll(',', '.').replaceFirst('.', ','),
                  style: widget.theme.titleMedium
                  .copyWith(
                    color: widget.theme.onPrimary,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}