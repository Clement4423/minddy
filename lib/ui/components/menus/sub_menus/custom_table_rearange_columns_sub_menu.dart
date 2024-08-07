import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/custom_table_type.dart';
import 'package:minddy/ui/components/custom_components/custom_text_button.dart';
import 'package:minddy/ui/components/menus/sub_menus_controllers/custom_table_rearange_columns_sub_menu_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomTableRearangeColumnsSubMenu extends StatefulWidget {
  const CustomTableRearangeColumnsSubMenu({super.key, required this.controller});

  final CustomTableRearangeColumnsSubMenuController controller;

  @override
  State<CustomTableRearangeColumnsSubMenu> createState() => _CustomTableRearangeColumnsSubMenuState();
}

class _CustomTableRearangeColumnsSubMenuState extends State<CustomTableRearangeColumnsSubMenu> {
  @override
  Widget build(BuildContext context) {
    final StylesGetters theme = StylesGetters(context);
    return Container(
      width: 350,
      height: 450,
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(25),
      ),
      child: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 25),
                child: Text(
                  S.of(context).projects_module_spreadsheet_manage_columns_sub_menu_title, 
                  style: theme.titleLarge
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            S.of(context).projects_module_spreadsheet_manage_columns_sub_menu_subtitle,
                            style: theme.bodySmall.
                            copyWith(color: theme.onPrimary),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: ReorderableListView(
                            onReorder: (int oldIndex, int newIndex) {
                              if (newIndex > oldIndex) {
                                newIndex -= 1;
                              }
                              if (newIndex >= 0 && newIndex < widget.controller.tableController.columnNames.length) {
                                setState(() {
                                  widget.controller.tableController.rearrangeColumn(oldIndex + 1, newIndex + 1);
                                });
                              }
                            },
                            proxyDecorator: (child, index, animation) {
                              return Opacity(
                                opacity: 0.4,
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: child,
                                ),
                              );
                            },
                            buildDefaultDragHandles: false,
                            children: widget.controller.tableController.columnTypes.entries.map((entry) {
                              final int columnIndex = entry.key;
                              String columnName = widget.controller.tableController.getColumnName(columnIndex) ?? '';
                              if (columnName.isEmpty) {
                                columnName = S.of(context).projects_module_spreadsheet_value_unnamed;
                              }

                              return ReorderableDragStartListener(
                                key: UniqueKey(),
                                index: columnIndex - 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Container(
                                    height: 40,
                                    margin: widget.controller.tableController.columnNames.length > 5 ? const EdgeInsets.only(right: 12) : const EdgeInsets.all(0),
                                    decoration: BoxDecoration(
                                      color: theme.surface,
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        key: UniqueKey(),
                                        children: [
                                          Row(
                                            children: [
                                              Icon(_whatIconToUse(widget.controller.tableController.getColumnType(columnIndex) ?? CustomTableType.text), color: theme.onPrimary),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10),
                                                child: Text(columnName, style: theme.bodyMedium.copyWith(color: theme.onPrimary)),
                                              )
                                            ],
                                          ),
                                          MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: Icon(Icons.drag_handle_rounded, color: theme.onSurface, size: 22)
                                          )
                                        ] 
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList()
                          )
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: SizedBox(
                  width: 350,
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomTextButton(
                      S.of(context).snacbar_close_button, 
                      () {
                        Navigator.pop(context);
                      }, 
                      false, 
                      false
                    ),
                  ),
                ),
              )
            ],
          );
        }
      ),
    );
  }
}

IconData _whatIconToUse(CustomTableType columnType) {
  return customTableIcons[columnType]!.icon ?? Icons.error_rounded;
}