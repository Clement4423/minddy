import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/projects_tasks_module_task_model.dart';
import 'package:minddy/ui/components/custom_components/custom_checkbox.dart';
import 'package:minddy/ui/components/menus/custom_tooltip.dart';
import 'package:minddy/ui/components/projects/modules/tasks/projects_modules_tasks_view_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

// ignore: must_be_immutable
class ProjectTaskElement extends StatefulWidget {
  ProjectTaskElement({super.key, required this.data, required this.controller});

  ProjectsTasksModuleTaskModel data;
  ProjectsTasksModuleController controller;

  @override
  State<ProjectTaskElement> createState() => _ProjectTaskElementState();
}

class _ProjectTaskElementState extends State<ProjectTaskElement> {

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                if (direction == DismissDirection.startToEnd) {
                  widget.controller.deleteTask(widget.key ?? UniqueKey());
                }
              },
              direction: DismissDirection.startToEnd,
              dismissThresholds: const {
                DismissDirection.startToEnd: 0.8
              },
              background: Container(
                color: theme.error,
                child: Center(
                  child: Icon(Icons.delete_outline_rounded, color: theme.onError)
                )
              ),
              child: Container(
                height: 70,
                width: 330,
                decoration: BoxDecoration(
                  color: theme.surface,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: CustomCheckbox(
                        value: widget.data.isChecked,
                        onChanged: (value) async {
                          setState(() {
                            widget.data.isChecked = !widget.data.isChecked;
                          });                        
                          await widget.controller.completedOneTask();
                        },
                        theme: theme,
                      ),
                    ),
                    Expanded(
                      child: CustomTooltip(
                        message: widget.data.title,
                        lengthTreshold: 24,
                        child: TextField(
                          onChanged: (value) {
                            widget.data.title = value;
                          },
                          onEditingComplete: () {
                            setState(() {});
                          },
                          controller: TextEditingController(text: widget.data.title),
                          textAlign: TextAlign.left,
                          cursorColor: theme.onSurface,
                          style: theme.titleMedium.copyWith(fontWeight: FontWeight.w600, color: theme.onSurface),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: S.of(context).projects_module_tasks_task_title_hint
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 13),
                      child: IconButton(
                        tooltip: S.of(context).projects_module_tasks_task_add_subtask_tooltip,
                        onPressed: () async {
                          widget.controller.newSubtask(widget.key ?? UniqueKey());
                          setState(() {});
                        }, 
                        style: ButtonThemes.secondaryButtonStyle(context),
                        icon: Icon(Icons.add_rounded, color: theme.onPrimary)
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          ...widget.controller.buildSubtasks(widget.key ?? UniqueKey())
        ],
      ),
    );
  }
}

