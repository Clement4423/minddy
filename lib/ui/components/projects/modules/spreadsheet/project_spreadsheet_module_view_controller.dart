import 'package:flutter/material.dart';
import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:minddy/system/interface/projects_modules_controller_interface.dart';
import 'package:minddy/system/model/custom_table_cell_position.dart';
import 'package:minddy/system/model/custom_table_type.dart';
import 'package:minddy/system/model/number_value.dart';
import 'package:minddy/system/model/projects_modules.dart';
import 'package:minddy/system/projects/get_module_data.dart';
import 'package:minddy/system/utils/calculations.dart';
import 'package:minddy/system/utils/create_unique_id.dart';
import 'package:minddy/ui/components/custom_components/custom_chart/custom_chart_data.dart';
import 'package:minddy/ui/components/custom_components/custom_chart/custom_chart_types.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_cells/custom_table_selection_cell.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_table_controller.dart';

class ProjectsSpreadsheetModuleController extends ChangeNotifier implements IProjectModuleController {
  @override
  int id;

  @override
  String projectPath;

  late CustomTableController customTableController;

  ProjectsSpreadsheetModuleController({required this.id, required this.projectPath}) {
    customTableController = CustomTableController(1, 1, tableTitle: id.toString());
    initialize().then((value) => WidgetsBinding.instance.addPostFrameCallback((_) {notifyListeners();}));
  }

  bool showTable = true;

  int? activeTab;

  Map<int, String> tabs = {
    // ID -> Name
  };

  Map<int, String> chartsTypes = {
    // ID -> Type as string
  };

  Map<int, List<int>> chartColumns = {
    // ID -> List of columns numbers
  };

  Future<void> changeView() async {
    if (showTable) {
      showTable = false;
    } else {
      showTable = true;
    }

    await rebuild();
  }

  Future<void> selectTab(int tabId) async {
    activeTab = tabId;

    await rebuild();
  }

  Future<void> newTab() async {
    int id = createUniqueId();
    tabs[id] = '';
    chartsTypes[id] = CustomChartType.barSingle.name;
    chartColumns[id] = [-1];

    activeTab = id;

    await rebuild();
  }

  Future<void> renameTab(int tabId, String newName) async {
    tabs[tabId] = newName;

    await rebuild();
  }

  Future<void> deleteTab(int tabId) async {
    tabs.remove(tabId);
    chartColumns.remove(tabId);
    chartsTypes.remove(tabId);

    if (tabs.entries.isEmpty) {
      newTab();
      return;
    }

    activeTab = tabs.entries.last.key;

    await rebuild();
  }

  Future<void> selectChartType(int tabId, CustomChartType newType) async {
    chartsTypes[tabId] = newType.name;

    await rebuild();
  }

  Future<void> addChartColumn(int tabId) async {
    chartColumns[tabId]?.add(-1);
    await rebuild();
  }

  Future<void> updateChartColumn(int tabId, int lastColumnindex, int newColumnIndex) async {
    int lastIndex = chartColumns[tabId]?.indexOf(lastColumnindex) ?? 0;
    if (lastIndex == -1) {
      chartColumns[tabId]?.clear();
      return;
    }
    chartColumns[tabId]?[lastIndex] = newColumnIndex;
    await rebuild();
  }

  Future<void> deleteChartColumn(int tabId, int columnIndex) async {
    chartColumns[tabId]?.remove(columnIndex);
    await rebuild();
  }

  CustomChartType getChartType(int tabID) {
    String typeAsString = chartsTypes[tabID] ?? '';

    if (typeAsString == '') {
      return CustomChartType.barSingle;
    } 

    for (CustomChartType type in CustomChartType.values) {
      if (typeAsString == type.name) {
        return type;
      }
    }

    return CustomChartType.barSingle;
  }

  String? getChartUnit(int tabID) {
    List<int> columns = chartColumns[tabID] ?? [];

    int isPercentageCount = 0;
    Map<String, int> currenciesCount = {};

    for (MapEntry<int, String> row in customTableController.rowNames.entries) {
      for (int column in columns) {
          var result = _tryFormatNumber(customTableController.getCellData(CustomTableCellPosition(row: row.key, column: column)));

          if (result.isPercentage) {
            isPercentageCount++;
          } else if (result.currency != null) {
            if (currenciesCount[result.currency] == null) {
              currenciesCount[result.currency!] = 1;
            } else {
              currenciesCount[result.currency!] = currenciesCount[result.currency!]! + 1;
            }
          }

      }
    }

    var maxCurrencyCount = maximum(currenciesCount.entries.map((e) => num.parse(e.value.toString())).toList());

    if (maxCurrencyCount > isPercentageCount) {
      return currenciesCount.entries.firstWhere((element) => element.value == maxCurrencyCount).key;
    } else if (isPercentageCount > maxCurrencyCount) {
      return '%';
    } else {
      return null;
    }
  }

  List<CustomChartDataMultiple> getChartContent(int tabID) {
    List<int> columns = chartColumns[tabID] ?? [];

    List<CustomChartDataMultiple> rowsData = [];

    for (MapEntry<int, String> row in customTableController.rowNames.entries) {
      List<CustomChartData> columnsData = [];
      for (int column in columns) {
        if (customTableController.getColumnType(column) == CustomTableType.number) {
        columnsData.add(
          CustomChartData(
            title: getChartType(tabID) == CustomChartType.donut || getChartType(tabID) == CustomChartType.barSingle 
              ? customTableController.getRowName(row.key) 
              : customTableController.getColumnName(column),
            value: _tryFormatNumber(
              customTableController.getCellData(
                CustomTableCellPosition(row: row.key, column: column)
              )
            ).value
          )
        );        
      }
    }
      bool isNotEmpty = columnsData.map((value) => value.value == 0).toList().contains(false);
      if (isNotEmpty) {
        rowsData.add(CustomChartDataMultiple(values: columnsData, title: customTableController.getRowName(row.key)));
      }
    }

    return rowsData;
  }

  NumberValue _tryFormatNumber(dynamic input) {
    if (input == null) {
      return NumberValue(0);
    }

    NumberValue? value;

    if (input.toString().startsWith('=')) {
      value = customTableController.calculateExpression(input);
    } else {
      value = revertFormattedCalculation(input);
    }
    
    return value ?? NumberValue(0);
  }

  Future<bool> initialize() async {
    try {
      Map<String, dynamic>? data = await getModuleData(id, ProjectsModulesTypes.spreadsheet, projectPath);
      if (data == null) {
        await StaticVariables.fileSource.createFile("$projectPath/${ProjectsModulesTypes.spreadsheet.name}/$id.json");
        await StaticVariables.fileSource.writeJsonFile(
          "$projectPath/${ProjectsModulesTypes.spreadsheet.name}/$id.json", 
          defaultDataFormat
        );
      }
      await updateCustomTableController(data);
      showTable = data?["show_table"] ?? true;
      tabs = convertMapToMapIntString(data?["tabs"] ?? {});
      if (tabs.isEmpty) {
        newTab();
      }
      chartsTypes = convertMapToMapIntString(data?["charts_types"] ?? {});
      chartColumns = convertMapToMapIntListInt(data?["charts_columns"] ?? {});
      activeTab = tabs.isNotEmpty 
        ? int.tryParse(data?["active_tab"].toString() ?? tabs.entries.first.key.toString()) ?? tabs.entries.first.key
        : null;
      return true;
    } catch (e) {
      await AppLogs.writeError(e, "project_spreadsheet_module_view_controller.dart - initialize");
      return false;
    }
 }

 Map<int, String> convertMapToMapIntString(Map initialMap) {
  Map<int, String> map = {};

  List<MapEntry<int, String>> newEntries = [];

  initialMap.forEach((key, value) {newEntries.add(MapEntry(int.tryParse(key) ?? 0, value.toString()));});

  map.addEntries(newEntries);

  return map;
 }

 Map<int, List<int>> convertMapToMapIntListInt(Map initialMap) {
  Map<int, List<int>> map = {};

  List<MapEntry<int, List<int>>> newEntries = [];

  initialMap.forEach((key, value) {newEntries.add(MapEntry(int.tryParse(key) ?? 0, value.runtimeType == List ? _convertListToListInt(value) : []));});

  map.addEntries(newEntries);

  return map;
 }


 List<int> _convertListToListInt(List list) {
  List<int> newList = [];

  for (dynamic element in list) {
    element = num.tryParse(element.toString());
    if (element is num || element is int || element is double) {
      newList.add(element);
    }
  }

  return newList;
 }


  Future<void> updateCustomTableController(Map<String, dynamic>? data) async {
    customTableController.tableTitle = data?['title'] ?? '';
    customTableController.rows = data?['rows'] ?? 1;
    customTableController.columns = data?['columns'] ?? 1;
    customTableController.columnsSelectionsOptions = getColumnSelectionOptionsAsModel(data?['column_selections_options'] ?? {});
    customTableController.cellData = getCellDataAsModel(data?['cell_data'] ?? {});
    customTableController.columnNames = getIntKeyMap<String>(data?['column_names'] ?? {});
    customTableController.columnTypes = getColumnTypesAsModel(data?['column_type'] ?? {});
    customTableController.columnsFunctions = getIntKeyMap<String?>(data?['column_functions'] ?? {});
    customTableController.rowNames = getIntKeyMap<String>(data?['row_names'] ?? {});
  }

  @override
  Future<bool> savingMethod() async {
    try {
      customTableController.saveCells();
      Map<String, dynamic> savedMap = {
        "active_tab": activeTab != null ? activeTab.toString() : tabs.entries.first.key.toString(),
        "tabs": getStringKeyMap(tabs),
        "charts_types": getStringKeyMap(chartsTypes),
        "charts_columns": getChartColumnsAsMap(chartColumns),
        'show_table': showTable,
        'title': customTableController.tableTitle,
        'rows': customTableController.rows,
        'columns': customTableController.columns,
        'column_selections_options': getColumnSelectionOptionsAsMap(customTableController.columnsSelectionsOptions),
        'cell_data': getCellDataAsMap(customTableController.cellData),
        'column_names': getStringKeyMap(customTableController.columnNames),
        'column_type': getColumnTypesAsMap(customTableController.columnTypes),
        'column_functions': getStringKeyMap(customTableController.columnsFunctions),
        'row_names': getStringKeyMap(customTableController.rowNames)
      };

      bool isSaved = await StaticVariables.fileSource.writeJsonFile(
        "$projectPath/${ProjectsModulesTypes.spreadsheet.name}/$id.json",
        savedMap
      );
      return isSaved;
    } catch (e) {
      await AppLogs.writeError(e, "project_spreadsheet_module_view_controller.dart - savingMethod");
      return false;
    } 
  }

  Future<void> rebuild() async {
    await savingMethod();
    notifyListeners();
  }

  Map<String, dynamic> getStringKeyMap<T>(Map<int, T> map) {
    return map.map((key, value) => MapEntry(key.toString(), value));
  }

  Map<String, List<int>> getChartColumnsAsMap(Map<int, List<int>> map) {
    return map.map((key, value) => MapEntry(key.toString(), value));
  }

  Map<int, List<CustomTableSelectionCellOptionModel>?> getColumnSelectionOptionsAsModel(Map map) {
    return map.map((key, value) {
      return MapEntry(int.parse(key), _convertListDynamicToListModels(value));
    });
  }

  List<CustomTableSelectionCellOptionModel> _convertListDynamicToListModels(List list) {
    List<CustomTableSelectionCellOptionModel> newList = [];
    for (Map option in list) {
      newList.add(CustomTableSelectionCellOptionModel(name: option['name'], color: Color.fromARGB(255, option['red'], option['green'], option['blue'])));
    }
    return newList;
  }

  Map<String, List<Map<String, dynamic>>?> getColumnSelectionOptionsAsMap(Map<int, List<CustomTableSelectionCellOptionModel>?> map) {
    return map.map((key, value) {
      return MapEntry(key.toString(), _convertSelectionModelToMap(value));
    });
  }

  List<Map<String, dynamic>> _convertSelectionModelToMap(List<CustomTableSelectionCellOptionModel>? models) {
    if (models == null) {
      return [];
    }
    
    List<Map<String, dynamic>> maps = [];
    for (CustomTableSelectionCellOptionModel model in models) {
      maps.add(
        {
          'name': model.name,
          'red': model.color.red,
          'green': model.color.green,
          'blue': model.color.blue
        }
      );
    }

    return maps;
  }

  Map<String, dynamic> getCellDataAsMap(Map<CustomTableCellPosition, dynamic> cellData) {
    return cellData.map((key, value) {
      return MapEntry('${key.row},${key.column}', value);
    });
  }

  Map<CustomTableCellPosition, dynamic> getCellDataAsModel(Map<String, dynamic> cellData) {
    return cellData.map((key, value) {
      List<String> parts = key.split(',');
      return MapEntry(
        CustomTableCellPosition(row: int.parse(parts[0]), column: int.parse(parts[1])),
        value
      );
    });
  }

  Map<String, int> getColumnTypesAsMap(Map<int, CustomTableType> map) {
    return map.map((key, value) {
      return MapEntry(key.toString(), value.index);
    });
  }

  Map<int, CustomTableType> getColumnTypesAsModel(Map<String, dynamic> map) {
    return map.map((key, value) {
      return MapEntry(int.parse(key), CustomTableType.values[value as int]);
    });
  }

  Map<int, T> getIntKeyMap<T>(Map<String, dynamic> map) {
    return map.map((key, value) => MapEntry(int.parse(key), value as T));
  }

  Map<String, dynamic> defaultDataFormat = {
    "active_tab": '',
    "tabs": {},
    "charts_types": {},
    "charts_columns": {},
    "show_table": true,
    'title': '',
    'rows': 1,
    'columns': 1,
    'cell_data': {},
    'column_names': {},
    'column_selections_options': {},
    'column_type': {},
    'column_functions': {},
    'row_names': {}
  };
}