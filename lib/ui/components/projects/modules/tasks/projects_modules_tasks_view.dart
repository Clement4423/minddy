import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/interface/projects_modules_interface.dart';
import 'package:minddy/ui/components/menus/popup_menu/popup_menu_button.dart';
import 'package:minddy/ui/components/menus/popup_menu/popup_menu_item_model.dart';
import 'package:minddy/ui/theme/theme.dart';

// TODO : Traduire le module


class ProjectsTasksModule extends StatefulWidget implements IProjectsModules {
  const ProjectsTasksModule({super.key});

  @override
  final double width = 340;

  @override 
  final double height = 420;

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
            height: 130,
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
                      "Tasks",
                      style: theme.titleMedium.copyWith(color: theme.onSurface),
                    ),
                    // Module options
                    CustomPopupMenuButton(items: [
                      CustomPopupItemModel(
                        text: Text("Help", style: theme.bodyMedium.copyWith(color: theme.onPrimary),), 
                        icon: Icon(Icons.help_outline_rounded, color: theme.onPrimary), 
                        action: () {
                          
                        }
                      ),
                      CustomPopupItemModel(
                        text: Text(S.of(context).project_card_duplicate, style: theme.bodyMedium.copyWith(color: theme.onPrimary),), 
                        icon: Icon(Icons.copy_rounded, color: theme.onPrimary), 
                        action: () {
                          
                        }
                      ),
                      CustomPopupItemModel(
                        text: Text(S.of(context).snackbar_delete_button, style: theme.bodyMedium.copyWith(color: theme.error),), 
                        icon: Icon(Icons.delete_outline_rounded, color: theme.error), 
                        action: () {
                          
                        }
                      ) 
                    ])
                  ],
                ),
                // Completed tasks
                Text(
                  "Completed 1/2",
                  style: theme.bodyMedium.copyWith(color: theme.onSurface),
                ),
                // New task button
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 35,
                    width: widget.width,
                    child: IconButton(
                      onPressed: () {
                        
                      },
                      style: ButtonThemes.primaryButtonStyle(context),
                      icon: Center(child: Icon(Icons.add_rounded, color: theme.onSecondary))
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
                child: ListView(
                  children: [
                    ProjectTaskElement(title: "Title", value: false, isImportant: true, subtasks: [],)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProjectTaskElement extends StatefulWidget {
  const ProjectTaskElement({super.key, required this.title, required this.value, required this.isImportant, required this.subtasks});

  final String title;
  final bool value;
  final bool isImportant;
  final List subtasks;

  @override
  State<ProjectTaskElement> createState() => _ProjectTaskElementState();
}

class _ProjectTaskElementState extends State<ProjectTaskElement> {
  bool _isChecked = false;
  bool _isImportant = false;

  @override
  void initState() {
    _isChecked = widget.value;
    _isImportant = widget.isImportant;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Container(
      height: 70,
      width: 330,
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(15)
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
                fillColor: _isChecked ? MaterialStatePropertyAll(theme.secondary) : MaterialStatePropertyAll(theme.onSecondary),
                value: _isChecked,
                onChanged: (value) {
                  setState(() {
                    _isChecked = value ?? false;
                  });
                }
              ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: TextEditingController(text: widget.title),
              textAlign: TextAlign.left,
              cursorColor: theme.onSurface,
              style: theme.titleMedium.copyWith(fontWeight: FontWeight.w600, color: theme.onSurface),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Title"
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
            
                },
                child: Tooltip(
                  message: "Add a subtask",
                  waitDuration: Duration(milliseconds: 300),
                  child: Container(
                    margin: EdgeInsets.only(right: 5),
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: theme.onSurface,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Icon(Icons.add_rounded, color: theme.surface, size: 14,),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}