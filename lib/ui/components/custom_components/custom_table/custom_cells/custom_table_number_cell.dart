import 'package:flutter/material.dart';
import 'package:minddy/system/interface/i_custom_table_cell_data.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_table_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

// ignore: must_be_immutable
class CustomTableNumberCell extends StatelessWidget implements ICustomTableCellData {
  CustomTableNumberCell({super.key, required this.theme, required this.initialValue, required this.controller}) {
    data = initialValue;
  }

  num? initialValue;
  final CustomTableController controller;
  StylesGetters theme;

  @override
  var data = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 5, right: 2),
      child: TextField(
        onChanged: (value) {
          data = num.tryParse(value) ?? 0;
          controller.numbersChanged();
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