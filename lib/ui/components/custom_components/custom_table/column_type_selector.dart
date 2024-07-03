import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/custom_table_type.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_table_view.dart';
import 'package:minddy/ui/theme/theme.dart';

class ColumnTypeSelector extends StatefulWidget {
  const ColumnTypeSelector({
    super.key,
    required this.widget,
    required this.icon, 
    required this.theme,
    required this.colIndex,
    required this.deleteColumnMethod
  });

  final CustomTable widget;
  final Icon icon;
  final int colIndex;
  final Function(int) deleteColumnMethod;
  final StylesGetters theme;

  @override
  State<ColumnTypeSelector> createState() => _ColumnTypeSelectorState();
}

class _ColumnTypeSelectorState extends State<ColumnTypeSelector> {
  bool isHovering = false;
  
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isHovering = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHovering = false;
        });
      },
      child: Container(
        height: widget.widget.cellHeight,
        padding: const EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
          color: widget.theme.surface,
          border: Border.all(color: widget.theme.onSurface, width: 0.25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () async {
                  if (isHovering) {
                    await widget.deleteColumnMethod(widget.colIndex);
                  }
                },
                child: isHovering 
                  ? Tooltip(
                    message: S.of(context).projects_module_spreadsheet_delete_column,
                    child: Icon(Icons.delete_outline_rounded, color: widget.theme.error)
                  )
                  : widget.icon
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: TextField(
                  controller: TextEditingController(text: widget.widget.controller.columnNames[widget.colIndex]),
                  onChanged: (value) {
                    widget.widget.controller.setColumnName(widget.colIndex, value);
                  },
                  style: widget.theme.titleMedium.copyWith(fontWeight: FontWeight.w600),
                  cursorColor: widget.theme.onSurface,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: S.of(context).projects_module_spreadsheet_value_unnamed,
                  ),
                ),
              ),
            ),
            PopupMenuButton(
              icon: Icon(Icons.arrow_drop_down_rounded, color: widget.theme.onSurface),
              onSelected: (value) {
                widget.widget.controller.setColumnType(widget.colIndex, value);
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
              color: widget.theme.primary,
              itemBuilder: (context) {
                return CustomTableType.values.map((value) {
                  return PopupMenuItem(
                    value: value,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(customTableNames[value] ?? ''),
                        customTableIcons[value] ?? const Icon(Icons.error),
                      ],
                    ),
                  );
                }).toList();
              },
            )
          ],
        ),
      ),
    );
  }
}
