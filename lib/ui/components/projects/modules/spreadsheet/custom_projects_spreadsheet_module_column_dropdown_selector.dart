import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/custom_components/custom_dropdown_button.dart';
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
  });

  final double width;
  final double height;
  final ProjectsSpreadsheetModuleController controller;
  final int columnIndex;
  final String columnName;
  final List<MapEntry<int, String>> availableColumns;

  @override
  State<CustomProjectsSpreadsheetModuleColumnDropdownSelector> createState() =>
      _CustomProjectsSpreadsheetModuleColumnDropdownSelectorState();
}


class _CustomProjectsSpreadsheetModuleColumnDropdownSelectorState
    extends State<CustomProjectsSpreadsheetModuleColumnDropdownSelector> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Stack(
          children: [
            TweenAnimationBuilder(
              duration: const Duration(milliseconds: 100),
              tween: Tween(
                begin: _isHovered ? widget.width * 0.76 : widget.width * 1,
                end: _isHovered ? widget.width * 0.76 : widget.width * 1
              ),
              builder: (context, size, child) {
                return SizedBox(
                  width: size,
                  child: CustomDropdownButton(
                    menuTitle: widget.columnName,
                    backgroundColor: theme.primary,
                    foregroundColor: theme.onPrimary,
                    action: (int colIndex) {
                      widget.controller.updateChartColumn(
                        widget.controller.activeTab ?? 0,
                        widget.columnIndex,
                        colIndex
                      );
                    },
                    items: widget.availableColumns.map((entry) {
                      return DropdownMenuItem(
                        value: entry.key,
                        child: Text(
                          entry.value,
                          style: theme.bodyMedium.copyWith(color: theme.onPrimary),
                        ),
                      );
                    }).toList(),
                    needToRestart: false,
                  ),
                );
              }
            ),
            if (_isHovered)
              Positioned(
                right: 8,
                top: 0,
                bottom: 0,
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.delete_outline_rounded, color: theme.error, size: 20),
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
      ),
    );
  }
}