import 'package:flutter/material.dart';
import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:minddy/system/interface/projects_modules_controller_interface.dart';
import 'package:minddy/system/model/custom_table_cell_position.dart';
import 'package:minddy/system/model/custom_table_type.dart';
import 'package:minddy/system/model/projects_modules.dart';
import 'package:minddy/system/projects/get_module_data.dart';
import 'package:minddy/system/utils/create_unique_id.dart';
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
    initialize().then((value) => notifyListeners());
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

    await savingMethod();
    notifyListeners();
  }

  Future<void> selectTab(tabId) async {
    activeTab = tabId;

    await savingMethod();
    notifyListeners();
  }

  Future<void> newTab() async {
    tabs[createUniqueId()] = '';

    print(tabs);

    await savingMethod();
    notifyListeners();
  }

  Future<void> renameTab(int tabId, String newName) async {
    tabs[tabId] = newName;

    print(tabs);

    await savingMethod();
    notifyListeners();
  }

  Future<void> deleteTab(int tabId) async {
    tabs.remove(tabId);
    chartColumns.remove(tabId);
    chartsTypes.remove(tabId);

    await savingMethod();
    notifyListeners();
  }

  Future<void> selectChartType(int tabId, CustomChartType newType) async {
    chartsTypes[tabId] = newType.name;

    await savingMethod();
    notifyListeners();
  }

  Future<void> setChartColumns(int tabId, List<int> columns) async {
    chartColumns[tabId] = columns;
    notifyListeners();
  }

  Future<bool> initialize() async {
    try {
      Map<String, dynamic>? data = await getModuleData(id, ProjectsModulesTypes.spreadsheet, projectPath);
      if (data == null) {
        await StaticVariables.fileSource.createFile("$projectPath/${ProjectsModulesTypes.spreadsheet.name}/$id.json");
      }
      await updateCustomTableController(data);
      showTable = data?["show_table"] ?? true;
      tabs = convertMapToMapIntString( data?["tabs"] ?? {});
      chartsTypes = convertMapToMapIntString( data?["tabs"] ?? {});
      chartColumns = convertMapToMapIntListInt(data?["charts_columns"] ?? {});
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

  initialMap.forEach((key, value) {newEntries.add(MapEntry(int.tryParse(key) ?? 0, value.runtimeType == List ? value : []));});

  map.addEntries(newEntries);

  return map;
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