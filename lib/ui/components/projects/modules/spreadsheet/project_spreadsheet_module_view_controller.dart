import 'package:flutter/material.dart';
import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:minddy/system/interface/projects_modules_controller_interface.dart';
import 'package:minddy/system/model/custom_table_cell_position.dart';
import 'package:minddy/system/model/custom_table_type.dart';
import 'package:minddy/system/model/projects_modules.dart';
import 'package:minddy/system/projects/get_module_data.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_cells/custom_table_selection_cell.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_table_controller.dart';

class ProjectsSpreadsheetModuleController extends ChangeNotifier implements IProjectModuleController {
  @override
  int id;

  @override
  String projectPath;

  CustomTableController customTableController;

  ProjectsSpreadsheetModuleController({required this.id, required this.projectPath})
      : customTableController = CustomTableController(1, 1);

  Future<bool> initialize() async {
    try {
      Map<String, dynamic>? data = await getModuleData(id, ProjectsModules.spreadsheet, projectPath);
      if (data == null) {
        await StaticVariables.fileSource.createFile("$projectPath/${ProjectsModules.spreadsheet.name}/$id.json");
      } else {
        customTableController.tableTitle = data['title'] ?? '';
        customTableController.rows = data['rows'] ?? 1;
        customTableController.columns = data['columns'] ?? 1;
        customTableController.columnsSelectionsOptions = getColumnSelectionOptionsAsModel(data['column_selections_options'] ?? {});
        customTableController.cellData = getCellDataAsModel(data['cell_data'] ?? {});
        customTableController.columnNames = getIntKeyMap<String>(data['column_names'] ?? {});
        customTableController.columnTypes = getColumnTypesAsModel(data['column_type'] ?? {});
        customTableController.columnsFunctions = getIntKeyMap<String?>(data['column_functions'] ?? {});
        customTableController.rowNames = getIntKeyMap<String>(data['row_names'] ?? {});
      }
      return true;
    } catch (e) {
      await AppLogs.writeError(e, "project_spreadsheet_module_view_controller.dart - initialize");
      return false;
    }
  }

  @override
  Future<bool> savingMethod() async {
    try {
      customTableController.saveCells();
      Map<String, dynamic> savedMap = {
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
        "$projectPath/${ProjectsModules.spreadsheet.name}/$id.json",
        savedMap
      );
      return isSaved;
    } catch (e) {
      await AppLogs.writeError(e, "project_spreadsheet_module_view_controller.dart - savingMethod");
      return false;
    } 
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
      return MapEntry(key.toString(), _convertModelToMap(value));
    });
  }

  List<Map<String, dynamic>> _convertModelToMap(List<CustomTableSelectionCellOptionModel>? models) {
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

  Map<String, dynamic> getStringKeyMap<T>(Map<int, T> map) {
    return map.map((key, value) => MapEntry(key.toString(), value));
  }

  Map<int, T> getIntKeyMap<T>(Map<String, dynamic> map) {
    return map.map((key, value) => MapEntry(int.parse(key), value as T));
  }

  Map<String, dynamic> defaultDataFormat = {
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