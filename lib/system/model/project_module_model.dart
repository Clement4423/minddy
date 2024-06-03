import 'package:minddy/system/model/projects_modules.dart';

class ProjectModuleModel {
  ProjectsModules type;
  int id;


  ProjectModuleModel({required this.type, required this.id});

  // Chaque module à un type et un ID unique, pour récupérer les données d'un module il faut 
  // récupérer son ID et aller chercher le fichier associé avec le même ID
  // 
  // Chaque model stocké dans les infos d'un projet doit être sous la forme d'un int représentant 
  // la position dans la liste du module.
}