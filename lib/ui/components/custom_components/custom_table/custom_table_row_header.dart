import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_table_view.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomTableRowHeader extends StatefulWidget {
  const CustomTableRowHeader({
    super.key,
    required this.widget, 
    required this.theme, 
    required this.rowIndex, 
    required this.deleteRowMethod,
  });

  final CustomTable widget;

  final StylesGetters theme;
  final int rowIndex;
  final Function(int) deleteRowMethod;

  @override
  State<CustomTableRowHeader> createState() => _CustomTableRowHeaderState();
}

class _CustomTableRowHeaderState extends State<CustomTableRowHeader> {
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
        decoration: BoxDecoration(
          color: widget.theme.surface,
          border: Border.all(color: widget.theme.onSurface, width: 0.25),
        ),
        child: Row(
          children: [
            if (isHovering)
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    widget.deleteRowMethod(widget.rowIndex);
                  },
                  child: Tooltip(
                    message: S.of(context).projects_module_spreadsheet_delete_row,
                    child: Icon(Icons.delete_outline_rounded, color: widget.theme.error)
                  )
                )
              ),
            Expanded(
              child: TextField(
                onChanged: (newValue) {
                  widget.widget.controller.setRowName(widget.rowIndex, newValue);
                },
                controller: TextEditingController(text: widget.widget.controller.getRowName(widget.rowIndex)),
                style: widget.theme.titleMedium.copyWith(fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis),
                cursorColor: widget.theme.onSurface,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: S.of(context).projects_module_spreadsheet_value_unnamed,
                  contentPadding: const EdgeInsets.only(left: 8, right: 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

