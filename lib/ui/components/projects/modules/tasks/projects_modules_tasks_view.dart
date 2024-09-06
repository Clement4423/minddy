import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/interface/projects_modules_controller_interface.dart';
import 'package:minddy/system/interface/projects_modules_interface.dart';
import 'package:minddy/ui/components/menus/popup_menu/custom_popup_menu_button.dart';
import 'package:minddy/ui/components/menus/popup_menu/custom_popup_menu_item_model.dart';
import 'package:minddy/ui/components/projects/modules/tasks/projects_modules_tasks_view_controller.dart';
import 'package:minddy/ui/theme/theme.dart';


class ProjectsTasksModule extends StatefulWidget implements IProjectsModules {
  const ProjectsTasksModule({super.key, required this.deleteFunction ,required this.controller, required this.duplicateFunction});

  @override
  final ProjectsTasksModuleController controller;

  @override
  final double width = 340;

  @override 
  final double height = 420;

  @override
  final Function(int) deleteFunction;

  @override
  final Function(int) duplicateFunction;

  @override
  State<ProjectsTasksModule> createState() => _ProjectsTasksModuleState();
  
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

class _ProjectsTasksModuleState extends State<ProjectsTasksModule> {
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
      child: Column(
        children: [
          // Header
          Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            height: 135,
            decoration: BoxDecoration(
              color: theme.surface,
              borderRadius: BorderRadius.circular(15)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Icon and title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Icon(Icons.check_rounded, color: theme.onSurface),
                    ),
                    Text(
                      S.of(context).projects_module_tasks_title,
                      style: theme.titleMedium.copyWith(color: theme.onSurface),
                    ),
                    // Module options
                    CustomPopupMenuButton(items: [
                      CustomPopupItemModel(
                        text: Text(S.of(context).projects_module_help_text, style: theme.bodyMedium.copyWith(color: theme.onPrimary),), 
                        icon: Icon(Icons.help_outline_rounded, color: theme.onPrimary), 
                        action: () {
                          
                        }
                      ),
                      CustomPopupItemModel(
                        text: Text(S.of(context).project_card_duplicate, style: theme.bodyMedium.copyWith(color: theme.onPrimary),), 
                        icon: Icon(Icons.copy_rounded, color: theme.onPrimary), 
                        action: () {
                          widget.duplicateFunction(widget.controller.id);
                        }
                      ),
                      CustomPopupItemModel(
                        text: Text(S.of(context).snackbar_delete_button, style: theme.bodyMedium.copyWith(color: theme.error),), 
                        icon: Icon(Icons.delete_outline_rounded, color: theme.error), 
                        action: () {
                          widget.deleteFunction(widget.controller.id);
                        }
                      ) 
                    ])
                  ],
                ),
                // Completed tasks
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: AnimatedBuilder(
                    animation: widget.controller,
                    builder: (context, animation) {
                      return Text(
                        S.of(context).projects_module_tasks_completed(
                          widget.controller.tasksWidgets.length, 
                          widget.controller.tasksWidgets.where((element) => element.data.isChecked).length),
                        style: theme.bodyMedium.copyWith(color: theme.onSurface),
                      );
                    }
                  ),
                ),
                // New task button
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 38,
                    width: widget.width,
                    child: IconButton(
                      tooltip: S.of(context).projects_module_tasks_add_task_tooltip,
                      onPressed: () async {
                        await widget.controller.newTask();
                      },
                      style: ButtonThemes.primaryButtonStyle(context),
                      icon: Icon(Icons.add_rounded, color: theme.onSecondary)
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: AnimatedBuilder(
                  animation: widget.controller,
                  builder: (context, animation) {
                    return ListView(
                      children: [
                        SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(right: widget.controller.tasksWidgets.length >= 4 ? 12 : 0),
                            child: Column(
                              children: [
                                ...widget.controller.tasksWidgets
                              ],
                            ),
                          ),
                        )
                        
                      ]
                    );
                  }
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}