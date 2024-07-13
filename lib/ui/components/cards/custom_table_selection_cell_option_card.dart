import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/default_app_color.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_cells/custom_table_selection_cell.dart';
import 'package:minddy/ui/components/menus/sub_menus_controllers/custom_table_selection_cell_add_options_sub_menu_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomTableSelectionCellOptionCard extends StatefulWidget {
  const CustomTableSelectionCellOptionCard({
    super.key,
    required this.option,
    required this.theme,
    required this.controller
  });

  final CustomTableSelectionCellOptionModel option;
  final CustomTableSelectionCellAddOptionsSubMenuController controller;
  final StylesGetters theme;

  @override
  State<CustomTableSelectionCellOptionCard> createState() => _CustomTableSelectionCellOptionCardState();
}

class _CustomTableSelectionCellOptionCardState extends State<CustomTableSelectionCellOptionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: widget.theme.surface,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: PopupMenuButton<Color>(
                initialValue: widget.option.color,
                color: widget.theme.primary,
                tooltip: S.of(context).default_app_colors_change_color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13)
                ),
                itemBuilder: (context) {
                  return [
                    ...DefaultAppColors.asList.map((color) {
                      return PopupMenuItem<Color>(
                        value: color.color,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                             color.colorName,
                             style: widget.theme.bodyMedium.
                             copyWith(color: color.color),
                            ),
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: color.color,
                                borderRadius: BorderRadius.circular(5)
                              ),
                            )
                          ],
                        )
                      );
                    })
                  ];
                },
                onSelected: (value) {
                  setState(() {
                    widget.option.color = value;
                  });
                },
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: widget.option.color,
                    borderRadius: BorderRadius.circular(5)
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextField(
                onChanged: (value) {
                  widget.option.name = value;
                },
                controller: TextEditingController(text: widget.option.name),
                style: widget.theme.bodyMedium,
                cursorColor: widget.theme.onSurface,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: S.of(context).projects_module_spreadsheet_selection_cell_name_option_hint
                ),
              ),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  widget.controller.deleteOption(widget.option);
                },
                child: Tooltip(
                  message: S.of(context).snackbar_delete_button,
                  child: Icon(
                    Icons.delete_outline_rounded,
                    color: widget.theme.error
                  ),
                )
              )
            )
          ],
        ),
      ),
    );
  }
}