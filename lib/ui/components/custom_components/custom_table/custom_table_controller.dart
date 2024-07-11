import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:minddy/system/model/custom_table_cell_position.dart';
import 'package:minddy/system/model/custom_table_type.dart';
import 'package:minddy/system/model/number_value.dart';
import 'package:minddy/system/utils/column_letters.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_cells/custom_table_selection_cell.dart';
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

  Map<int, String?> columnsFunctions = {}; // This stands for the calculations that has to be done if the column is of type number
  Map<int, List<CustomTableSelectionCellOptionModel>?> columnsSelectionsOptions = {}; // This stands for the options available per column for the selection data type
  ColumnCalculationController numbersChangeNotifier = ColumnCalculationController();

  Map<CustomTableCellPosition, GlobalKey> globalKeys = {};
  bool needToShowPosition = false;
  CustomTableCellPosition? hiddenPositionCell;
  TextEditingController? currentNumberTextEditingController; 
  // This serve as a bridge between positions widgets shown, and the number cell requesting for them

  List<TableRow> content = [];

  List<CustomTableType> stringTypes = [CustomTableType.number, CustomTableType.email, CustomTableType.text, CustomTableType.url, CustomTableType.phoneNumber];
  List<CustomTableType> uniquesTypes = [CustomTableType.date, CustomTableType.selection];

  String tableTitle;

  bool isExtendingCells = false;
  List<CustomTableCellPosition> selectedCellsForExtension = [];

  CustomTableController(this.columns, this.rows, {this.tableTitle = ''});

  String incrementDigits(String input, int incrementBy, bool isAdding) {
    final regex = RegExp(r'([a-zA-Z])(\d+)\)');

    String replacer(Match match) {
      String letter = match.group(1)!;
      int number = int.parse(match.group(2)!);
      if (isAdding) {
        number = number + incrementBy;
      } else {
        number = number - incrementBy;
      }
      return '$letter$number)';
    }
    return input.replaceAllMapped(regex, replacer);
  }

  extendCellData(CustomTableCellPosition firstCell, List<CustomTableCellPosition> positions) {
    dynamic firstCellData = getCellData(firstCell);
    CustomTableType columnType = getColumnType(firstCell.column) ?? CustomTableType.text;

    if (firstCellData != null) {
      if (columnType == CustomTableType.number) {
        bool isAdding = positions.first.row < positions.last.row;
        for (int i = 0; i < positions.length; i++) {
          updateCell(positions[i], incrementDigits(firstCellData, i, isAdding));
        }
      } else {
        for (CustomTableCellPosition position in positions) {
          updateCell(position, firstCellData);
        }
      }
      notifyListeners();
    }
  }

  void newColumn() {
    saveCells();
    columns++;
    columnTypes[columns] = getMostUsedColumnType();
    notifyListeners();
  }

  void newRow() {
    saveCells();
    rows++;
    notifyListeners();
  }

  CustomTableType getMostUsedColumnType() {
    try {
      CustomTableType? mostUsed;

      Map<CustomTableType, num> count = {};

      for (MapEntry entry in columnTypes.entries) {
        count[entry.value] = count[entry.value] != null ? count[entry.value]! + 1 : 1;
      }

      List<num> counts = count.values.toList();

      if (counts.isEmpty) {
        return CustomTableType.text;
      }

      num max = counts.reduce((a, b) => a > b ? a : b);

      mostUsed = count.entries.lastWhere((element) => element.value == max, orElse: () => const MapEntry(CustomTableType.text, 1),).key;

      return mostUsed;
    } catch (e) {
      return CustomTableType.text;
    }
  }

  void deleteRow(int rowIndex) {
      saveCells();
      
      cellData.removeWhere((key, value) => key.row == rowIndex);
      
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
          updatedCellData[CustomTableCellPosition(row: key.row - 1, column: key.column)] = value;
        } else if (key.row < rowIndex) {
          updatedCellData[key] = value;
        }
      });
      cellData = updatedCellData;

      rows--;
      notifyListeners();
  }

  void deleteColumn(int columnIndex) {
      saveCells();
      
      cellData.removeWhere((key, value) => key.column == columnIndex);
      
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

      // Shift column selections options
      columnsSelectionsOptions.remove(columnIndex);
      Map<int, List<CustomTableSelectionCellOptionModel>?> updatedSelectionsOptions = {};
      columnsSelectionsOptions.forEach((key, value) {
        if (key > columnIndex) {
          updatedSelectionsOptions[key - 1] = value;
        } else {
          updatedSelectionsOptions[key] = value;
        }
      });
      columnsSelectionsOptions = updatedSelectionsOptions;

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

      columns--;
      notifyListeners();
  }

  void updateCell(CustomTableCellPosition position, dynamic data) {
    cellData[position] = data;
  }

  void rebuildCellAt(CustomTableCellPosition position) {
    if (globalKeys[position] != null && globalKeys[position]!.currentState != null) {
      // ignore: invalid_use_of_protected_member
      globalKeys[position]!.currentState!.setState(() {});
    }
  }

  void rebuildEveryNumbersCell() {
    saveCells();
    for (MapEntry<int, CustomTableType> entry in columnTypes.entries) {
      switch (entry.value) {
        case CustomTableType.date:
          continue;
        case CustomTableType.text:
          continue;
        case CustomTableType.number:
          for (TableRow row in content) {
            var element = row.children[entry.key];
            if (element is CustomTableCell) {
              rebuildCellAt(element.position);
            }      
          }
        case CustomTableType.phoneNumber:
          continue;
        case CustomTableType.email:
          continue;
        case CustomTableType.url:
          continue;
        case CustomTableType.selection:
          continue;
      }
    }
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

  List<CustomTableSelectionCellOptionModel>? getColumnSelectionOptions(int columnIndex) {
    return columnsSelectionsOptions[columnIndex];
  }

  void setColumnSelectionOptions(int columnIndex, List<CustomTableSelectionCellOptionModel> options) {
    columnsSelectionsOptions[columnIndex] = options;
  }

  List<num> getAllNumbersFromColumn(int columnIndex) {
    try {
      if (getColumnType(columnIndex) != CustomTableType.number) {
        return [];
      }

      List<num> numbers = [];

      for (var row in content) {
        var element = row.children[columnIndex];
        if (element is CustomTableCell && element.child.data != null) {
          var data = element.child.data.toString().replaceAll(',', '.').replaceAll(RegExp(r'[^\d=.]'), '');
          num? value;
          if (num.tryParse(data) != null) {
            value = num.parse(data);
          } else if (data.startsWith('=')) {
            value = calculateExpression(element.child.data ?? '0')!.value;
          }
          if (value != null) {
            numbers.add(value);
          }
        }
      }

      return numbers;
    } catch(e) {
      return [];
    }
  }

  void numbersChanged() {
    numbersChangeNotifier.numbersChanged();
  }

  void rebuildWholeTable() {
    saveCells();
    notifyListeners();
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
    
    if (stringTypes.contains(actualType) && !uniquesTypes.contains(newType)) {
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

  NumberValue? calculateExpression(String expression) {
    try {
      List<String> tokens = tokenizeExpression(expression);
      List<String> postfix = infixToPostfix(tokens);
      return evaluatePostfix(postfix);
    } catch (e) {
      return null;
    }
  }

  List<String> tokenizeExpression(String expression) {
    List<String> tokens = [];
    RegExp tokenRegex = RegExp(r'\(|\)|\+|-|\*|/|[A-Z]+\d+|\$?£?€?¥?\d+(\.\d+)?%?|\(\$?£?€?¥?\d+(\.\d+)?\)');
    tokenRegex.allMatches(expression).forEach((match) {
      tokens.add(match.group(0)!);
    });
    return tokens;
  }

  List<String> infixToPostfix(List<String> tokens) {
    List<String> output = [];
    Queue<String> operators = Queue<String>();

    for (String token in tokens) {
      if (RegExp(r'[A-Z]+\d+|\d+').hasMatch(token)) {
        output.add(token);
      } else if (token == '(') {
        operators.addLast(token);
      } else if (token == ')') {
        while (operators.isNotEmpty && operators.last != '(') {
          output.add(operators.removeLast());
        }
        operators.removeLast();
      } else {
        while (operators.isNotEmpty && precedence(operators.last) >= precedence(token)) {
          output.add(operators.removeLast());
        }
        operators.addLast(token);
      }
    }

    while (operators.isNotEmpty) {
      output.add(operators.removeLast());
    }

    return output;
  }

  int precedence(String operator) {
    switch (operator) {
      case '+':
      case '-':
        return 1;
      case '*':
      case '/':
        return 2;
      default:
        return 0;
    }
  }

  NumberValue evaluatePostfix(List<String> postfix) {
    List<NumberValue> stack = [];

    for (String token in postfix) {
      if (RegExp(r'[A-Z]+\d+').hasMatch(token)) {
        CustomTableCellPosition cellPosition = parseCellPosition(token);
        String cellValue = getCellData(cellPosition) ?? '0';
        stack.add(parseStringToNumberValue(cellValue));
      } else if (RegExp(r'[^\+\-\*/]').hasMatch(token)) {
        stack.add(parseStringToNumberValue(token));
      } else {
        if (stack.length < 2) {
          return NumberValue(0);
        }
        NumberValue b = stack.removeLast();
        NumberValue a = stack.removeLast();
        switch (token) {
          case '+':
            stack.add(a + b);
            break;
          case '-':
            stack.add(a - b);
            break;
          case '*':
            if (a.isPercentage) {
              stack.add(NumberValue(b.value * a.value, currency: b.currency));
            } else if (b.isPercentage) {
              stack.add(NumberValue(a.value * b.value, currency: a.currency));
            } else {
              stack.add(a * b.value);
            }
            break;
          case '/':
            if (b.value != 0) {
              stack.add(a / b.value);
            } else {
              return NumberValue(0);
            }
            break;
          default:
            return NumberValue(0);
        }
      }
    }

    return stack.length == 1 ? stack.single : NumberValue(0);
  }

  NumberValue parseStringToNumberValue(String value) {
    value = value.trim();

    if (value.startsWith('=')) {
      return calculateExpression(value.substring(1)) ?? NumberValue(0);
    }

    RegExp currencyRegex = RegExp(r'^(\$|£|€|¥)|(\$|£|€|¥)$');
    Match? currencyMatch = currencyRegex.firstMatch(value);
    String? currency = currencyMatch?.group(1) ?? currencyMatch?.group(2);

    if (value.endsWith('%')) {
      String numberPart = value.substring(0, value.length - 1);
      return NumberValue(
        (num.tryParse(numberPart) ?? 0) / 100, 
        isPercentage: true
      );
    }

    String numericString = value.replaceAll(RegExp(r'[^\d.-]'), '');
    
    if (value.startsWith('(') && value.endsWith(')')) {
      numericString = '-$numericString';
    }

    return NumberValue(
      num.tryParse(numericString) ?? 0, 
      currency: currency
    );
  }

  CustomTableCellPosition parseCellPosition(String position) {
    RegExp regex = RegExp(r'([A-Z]+)(\d+)');
    Match? match = regex.firstMatch(position);

    if (match != null && match.groupCount == 2) {
      String columnLetter = match.group(1)!;
      int row = int.parse(match.group(2)!);
      int column = getColumnIndex(columnLetter);
      return CustomTableCellPosition(row: row, column: column);
    } else {
      throw FormatException('Invalid cell position format: $position');
    }
  }
}