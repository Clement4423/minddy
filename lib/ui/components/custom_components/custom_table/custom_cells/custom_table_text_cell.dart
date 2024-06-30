import 'package:flutter/material.dart';
import 'package:minddy/system/interface/i_custom_table_cell_data.dart';
import 'package:minddy/ui/theme/theme.dart';

// ignore: must_be_immutable
class CustomTableTextCell extends StatelessWidget implements ICustomTableCellData {
  CustomTableTextCell({super.key, required this.theme, required this.initialText}) {
    data = initialText;
  }

  String initialText;
  StylesGetters theme;

  @override
  var data = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 5, right: 2),
      child: TextField(
        onChanged: (value) {
          data = value;
        },
        controller: TextEditingController(text: initialText),
        style: theme.bodyMedium.
          copyWith(color: theme.onSurface),
        cursorColor: theme.onSurface,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
}
