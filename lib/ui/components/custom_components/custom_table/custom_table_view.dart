import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/interface/i_custom_table_cell_data.dart';
import 'package:minddy/system/model/custom_table_cell_position.dart';
import 'package:minddy/system/model/custom_table_type.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_cells/custom_table_number_cell.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_cells/custom_table_text_cell.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_table_cell.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_table_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomTable extends StatefulWidget {
  final double cellWidth;
  final double cellHeight;
  final CustomTableController controller;

  const CustomTable({
    super.key,
    this.cellWidth = 100,
    this.cellHeight = 40,
    required this.controller,
  });

  @override
  State<CustomTable> createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {

  @override
  void initState() {
    super.initState();
  }

  Widget _buildTitleCell(BuildContext context, StylesGetters theme) {
    StylesGetters theme = StylesGetters(context);
    return Container(
      height: widget.cellHeight,
      decoration: BoxDecoration(
        color: theme.surface,
        border: Border.all(color: theme.onSurface, width: 0.25)
      ),
      child: Center(
        child: TextField(
          onChanged: (value) {
            widget.controller.tableTitle = value;
          },
          controller: TextEditingController(text: widget.controller.tableTitle),
          style: theme.titleMedium.copyWith(color: theme.onSurface),
          cursorColor: theme.onSurface,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(left: 8, right: 2),
            hintText: S.of(context).articles_card_untitled
          ),
        ),
      ),
    );
  }

  Widget _buildColumnTypeSelector(int colIndex, StylesGetters theme) {
    CustomTableType? type = widget.controller.getColumnType(colIndex);
    if (type == null) {
      widget.controller.columnTypes[colIndex] = CustomTableType.text;
    }

    Icon icon = customTableIcons[widget.controller.getColumnType(colIndex)] ?? const Icon(Icons.error);

    return Container(
      height: widget.cellHeight,
      padding: const EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(
        color: theme.surface,
        border: Border.all(color: theme.onSurface, width: 0.25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          icon,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: TextField(
                controller: TextEditingController(text: widget.controller.columnNames[colIndex]),
                onChanged: (value) {
                  widget.controller.setColumnName(colIndex, value);
                },
                style: theme.titleMedium.copyWith(fontWeight: FontWeight.w600),
                cursorColor: theme.onSurface,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Unnamed',
                ),
              ),
            ),
          ),
          PopupMenuButton(
            icon: Icon(Icons.arrow_drop_down_rounded, color: theme.onSurface),
            onSelected: (value) {
              widget.controller.setColumnType(colIndex, value);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13)
            ),
            color: theme.primary,
            itemBuilder: (context) {
              return CustomTableType.values.map((value) {
                return PopupMenuItem(
                  value: value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(customTableNames[value] ?? ''),
                      customTableIcons[value] ?? const Icon(Icons.error)
                    ],
                  )
                );
              }).toList();
            }
          )
        ],
      ),
    );
  }

  Widget _buildRowHeader(int rowIndex, StylesGetters theme) {
    return Container(
      height: widget.cellHeight,
      decoration: BoxDecoration(
        color: theme.surface,
        border: Border.all(color: theme.onSurface, width: 0.25)
      ),
      child: TextField(
        onChanged: (newValue) {
          widget.controller.setRowName(rowIndex, newValue);
        },
        style: theme.titleMedium.copyWith(fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis),
        cursorColor: theme.onSurface,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Unnamed',
          contentPadding: EdgeInsets.only(left: 8, right: 2),
        ),
      ),
    );
  }

  ICustomTableCellData _getCellChildBasedOnType(int columnIndex, dynamic initialValue, StylesGetters theme) {

    CustomTableType type = widget.controller.getColumnType(columnIndex) ?? CustomTableType.text;

    switch (type) {
      case CustomTableType.date:
        return CustomTableTextCell(theme: theme, initialText: initialValue ?? '');
      case CustomTableType.text:
        return CustomTableTextCell(theme: theme, initialText: initialValue ?? '');
      case CustomTableType.number:
        return CustomTableNumberCell(theme: theme, initialValue: initialValue);
      case CustomTableType.phoneNumber:
        return CustomTableNumberCell(theme: theme, initialValue: initialValue);
      case CustomTableType.email:
        return CustomTableTextCell(theme: theme, initialText: initialValue ?? '');
      case CustomTableType.url:
        return CustomTableTextCell(theme: theme, initialText: initialValue ?? '');
      case CustomTableType.selection:
        return CustomTableTextCell(theme: theme, initialText: initialValue ?? '');
    }
  }

  List<TableRow> buildCells(StylesGetters theme) {

    List<TableRow> list = List.generate(widget.controller.rows, (rowIndex) {
      return TableRow(
        decoration: BoxDecoration(
          border: Border.all(color: theme.onSurface),
        ),
        children: List.generate(widget.controller.columns + 1, (colIndex) {
          if (colIndex == 0) {
            return _buildRowHeader(rowIndex + 1, theme);
          } else {
            CustomTableCellPosition position = CustomTableCellPosition(row: rowIndex + 1, column: colIndex);
            return CustomTableCell(
              controller: widget.controller,
              theme: theme,
              position: position,
              height: widget.cellHeight,
              child: _getCellChildBasedOnType(colIndex, widget.controller.getCellData(position), theme)
            );
          }
        }),
      );
    });

    widget.controller.content = list;

    return list;
  }

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, animation) {
        return Table(
          columnWidths: Map.fromIterables(
            List.generate(widget.controller.columns + 1, (index) => index),
            List.generate(widget.controller.columns + 1, (index) => FixedColumnWidth(widget.cellWidth)),
          ),
          children: [
            // First row: Column type selectors
            TableRow(
              decoration: BoxDecoration(
                border: Border.all(color: theme.onSurface),
              ),
              children: List.generate(widget.controller.columns + 1, (colIndex) {
                if (colIndex == 0) {
                  return _buildTitleCell(context, theme);
                } else {
                  return _buildColumnTypeSelector(colIndex, theme);
                }
              }),
            ),
            // Remaining rows
            ...buildCells(theme)
          ],
        );
      }
    );
  }
}

// TODO : Faire le dernier rang avec les options de calculs, et le bouton d'ajout de rang
// TODO : Faire la dernière collone avec le bouton d'ajout de collone