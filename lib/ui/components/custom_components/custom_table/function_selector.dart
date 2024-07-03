import 'package:flutter/material.dart';
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
    var theme = Theme.of(context);
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13)
      ),
      color: theme.primaryColor,
      onSelected: (value) {
        setState(() {
          widget.onFunctionSelected(value);
        });
      },
      itemBuilder: (context) {
        return calculationsMenuItems;
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text("Calculate", style: widget.theme.bodyMedium
              .copyWith(color: widget.theme.onPrimary)
            ),
          ),
          Icon(Icons.keyboard_arrow_down_rounded, color: widget.theme.onPrimary)
        ],
      ),
    );
  }
}