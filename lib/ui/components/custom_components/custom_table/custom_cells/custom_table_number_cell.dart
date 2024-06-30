import 'package:flutter/material.dart';
import 'package:minddy/system/interface/i_custom_table_cell_data.dart';
import 'package:minddy/ui/theme/theme.dart';

// ignore: must_be_immutable
class CustomTableNumberCell extends StatelessWidget implements ICustomTableCellData {
  CustomTableNumberCell({super.key, required this.theme, required this.initialValue}) {
    data = initialValue;
  }

  double? initialValue;
  StylesGetters theme;

  @override
  var data = 0.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 5, right: 2),
      child: TextField(
        onChanged: (value) {
          data = double.tryParse(value) ?? 0.0;
        },
        keyboardType: TextInputType.number,
        controller: TextEditingController(text: initialValue != null ? initialValue.toString() : ''),
        style: theme.bodyMedium.copyWith(color: theme.onSurface),
        cursorColor: theme.onSurface,
        textAlign: TextAlign.right,
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(right: 8),
        ),
      ),
    );
  }
}