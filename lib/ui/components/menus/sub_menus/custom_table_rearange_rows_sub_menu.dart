import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/custom_components/custom_text_button.dart';
import 'package:minddy/ui/components/menus/sub_menus_controllers/custom_table_rearange_columns_sub_menu_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomTableRearangeRowsSubMenu extends StatefulWidget {
  const CustomTableRearangeRowsSubMenu({super.key, required this.controller});

  final CustomTableRearangeColumnsSubMenuController controller;

  @override
  State<CustomTableRearangeRowsSubMenu> createState() => _CustomTableRearangeRowsSubMenuState();
}

class _CustomTableRearangeRowsSubMenuState extends State<CustomTableRearangeRowsSubMenu> {

  Map<int, String> sortRows(Map<int, String> map) {
    var sortedEntries = map.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    Map<int, String> sortedMap = {
      for (var entry in sortedEntries) entry.key: entry.value
    };

    return sortedMap;
  }

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
                  S.of(context).projects_module_spreadsheet_manage_rows_sub_menu_title, 
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
                            S.of(context).projects_module_spreadsheet_manage_rows_sub_menu_subtitle,
                            style: theme.bodySmall.
                            copyWith(color: theme.onBackground),
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
                                  widget.controller.tableController.rearrangeRow(oldIndex + 1, newIndex + 1);
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
                            children: sortRows(widget.controller.tableController.rowNames).entries.map((entry) {
                              final int rowIndex = entry.key;
                              String rowName = widget.controller.tableController.getRowName(rowIndex) ?? '';
                              if (rowName.isEmpty) {
                                rowName = S.of(context).projects_module_spreadsheet_value_unnamed;
                              }

                              return ReorderableDragStartListener(
                                key: UniqueKey(),
                                index: rowIndex - 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Container(
                                    height: 40,
                                    margin: widget.controller.tableController.rowNames.length > 5 ? const EdgeInsets.only(right: 12) : const EdgeInsets.all(0),
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
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10),
                                                child: Text(rowName, style: theme.bodyMedium.copyWith(color: theme.onPrimary)),
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