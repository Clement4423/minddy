import 'package:flutter/material.dart';
import 'package:minddy/system/interfaces/projects_modules_controller_interface.dart';
import 'package:minddy/system/interfaces/projects_modules_interface.dart';
import 'package:minddy/ui/components/projects/modules/notes/project_notes_module_note_categories_view.dart';
import 'package:minddy/ui/components/projects/modules/notes/projects_modules_note_view_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

class ProjectsNotesModule extends StatefulWidget implements IProjectsModules{
  ProjectsNotesModule({super.key, required this.deleteFunction ,required this.controller, required this.duplicateFunction}) {
    controller.width = width;
    controller.height = height;
    controller.deleteFunction = deleteFunction;
    controller.duplicateFunction = duplicateFunction;
    controller.actualView = ProjectNotesModuleNoteCategoriesView(width: width, height: height, controller: controller, deleteFunction: deleteFunction, duplicateFunction: duplicateFunction);
  }

  @override
  final ProjectsNotesModuleController controller;

  @override
  final double width = 340;

  @override 
  final double height = 420;

  @override
  final Function(int) deleteFunction;

  @override
  final Function(int) duplicateFunction;

  @override
  State<ProjectsNotesModule> createState() => _ProjectsNotesModuleState();
  
  @override
  set height(double newHeight) {
    height = newHeight;
  }
  
  @override
  set width(double newWidth) {
    width = newWidth;
  }

  @override
  set controller(IProjectModuleController newController) {}
  
  @override
  set deleteFunction(Function newDeleteFunction) {}
  
  @override
  set duplicateFunction(Function(int p1) newDuplicateFunction) {}
}

class _ProjectsNotesModuleState extends State<ProjectsNotesModule> {
  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(20)
      ),
      child: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, child) {
          return widget.controller.actualView;
        }
      )
    );
  }
}


