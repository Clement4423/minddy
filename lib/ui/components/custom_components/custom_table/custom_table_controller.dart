import 'package:flutter/material.dart';
import 'package:minddy/system/model/custom_table_cell_position.dart';
import 'package:minddy/system/model/custom_table_type.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_table_cell.dart';

class CustomTableController extends ChangeNotifier {
  int columns;
  int rows;
  Map<CustomTableCellPosition, dynamic> cellData = {};
  Map<int, CustomTableType> columnTypes = {};
  Map<int, String> columnNames = {};
  Map<int, String> rowNames = {};

  List<TableRow> content = [];

  List<CustomTableType> stringTypes = [CustomTableType.date, CustomTableType.email, CustomTableType.text, CustomTableType.url];
  List<CustomTableType> doublesTypes = [CustomTableType.number, CustomTableType.phoneNumber];

  String tableTitle;

  CustomTableController(this.columns, this.rows, {this.tableTitle = ''});

  void newColumn() {
    columns++;
    notifyListeners();
  }

  void newRow() {
    rows++;
    notifyListeners();
  }

  void updateCell(CustomTableCellPosition position, dynamic data) {
    cellData[position] = data;
  }

  void saveCells() {
    for (TableRow row in content) {
      for (Widget element in row.children) {
        if (element is CustomTableCell) {
          updateCell(element.position, element.child.data);
        }
      }
    }
  }

  dynamic getCellData(CustomTableCellPosition position) {
    return cellData[position];
  }

  void setColumnType(int columnIndex, CustomTableType type) {
    CustomTableType? actualType = getColumnType(columnIndex);

    saveCells();

    if (!isValuesCompatible(actualType, type)) {
      clearDataInAColumn(columnIndex);
    }

    columnTypes[columnIndex] = type;
    notifyListeners();
  }

  void clearDataInAColumn(int columnIndex) {
    cellData.forEach((key, value) {
      if (key.column == columnIndex) {
        cellData[key] = null;
      }
    });
  }

  bool isValuesCompatible(CustomTableType? actualType, CustomTableType newType) {
    if (actualType == null) {
      return false;
    }
    
    if (stringTypes.contains(actualType) && stringTypes.contains(newType)) {
      return true;
    } else if (doublesTypes.contains(actualType) && doublesTypes.contains(newType)) {
      return true;
    } 
    return false;
  }

  CustomTableType? getColumnType(int columnIndex) {
    return columnTypes[columnIndex];
  }

  void setRowName(int rowIndex, String name) {
    rowNames[rowIndex] = name;
  }

  void setColumnName(int columnIndex, String name) {
    columnNames[columnIndex] = name;
  } 

  String? getColumnName(int columnIndex) {
    return columnNames[columnIndex];
  }

  String? getRowName(int rowIndex) {
    return rowNames[rowIndex];
  }
}