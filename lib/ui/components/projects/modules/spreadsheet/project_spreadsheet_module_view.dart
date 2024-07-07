import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/interface/projects_modules_controller_interface.dart';
import 'package:minddy/system/interface/projects_modules_interface.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_table_view.dart';
import 'package:minddy/ui/components/menus/popup_menu/popup_menu_button.dart';
import 'package:minddy/ui/components/menus/popup_menu/popup_menu_item_model.dart';
import 'package:minddy/ui/components/projects/modules/spreadsheet/project_spreadsheet_module_view_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

class ProjectsSpreadsheetModule extends StatefulWidget implements IProjectsModules {
  const ProjectsSpreadsheetModule({super.key, required this.controller, required this.deleteFunction, required this.duplicateFunction});

  @override
  State<ProjectsSpreadsheetModule> createState() => _ProjectsSpreadsheetModuleState();

  @override
  final ProjectsSpreadsheetModuleController controller;

  @override
  final Function(int p1) deleteFunction;

  @override
  final Function(int p1) duplicateFunction;

  @override
  final double height = 420;

  @override
  final double width = 700;
  
  @override
  set controller(IProjectModuleController newController) {
  }
  
  @override
  set deleteFunction(Function(int p1) newDeleteFunction) {}
  
  @override
  set duplicateFunction(Function(int p1) newDuplicateFunction) {}
  
  @override
  set height(double newHeight) {}
  
  @override
  set width(double newWidth) {}
}

class _ProjectsSpreadsheetModuleState extends State<ProjectsSpreadsheetModule> {
  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Container(
      width: widget.width,
      height: widget.height,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        children: [
          Container(
            width: 690,
            height: 50,
            decoration: BoxDecoration(
              color: theme.surface,
              borderRadius: BorderRadius.circular(15)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Icon(Icons.view_column_rounded, color: theme.onSurface, size: 28),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(S.of(context).projects_module_spreadsheet_title, style: theme.titleLarge.copyWith(fontSize: 20)),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: CustomPopupMenuButton(items: [
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
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: FutureBuilder(
                future: widget.controller.initialize(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasData && snapshot.data == true) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CustomTable(
                        cellHeight: 50, 
                        cellWidth: 200, 
                        controller: widget.controller.customTableController,
                      ),
                    );
                  }
                  return const SizedBox();
                }
              ),
            ),
          ),
        ],
      )
    );
  }
}