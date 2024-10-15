import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/interfaces/custom_table_cell_data_interface.dart';
import 'package:minddy/system/model/default_app_color.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_table_controller.dart';
import 'package:minddy/ui/components/menus/custom_tooltip.dart';
import 'package:minddy/ui/components/menus/sub_menus/custom_table_selection_cell_add_options_sub_menu.dart';
import 'package:minddy/ui/components/menus/sub_menus/sub_menus_container.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomTableSelectionCellOptionModel {
  String name;
  Color color;

  CustomTableSelectionCellOptionModel({required this.name, required this.color});
}

// ignore: must_be_immutable
class CustomTableSelectionCell extends StatefulWidget implements ICustomTableCellData {
  CustomTableSelectionCell({super.key, required this.theme, required this.initialValue, required this.cellWidth, required this.cellHeight, required this.columnIndex, required this.controller}) {
    data = initialValue;
  }

  @override
  State<CustomTableSelectionCell> createState() => _CustomTableSelectionCellState();

  final String initialValue;

  final int columnIndex;

  final CustomTableController controller;

  final double cellWidth;
  final double cellHeight;
  
  @override
  var data = 0;

  StylesGetters theme;
}

class _CustomTableSelectionCellState extends State<CustomTableSelectionCell> {

  List<CustomTableSelectionCellOptionModel> defaultOptions = [
    CustomTableSelectionCellOptionModel(
      name: S.current.projects_module_spreadsheet_selection_cell_not_started, 
      color: DefaultAppColors.grey.color
    ),
    CustomTableSelectionCellOptionModel(
      name: S.current.projects_module_spreadsheet_selection_cell_started, 
      color: DefaultAppColors.blue.color
    ),
    CustomTableSelectionCellOptionModel(
      name: S.current.projects_module_spreadsheet_selection_cell_finished, 
      color: DefaultAppColors.mintGreen.color
    )
  ];
  
  List<CustomTableSelectionCellOptionModel> options = [];

  List<CustomTableSelectionCellOptionModel> getOptions() {
    List<CustomTableSelectionCellOptionModel>? options = widget.controller.columnsSelectionsOptions[widget.columnIndex];
    if (options == null || options.isEmpty) {
      options = defaultOptions;
      widget.controller.setColumnSelectionOptions(widget.columnIndex, options);
    }

    return options;
  }

  Color _getOptionColor() {
    return options.map((e) => e.name).toList().contains(widget.data ?? '') 
      ? options.firstWhere((element) => element.name == widget.data).color
      : options.first.color;
  }

  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    options = getOptions();
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isHovering = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHovering = false;
        });
      },
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: widget.cellWidth * 0.8,
            height: widget.cellHeight * 0.7,
            constraints: const BoxConstraints(
              maxWidth: 200,
              maxHeight: 50
            ),
            margin: EdgeInsets.only(
              right: isHovering ? 55 : 0,
              left: (widget.cellWidth * 0.8 > 200 
                ? widget.cellWidth - 200 
                : widget.cellWidth - (widget.cellWidth * 0.8)) / 2, 
              top: (widget.cellHeight * 0.7 > 50 
                ? widget.cellHeight - 50 
                : widget.cellHeight - (widget.cellHeight * 0.7)) / 2, 
              bottom: (widget.cellHeight * 0.7 > 50 
                ? widget.cellHeight - 50 
                : widget.cellHeight - (widget.cellHeight * 0.7)) / 2
                // All of this serves as centering the menu. 
                // Using a center widget caused problems of alignement, so i came up with this.
            ),
            decoration: BoxDecoration(
              border: Border.all(color: _getOptionColor(), width: 2),
              borderRadius: BorderRadius.circular((widget.cellHeight * 0.7) / 2)
            ),
            child: CustomTooltip(
              message: widget.data != null
                ? widget.data as String == '' 
                  ? options.first.name
                  : widget.data
                : options.first.name,
              lengthTreshold: 5,
              child: Material(
                type: MaterialType.transparency,
                child: CustomSelectionMenu(
                  theme: widget.theme, 
                  menuMaxHeight: 250,
                  enableSearch: true,
                  buttonStyle: const ButtonStyle(
                    padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 10))
                  ),
                  items: options.map((option) {
                    return CustomSelectionMenuItem(
                      label: option.name, 
                      labelStyle: widget.theme.bodyMedium.copyWith(
                        color: option.color
                      ),
                      icon: null, 
                      onTap: () {
                        setState(() {
                          widget.data = option.name;
                        });
                      }
                    );
                  }).toList(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          options.map((e) => e.name).toList().contains(widget.data ?? '') 
                            ? widget.data 
                            : options.first.name,
                          style: widget.theme.bodyMedium.copyWith(
                            color: options.map((e) => e.name).toList().contains(widget.data ?? '') 
                              ? options.firstWhere((o) => o.name == widget.data).color 
                              : options.first.color,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down_rounded,
                        color: options.map((e) => e.name).toList().contains(widget.data ?? '') 
                          ? options.firstWhere((o) => o.name == widget.data).color 
                          : options.first.color,
                      )
                    ],
                  )
                )
              ),
            ),
          ),
          if (isHovering)
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: TweenAnimationBuilder(
                tween: Tween<double>(
                  begin: isHovering ? 0.8 : 0.9,
                  end: isHovering ? 0.9 : 0.8,
                ),
                duration: const Duration(milliseconds: 100),
                builder: (context, size, child) {
                  return Transform.scale(
                    scale: size,
                    child: IconButton(
                      onPressed: () {
                        showSubMenu(
                          context, 
                          CustomTableSelectionCellAddOptionsSubMenu(
                            options: options, 
                            onCompleted: (newOptions) {
                              widget.controller.setColumnSelectionOptions(widget.columnIndex, newOptions);
                              widget.controller.rebuildWholeTable();
                            }
                          )
                        );
                      },
                      tooltip: S.of(context).projects_module_spreadsheet_selection_cell_modify_options,
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(widget.theme.primary),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(13))),
                        elevation: const WidgetStatePropertyAll(8)
                      ),
                      icon: Icon(Icons.brush_rounded, color: widget.theme.onPrimary)
                    ),
                  );
                }
              ),
            ),
          )
        ],
      ),
    );
  }
}

// DropdownButton<String>(
//   value: options.map((e) => e.name).toList().contains(widget.data ?? '') 
//     ? widget.data 
//     : options.first.name,
//   padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
//   focusColor: Colors.transparent,
//   dropdownColor: widget.theme.primary,
//   items: options.map((option) {
//     return DropdownMenuItem(
//       value: option.name,
//       child: CustomTooltip(
//         message: option.name,
//         lengthTreshold: 10,
//         waitDuration: const Duration(milliseconds: 500),
//         child: Text(
//           option.name,
//           overflow: TextOverflow.ellipsis,
//           style: widget.theme.bodyMedium
//           .copyWith(color: option.color), maxLines: 1
//         )
//       ),
//     );
//   }).toList(),
//   icon: Icon(
//     Icons.arrow_drop_down_rounded,
//       color: _getOptionColor()
//     ),
//   borderRadius: BorderRadius.circular((widget.cellHeight * 0.7) / 2),
//   style: widget.theme.bodyMedium.copyWith(color: widget.theme.onSurface),
//   isExpanded: true,
//   underline: const SizedBox(),
//   onChanged: (value) {
//     setState(() {
//       widget.data = value;
//     });
//   },
//   ),