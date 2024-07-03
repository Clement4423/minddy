import 'package:flutter/material.dart';
import 'package:minddy/system/model/custom_table_cell_position.dart';
import 'package:minddy/system/model/custom_table_type.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_table_cell.dart';

class ColumnCalculationController extends ChangeNotifier {
  numbersChanged() {
    notifyListeners();
  }
}

class CustomTableController extends ChangeNotifier {
  int columns;
  int rows;
  Map<CustomTableCellPosition, dynamic> cellData = {};
  Map<int, CustomTableType> columnTypes = {};
  Map<int, String> columnNames = {};
  Map<int, String> rowNames = {};

  Map<int, String?> columnsFunctions = {}; // This stand for the calculations that has to be done if the column is of type number
  ColumnCalculationController numbersChangeNotifier = ColumnCalculationController();

  List<TableRow> content = [];

  List<CustomTableType> stringTypes = [CustomTableType.date, CustomTableType.email, CustomTableType.text, CustomTableType.url, CustomTableType.phoneNumber];
  List<CustomTableType> doublesTypes = [CustomTableType.number];

  String tableTitle;

  CustomTableController(this.columns, this.rows, {this.tableTitle = ''});

  void newColumn() {
    saveCells();
    columns++;
    notifyListeners();
  }

  void newRow() {
    saveCells();
    rows++;
    notifyListeners();
  }

void deleteRow(int rowIndex) {
  saveCells();
  rows--;
  clearDataInARow(rowIndex);

  // Shift row names
  rowNames.remove(rowIndex);
  Map<int, String> updatedRowNames = {};
  rowNames.forEach((key, value) {
    if (key > rowIndex) {
      updatedRowNames[key - 1] = value;
    } else {
      updatedRowNames[key] = value;
    }
  });
  rowNames = updatedRowNames;

  // Shift cell data
  Map<CustomTableCellPosition, dynamic> updatedCellData = {};
  cellData.forEach((key, value) {
    if (key.row > rowIndex) {
      updatedCellData[CustomTableCellPosition(row: key.row - 1, column:  key.column)] = value;
    } else if (key.row < rowIndex) {
      updatedCellData[key] = value;
    }
  });
  cellData = updatedCellData;

  notifyListeners();
}

void deleteColumn(int columnIndex) {
  saveCells();
  columns--;
  clearDataInAColumn(columnIndex);

  // Shift column types
  columnTypes.remove(columnIndex);
  Map<int, CustomTableType> updatedColumnTypes = {};
  columnTypes.forEach((key, value) {
    if (key > columnIndex) {
      updatedColumnTypes[key - 1] = value;
    } else {
      updatedColumnTypes[key] = value;
    }
  });
  columnTypes = updatedColumnTypes;

  // Shift column names
  columnNames.remove(columnIndex);
  Map<int, String> updatedColumnNames = {};
  columnNames.forEach((key, value) {
    if (key > columnIndex) {
      updatedColumnNames[key - 1] = value;
    } else {
      updatedColumnNames[key] = value;
    }
  });
  columnNames = updatedColumnNames;

  // Shift column functions
  columnsFunctions.remove(columnIndex);
  Map<int, String?> updatedColumnsFunctions = {};
  columnsFunctions.forEach((key, value) {
    if (key > columnIndex) {
      updatedColumnsFunctions[key - 1] = value;
    } else {
      updatedColumnsFunctions[key] = value;
    }
  });
  columnsFunctions = updatedColumnsFunctions;

  // Shift cell data
  Map<CustomTableCellPosition, dynamic> updatedCellData = {};
  cellData.forEach((key, value) {
    if (key.column > columnIndex) {
      updatedCellData[CustomTableCellPosition(row: key.row, column: key.column - 1)] = value;
    } else if (key.column < columnIndex) {
      updatedCellData[key] = value;
    }
  });
  cellData = updatedCellData;

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

  void setColumnCalculation(int columnIndex, String function) {
    columnsFunctions[columnIndex] = function == 'Null' ? null : function;
    saveCells();
    notifyListeners();
  }

  String? getColumnCalculation(int columnIndex) {
    return columnsFunctions[columnIndex];
  }

  List<num> getAllNumbersFromColumn(int columnIndex) {
    if (getColumnType(columnIndex) != CustomTableType.number) {
      return [];
    }

    List<num> numbers = [];

    for (TableRow row in content) {
      var element = row.children[columnIndex];
      if (element is CustomTableCell) {
       if (element.child.data != null) {
        numbers.add(element.child.data);
       }
      }      
    }

    return numbers;
  }

  void numbersChanged() {
    numbersChangeNotifier.numbersChanged();
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

  void clearDataInARow(int rowIndex) {
    cellData.forEach((key, value) {
      if (key.row == rowIndex) {
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