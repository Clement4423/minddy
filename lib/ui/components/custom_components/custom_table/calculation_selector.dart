import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_table_view.dart';
import 'package:minddy/ui/theme/theme.dart';

class FunctionSelector extends StatefulWidget {
  final Function(String) onFunctionSelected;
  final StylesGetters theme;

  const FunctionSelector({super.key, required this.onFunctionSelected, required this.theme});

  @override
  State<FunctionSelector> createState() => _FunctionSelectorState();
}

class _FunctionSelectorState extends State<FunctionSelector> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: PopupMenuButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13)
        ),
        color: widget.theme.primary,
        onSelected: (value) {
          setState(() {
            widget.onFunctionSelected(value);
          });
        },
        itemBuilder: (context) {
          return getCalculationsMenuItems(widget.theme, 'Null');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(S.of(context).projects_module_spreadsheet_number_operation_calculate, style: widget.theme.bodyMedium
                .copyWith(color: widget.theme.onPrimary)
              ),
            ),
            Icon(Icons.keyboard_arrow_down_rounded, color: widget.theme.onPrimary)
          ],
        ),
      ),
    );
  }
}