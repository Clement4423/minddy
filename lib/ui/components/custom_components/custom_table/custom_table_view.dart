import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/interface/i_custom_table_cell_data.dart';
import 'package:minddy/system/model/custom_table_cell_position.dart';
import 'package:minddy/system/model/custom_table_type.dart';
import 'package:minddy/ui/components/custom_components/custom_table/calculation_viewer.dart';
import 'package:minddy/ui/components/custom_components/custom_table/column_type_selector.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_cells/custom_table_date_cell.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_cells/custom_table_number_cell.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_cells/custom_table_copyable_cell.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_cells/custom_table_selection_cell.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_cells/custom_table_text_cell.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_cells/custom_table_url_cell.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_table_cell.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_table_controller.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_table_row_header.dart';
import 'package:minddy/ui/components/custom_components/custom_table/calculation_selector.dart';
import 'package:minddy/ui/components/custom_components/custom_text_button.dart';
import 'package:minddy/ui/components/menus/custom_tooltip.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomTable extends StatefulWidget {
  final double cellWidth;
  final double cellHeight;

  final CustomTableController controller;

  const CustomTable({
    super.key,
    this.cellWidth = 170,
    this.cellHeight = 40,
    required this.controller
  });

  @override
  State<CustomTable> createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {

  Widget _buildTitleCell(BuildContext context, StylesGetters theme) {
    return Container(
      height: widget.cellHeight,
      decoration: BoxDecoration(
        color: theme.surface,
        border: Border.all(color: theme.onSurface, width: 0.5),
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(10))
      ),
      child: Center(
        child: CustomTooltip(
          message: widget.controller.tableTitle,
          lengthTreshold: 22,
          child: TextField(
            onChanged: (value) {
              widget.controller.tableTitle = value;
            },
            onEditingComplete: () {
              setState(() {});
            },
            controller: TextEditingController(text: widget.controller.tableTitle),
            style: theme.titleLarge.copyWith(color: theme.onSurface, fontSize: 20),
            cursorColor: theme.onSurface,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(left: 8, right: 2),
              hintText: S.of(context).articles_card_untitled,
            ),
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

    return ColumnTypeSelector(
      key: UniqueKey(),
      widget: widget, 
      icon: icon, 
      colIndex: colIndex, 
      theme: theme, 
      deleteColumnMethod: widget.controller.deleteColumn
    );
  }

  Widget _buildRowHeader(int rowIndex, StylesGetters theme) {
    return CustomTableRowHeader(key: UniqueKey(), widget: widget, theme: theme, rowIndex: rowIndex, deleteRowMethod: widget.controller.deleteRow);
  }

  ICustomTableCellData _getCellChildBasedOnType(int columnIndex, dynamic initialValue, CustomTableCellPosition position, StylesGetters theme) {
    CustomTableType type = widget.controller.getColumnType(columnIndex) ?? CustomTableType.text;

    switch (type) {
      case CustomTableType.date:
        return CustomTableDateCell(
          initialValue: initialValue, 
          controller: widget.controller, 
          cellHeight: widget.cellHeight, 
          cellWidth: widget.cellWidth, 
          theme: theme
        );
      case CustomTableType.text:
        return CustomTableTextCell(
          theme: theme, 
          initialText: initialValue ?? ''
        );
      case CustomTableType.number:
        return CustomTableNumberCell(
          theme: theme, 
          controller: widget.controller, 
          key: UniqueKey(),
          position: position,
          initialValue: initialValue ?? ''
        );
      case CustomTableType.phoneNumber:
        return CustomTableCopyableCell(
          theme: theme, 
          initialValue: initialValue ?? ''
        );
      case CustomTableType.email:
        return CustomTableCopyableCell(
          theme: theme, 
          initialValue: initialValue ?? ''
        );
      case CustomTableType.url:
        return CustomTableUrlCell(
          theme: theme, 
          initialValue: initialValue ?? ''
        );
      case CustomTableType.selection:
        return CustomTableSelectionCell(
          theme: theme, 
          columnIndex: columnIndex, 
          controller: widget.controller, 
          cellWidth: widget.cellWidth, 
          cellHeight: widget.cellHeight,
          initialValue: initialValue ?? ''
        );
    }
  }
  // TODO : Faire tous les types de données (Selection)
  // TODO : Faire en sorte de pouvoir convertir en graphiques

  List<TableRow> buildCells(StylesGetters theme) {
    List<TableRow> list = List.generate(widget.controller.rows, (rowIndex) {
      return TableRow(
        children: List.generate(widget.controller.columns + 2, (colIndex) {
          if (colIndex == 0) {
            return _buildRowHeader(rowIndex + 1, theme);
          } else if (colIndex == widget.controller.columns + 1) {
            return const SizedBox();
          } else {
            CustomTableCellPosition position = CustomTableCellPosition(row: rowIndex + 1, column: colIndex);
            generateGlobalKey(position);
            return CustomTableCell(
              key: widget.controller.globalKeys[position] ?? GlobalKey(), // This is to make sure we can rebuild individually each cell
              controller: widget.controller,
              theme: theme,
              position: position,
              height: widget.cellHeight,
              width: widget.cellWidth,
              child: _getCellChildBasedOnType(colIndex, widget.controller.getCellData(position), position, theme),
            );
          }
        }),
      );
    });

    widget.controller.content = list;

    return list;
  }

  void generateGlobalKey(CustomTableCellPosition position) {
    widget.controller.globalKeys[position] = GlobalKey();
  }
  
  @override
  void dispose() {
    verticalScrollController.dispose();
    horizontalScrollController.dispose();
    super.dispose();
  }

  ScrollController verticalScrollController = ScrollController();
  ScrollController horizontalScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, animation) {
        return Scrollbar(
          controller: verticalScrollController,
          child: ListView(
            scrollDirection: Axis.vertical,
            controller: verticalScrollController,
            children: [
              SizedBox(
                height: (widget.controller.rows + 3) * widget.cellHeight, 
                // Multiplied by 3 because we want a space of 1 cell height between the last row 
                // and the scrollbar, and since we got 2 rows that are displayed but not refered 
                // in the widget.controller.rows, we multiply by 3.
                child: Scrollbar(
                  controller: horizontalScrollController,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    controller: horizontalScrollController,
                    children: [
                      Table(
                        columnWidths: Map.fromIterables(
                          List.generate(widget.controller.columns + 1, (index) => index),
                          List.generate(widget.controller.columns + 1, (index) {
                            if (index == 0) {
                              return FixedColumnWidth(widget.cellWidth * 1.2);
                            } else {
                              return FixedColumnWidth(widget.cellWidth);
                            }
                          }),
                        ),
                        defaultColumnWidth: FixedColumnWidth(widget.cellWidth),
                        children: [
                          // First Row
                          TableRow(
                            children: List.generate(widget.controller.columns + 2, (colIndex) {
                              if (colIndex == 0) {
                                return _buildTitleCell(context, theme);
                              } else if (colIndex == widget.controller.columns + 1) {
                                return Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10, top: 5),
                                      child: IconButton(
                                        onPressed: () {
                                          widget.controller.newColumn();
                                        },
                                        tooltip: S.of(context).projects_module_spreadsheet_new_column,
                                        style: ButtonThemes.secondaryButtonStyle(context),
                                        icon: const Icon(Icons.add_rounded)
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10, top: 5),
                                      child: IconButton(
                                        onPressed: () {
                                          // TODO : Faire le menu de gestion du tableau
                                        },
                                        tooltip: S.of(context).projects_module_notes_modify_category,
                                        style: ButtonThemes.secondaryButtonStyle(context),
                                        icon: const Icon(Icons.more_horiz_rounded)
                                      ),
                                    )
                                  ],
                                );
                              } else {
                                return _buildColumnTypeSelector(colIndex, theme);
                              }
                            }),
                          ),
                          // Content
                          ...buildCells(theme),
                          // Last row
                          TableRow(
                            children: [
                              ...List.generate(widget.controller.columns + 2, (colIndex) {
                                if (colIndex == 0) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: CustomTextButton(
                                      S.of(context).projects_module_spreadsheet_new_row,
                                      () {
                                        widget.controller.newRow();
                                      }, 
                                      false, 
                                      isSecondary: true,
                                      false
                                    ),
                                  );
                                } else if (widget.controller.getColumnType(colIndex) == CustomTableType.number) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: widget.controller.getColumnCalculation(colIndex) != null 
                                      ? AnimatedBuilder(
                                        animation: widget.controller.numbersChangeNotifier,
                                        builder: (context, animation) {
                                          return Padding(
                                            padding: const EdgeInsets.only(top: 5),
                                            child: CalculationViewer(
                                              key: UniqueKey(), // Keep it or it will not refresh
                                              calculationName: widget.controller.getColumnCalculation(colIndex) ?? 'sum', 
                                              numbers: widget.controller.getAllNumbersFromColumn(colIndex),
                                              isFromLastCell: colIndex == widget.controller.columns,
                                              onFunctionSelected: (name) {
                                                widget.controller.setColumnCalculation(colIndex, name);
                                              },
                                              theme: theme,
                                            ),
                                          );
                                        }
                                      )
                                      : Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: FunctionSelector(
                                            theme: theme,
                                            onFunctionSelected: (name) {
                                              widget.controller.setColumnCalculation(colIndex, name);
                                            }, 
                                          ),
                                      ),
                                  );
                                } 
                                else {
                                  return const SizedBox();
                                }
                              })
                            ]
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

List<PopupMenuItem<String>> getCalculationsMenuItems(StylesGetters theme, String selected) {

  TextStyle getStyle(String value) {
    return value == 'Null' 
    ? theme.titleMedium.copyWith(color: theme.onPrimary) 
    : value == selected 
      ? theme.bodyMedium.copyWith(color: theme.secondary)
      : theme.bodyMedium.copyWith(color: theme.onPrimary);
  }

  return [
    PopupMenuItem(
      value: 'Null',
      child: Text(calculationsOperationsTitles['Null'] ?? 'None', style: getStyle('Null'),)
    ),
    PopupMenuItem(
      value: 'sum',
      child: Text(calculationsOperationsTitles['sum'] ?? 'Sum', style: getStyle('sum'),)
    ),
    PopupMenuItem(
      value: 'average',
      child: Text(calculationsOperationsTitles['average'] ?? 'Average', style: getStyle('average'),)
    ),
    PopupMenuItem(
      value: 'maximum',
      child: Text(calculationsOperationsTitles['maximum'] ?? 'Maximum', style: getStyle('maximum'),)
    ),
    PopupMenuItem(
      value: 'minimum',
      child: Text(calculationsOperationsTitles['minimum'] ?? 'Minimum', style: getStyle('minimum'),)
    ),
    PopupMenuItem(
      value: 'interval',
      child: Text(calculationsOperationsTitles['interval'] ?? 'Interval', style: getStyle('interval'),)
    ),
    PopupMenuItem(
      value: 'median',
      child: Text(calculationsOperationsTitles['median'] ?? 'Median', style: getStyle('median'),)
    ),
    PopupMenuItem(
      value: 'standardDeviation',
      child: Text(calculationsOperationsTitles['standardDeviation'] ?? 'Standard Deviation', style: getStyle('standardDeviation'),)
    )
  ];
}



// TODO : Faire des tooltips pour expliquer à quoi chaque opération sert

Map<String, String> calculationsOperationsTitles = {
  'Null': S.current.projects_module_spreadsheet_number_operation_none,
  'sum': S.current.projects_module_spreadsheet_number_operation_sum,
  'average': S.current.projects_module_spreadsheet_number_operation_average,
  'maximum': S.current.projects_module_spreadsheet_number_operation_maximum,
  'minimum': S.current.projects_module_spreadsheet_number_operation_minimum,
  'interval': S.current.projects_module_spreadsheet_number_operation_interval,
  'median': S.current.projects_module_spreadsheet_number_operation_median,
  'standardDeviation': S.current.projects_module_spreadsheet_number_operation_standard_deviation
};