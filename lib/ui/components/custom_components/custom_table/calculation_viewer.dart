import 'package:flutter/material.dart';
import 'package:minddy/system/model/number_value.dart';
import 'package:minddy/system/utils/calculations.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_table_view.dart';
import 'package:minddy/ui/components/menus/custom_tooltip.dart';
import 'package:minddy/ui/theme/theme.dart';

class CalculationViewer extends StatefulWidget {
  const CalculationViewer({super.key, required this.calculationName, required this.numbers, required this.theme, required this.onFunctionSelected, required this.isFromLastCell});

  final String calculationName;
  final List<NumberValue> numbers;
  final bool isFromLastCell;

  final Function(String) onFunctionSelected;

  final StylesGetters theme;

  @override
  State<CalculationViewer> createState() => _CalculationViewerState();
}

class _CalculationViewerState extends State<CalculationViewer> {

  String? getCurrency() {
    try {
      String? mostUsed;
      Map<String, int> count = {};

      for (var numberValue in widget.numbers) {
        String? currency = numberValue.currency;
        if (currency != null) {
          count[currency] = (count[currency] ?? 0) + 1;
        }
      }

      if (count.isEmpty) {
        return null;
      }

      mostUsed = count.entries.reduce((a, b) => a.value > b.value ? a : b).key;

      return mostUsed;
    } catch (e) {
      return null;
    }
  }

  num performCalculation() {
    List<num> numbers = widget.numbers.map((e) => e.value).toList();
    switch (widget.calculationName.toLowerCase()) {
      case 'sum':
        return sum(numbers);
      case 'average':
        return average(numbers);
      case 'maximum':
        return maximum(numbers);
      case 'minimum':
        return minimum(numbers);
      case 'interval':
        return interval(numbers);
      case 'median':
        return median(numbers);
      case 'standarddeviation':
        return standardDeviation(numbers);
    }
    return 0;
  }

  bool getIsPercentage() {
    for (NumberValue number in widget.numbers) {
      if (number.isPercentage) {
        return true;
      }
    }
    return false;
  }

  String formatResult() {
    String finalResult = result.replaceAll(',', '.').replaceFirst('.', ',');
    String? currency = getCurrency();
    if (currency != null) {
      if (currency == '\$') {
        return '$currency$finalResult';
      } else {
        return '$finalResult$currency';
      }
    } else if (getIsPercentage()) {
      return '$finalResult%';
    } else {
      return finalResult;
    }
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
                  formatResult(),
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