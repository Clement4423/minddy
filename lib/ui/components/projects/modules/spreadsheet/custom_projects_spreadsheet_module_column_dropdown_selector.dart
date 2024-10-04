import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/custom_components/custom_dropdown_button.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/components/projects/modules/spreadsheet/project_spreadsheet_module_view_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomProjectsSpreadsheetModuleColumnDropdownSelector extends StatefulWidget {
  const CustomProjectsSpreadsheetModuleColumnDropdownSelector({
    super.key,
    required this.width,
    required this.height,
    required this.controller,
    required this.columnIndex,
    required this.columnName,
    required this.availableColumns,
    required this.theme
  });

  final double width;
  final double height;
  final ProjectsSpreadsheetModuleController controller;
  final int columnIndex;
  final String columnName;
  final List<MapEntry<int, String>> availableColumns;
  final StylesGetters theme;

  @override
  State<CustomProjectsSpreadsheetModuleColumnDropdownSelector> createState() =>
      _CustomProjectsSpreadsheetModuleColumnDropdownSelectorState();
}


class _CustomProjectsSpreadsheetModuleColumnDropdownSelectorState
    extends State<CustomProjectsSpreadsheetModuleColumnDropdownSelector> {

  @override
  Widget build(BuildContext context) {
    bool enabled = widget.availableColumns.isNotEmpty;
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          CustomDropdownButton(
            enabled: enabled,
            width: widget.width * 0.76,
            menuTitle: null,
            selectedOptionTitle: widget.columnName.isEmpty 
              ? S.of(context).projects_module_spreadsheet_value_unnamed 
              : widget.columnName, 
            backgroundColor: widget.theme.primary,
            foregroundColor: widget.theme.onPrimary,
            theme: widget.theme,
            items: widget.availableColumns.map((entry) {
              return CustomSelectionMenuItem(
                label: entry.value.isEmpty 
                  ? S.of(context).projects_module_spreadsheet_value_unnamed 
                  : entry.value, 
                labelStyle: widget.theme.bodyMedium.copyWith(color: widget.theme.onPrimary),
                icon: null, 
                onTap: () {
                  widget.controller.updateChartColumn(
                    widget.controller.activeTab ?? 0,
                    widget.columnIndex,
                    entry.key
                  );
                }
              );
            }).toList(),
          ),
          Positioned(
            right: 8,
            top: 0,
            bottom: 0,
            child: Center(
              child: IconButton(
                icon: Icon(Icons.delete_outline_rounded, color: widget.theme.error, size: 20),
                onPressed: () async {
                  await widget.controller.deleteChartColumn(
                    widget.controller.activeTab ?? 0,
                    widget.columnIndex
                  );
                },
                tooltip: S.of(context).snackbar_delete_button,
                style: ButtonThemes.secondaryButtonStyle(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

