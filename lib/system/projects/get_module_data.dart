import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:minddy/system/model/projects_modules.dart';

Future<Map<String, dynamic>?> getModuleData(int moduleId, ProjectsModulesTypes moduleType, String projectPath) async {
  Map<String, dynamic>? moduleData = await StaticVariables.fileSource.readJsonFile("$projectPath/${moduleType.name}/$moduleId.json");
  if (moduleData != null) {
    return moduleData;
  } else {
    String errorMessage = "Impossible to read the module data, path was $projectPath/${moduleType.name}/$moduleId.json";
    await AppLogs.writeError(errorMessage, "get_module_data.dart - getModuleData");
    return null;
  }
}
