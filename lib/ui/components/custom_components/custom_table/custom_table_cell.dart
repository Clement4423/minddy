import 'package:flutter/material.dart';
import 'package:minddy/system/interface/i_custom_table_cell_data.dart';
import 'package:minddy/system/model/custom_table_cell_position.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_table_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomTableCell extends StatelessWidget {
  final CustomTableController controller;
  final CustomTableCellPosition position;
  final ICustomTableCellData child;
  final StylesGetters theme;  
  final double height;

  const CustomTableCell({
    super.key,
    required this.controller,
    required this.position,
    required this.child,
    required this.theme,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    controller.updateCell(position, child.data);
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: theme.surface,
        border: Border.all(color: theme.onSurface, width: 0.25),
      ),
      child: child,
    );
  }
}