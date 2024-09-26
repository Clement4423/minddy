import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_table_view.dart';
import 'package:minddy/ui/theme/theme.dart';

class CalculationSelector extends StatefulWidget {
  final Function(String) onFunctionSelected;
  final StylesGetters theme;

  const CalculationSelector({super.key, required this.onFunctionSelected, required this.theme});

  @override
  State<CalculationSelector> createState() => _CalculationSelectorState();
}

class _CalculationSelectorState extends State<CalculationSelector> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Material(
        type: MaterialType.transparency,
        child: CustomSelectionMenu(
          enableSearch: true,
          menuMaxHeight: 300,
          theme: widget.theme, 
          buttonStyle: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(widget.theme.primaryContainer),
            overlayColor: WidgetStatePropertyAll(widget.theme.primaryContainer),
            elevation: const WidgetStatePropertyAll(0),
            padding: const WidgetStatePropertyAll(EdgeInsets.zero),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ))
          ),
          items: getCalculationsMenuItems(widget.theme, 'Null').map((calculationItem) {
            return calculationItem.menuItem..onTap = () {
              widget.onFunctionSelected(calculationItem.calculation);
            };
          }).toList(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(S.of(context).projects_module_spreadsheet_number_operation_calculate, style: widget.theme.bodyMedium
                  .copyWith(color: widget.theme.onPrimary)
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.keyboard_arrow_down_rounded, 
                  color: widget.theme.onPrimary
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}