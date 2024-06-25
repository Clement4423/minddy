import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/projects_tasks_module_task_model.dart';
import 'package:minddy/ui/components/menus/custom_tooltip.dart';
import 'package:minddy/ui/components/projects/modules/tasks/projects_modules_tasks_view_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

// ignore: must_be_immutable
class ProjectSubTaskElement extends StatefulWidget {
  ProjectSubTaskElement({super.key, required this.data, required this.controller, required this.parentTaskKey});

  ProjectsTasksModuleSubTaskModel data;
  Key parentTaskKey;
  ProjectsTasksModuleController controller;

  @override
  State<ProjectSubTaskElement> createState() => _ProjectSubTaskElementState();
}

class _ProjectSubTaskElementState extends State<ProjectSubTaskElement> {


  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                if (direction == DismissDirection.startToEnd) {
                  widget.controller.deleteSubtask(widget.parentTaskKey, widget.key ?? UniqueKey());
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
                width: 250,
                decoration: BoxDecoration(
                  color: theme.surface,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Transform.scale(
                        scale: 1.3,
                        child: Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                          ),
                          checkColor: theme.onSecondary,
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                          side: BorderSide.none,
                          fillColor: widget.data.isChecked ? MaterialStatePropertyAll(theme.secondary) : MaterialStatePropertyAll(theme.onSecondary),
                          value: widget.data.isChecked,
                          onChanged: (value) {
                            setState(() {
                              widget.data.isChecked = value ?? false;
                            });
                            widget.controller.completedOneTask();
                          }
                        ),
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
