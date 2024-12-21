import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/interfaces/projects_modules_controller_interface.dart';
import 'package:minddy/system/interfaces/projects_modules_interface.dart';
import 'package:minddy/system/model/custom_table_type.dart';
import 'package:minddy/system/model/default_app_color.dart';
import 'package:minddy/ui/components/custom_components/custom_chart/custom_chart_element.dart';
import 'package:minddy/ui/components/custom_components/custom_chart/custom_chart_element_controller.dart';
import 'package:minddy/ui/components/custom_components/custom_chart/custom_chart_types.dart';
import 'package:minddy/ui/components/custom_components/custom_dropdown_button.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_table_view.dart';
import 'package:minddy/ui/components/projects/modules/spreadsheet/chart_tab_widget.dart';
import 'package:minddy/ui/components/projects/modules/spreadsheet/custom_projects_spreadsheet_module_column_dropdown_selector.dart';
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
      child: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, child) {
          return Column(
            key: UniqueKey(),
            children: [
              // Header
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
                    // Icon and title
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Icon(CupertinoIcons.table, color: theme.onSurface)
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(S.of(context).projects_module_spreadsheet_title, style: theme.titleLarge.copyWith(fontSize: 20)),
                        )
                      ],
                    ),
                    // Convert to chart and module options
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            await widget.controller.changeView();
                          }, 
                          tooltip: widget.controller.showTable ? S.current.projects_module_spreadsheet_chart_show_chart : S.current.projects_module_spreadsheet_chart_show_table,
                          style: ButtonThemes.secondaryButtonStyle(context),
                          icon: Icon(widget.controller.showTable ? CupertinoIcons.chart_pie : CupertinoIcons.table, color: theme.onPrimary)
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5, left: 5),
                          child: CustomSelectionMenu(
                            theme: theme, 
                            items: [
                              CustomSelectionMenuItem(
                                label: S.of(context).projects_module_help_text, 
                                icon: Icons.help_outline_rounded, 
                                onTap: () {

                                }
                              ),
                              CustomSelectionMenuItem(
                                label: S.of(context).project_card_duplicate, 
                                icon: Icons.copy_rounded, 
                                onTap: () {
                                  widget.duplicateFunction(widget.controller.id);
                                }
                              ),
                              CustomSelectionMenuItem(
                                label: S.of(context).snackbar_delete_button, 
                                icon: Icons.delete_outline_rounded, 
                                foregroundColor: theme.error,
                                onTap: () {
                                  widget.deleteFunction(widget.controller.id);
                                }
                              )
                            ], 
                            type: CustomSelectionMenuButttonType.icon,
                            child: Icon(Icons.more_horiz_rounded, color: theme.secondary)
                          )
                        ),
                      ],
                    )
                  ],
                ),
              ),
              if (widget.controller.showTable)
              // Table
                Expanded(
                  child: FutureBuilder(
                    key: UniqueKey(),
                    future: widget.controller.initialize(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.hasData && snapshot.data == true) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                            child: CustomTable(
                              key: UniqueKey(),
                              cellHeight: 50,
                              cellWidth: 200,
                              controller: widget.controller.customTableController,
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    }
                  ),
                )
              else 
              // Chart
                Container(
                  key: UniqueKey(),
                  width: widget.width - 10,
                  height: widget.height - 10 - 10 - 50,
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: theme.surface
                  ),
                  // Main column
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),                        
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          // Top row with tabs
                          child: Row(
                            children: [
                              ...List.generate(widget.controller.tabs.keys.length, (index) {
                                int tabId = widget.controller.tabs.keys.elementAt(index);
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: ChartTabWidget(
                                    key: UniqueKey(),
                                    tabId: tabId, 
                                    isSelected: tabId == widget.controller.activeTab ? true : false,
                                    chartType: _getChartType(widget.controller.chartsTypes[tabId] ?? ''), 
                                    canBeDeleted: widget.controller.tabs.keys.length > 1,
                                    tabTitle: widget.controller.tabs[tabId] ?? '',
                                    renameTab: widget.controller.renameTab,
                                    navigateToTab: widget.controller.selectTab, 
                                    deleteTab: widget.controller.deleteTab,
                                    theme: theme
                                  ),
                                );
                              }),
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: IconButton(
                                  onPressed: () async {
                                    await widget.controller.newTab();
                                  },
                                  tooltip: S.current.projects_module_spreadsheet_chart_new_tab,
                                  style: ButtonStyle(
                                    shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)
                                      )
                                    ),
                                    backgroundColor: WidgetStatePropertyAll(theme.primary)
                                  ),
                                  icon: Center(
                                    child: Icon(
                                      Icons.add_rounded, 
                                      color: theme.onPrimary, 
                                      size: 15
                                    ),
                                  )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Main content row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Chart type selection, and columns selection
                          Material(
                            type: MaterialType.transparency,
                            child: Container(
                              width: widget.width / 3,
                              height: widget.height - 10 - 10 - 50 - 40 - 20 - 30,
                              margin: const EdgeInsets.only(top: 30),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.current.projects_module_spreadsheet_chart_chart_type_subtitle,
                                      style: theme.titleSmall
                                      .copyWith(color: theme.onSurface),
                                    ),
                                    // Chart Type selector
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Material(
                                        type: MaterialType.transparency,
                                        child: CustomDropdownButton(
                                          width: widget.width / 3.2,
                                          menuTitle: null,
                                          selectedOptionTitle: getChartTypeName(widget.controller.getChartType(widget.controller.activeTab ?? 0)),
                                          backgroundColor: theme.primary,
                                          foregroundColor: theme.onPrimary,
                                          theme: theme,
                                          items: [
                                            CustomSelectionMenuItem(
                                              label: S.current.projects_module_spreadsheet_chart_chart_type_donut, 
                                              labelStyle: theme.bodyMedium.copyWith(color: theme.onPrimary),
                                              icon: CupertinoIcons.chart_pie, 
                                              onTap: () {
                                                widget.controller.selectChartType(
                                                  widget.controller.activeTab ?? 0, 
                                                  CustomChartType.donut
                                                );
                                              }
                                            ),
                                            CustomSelectionMenuItem(
                                              label: S.current.projects_module_spreadsheet_chart_chart_type_bar, 
                                              labelStyle: theme.bodyMedium.copyWith(color: theme.onPrimary),
                                              icon: CupertinoIcons.chart_bar, 
                                              onTap: () {
                                                widget.controller.selectChartType(
                                                  widget.controller.activeTab ?? 0, 
                                                  CustomChartType.barSingle
                                                );
                                              }
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Bar chart type selector
                                    if (barTypes.contains(widget.controller.getChartType(widget.controller.activeTab ?? 0)))
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Row(
                                          children: [
                                            CustomProjectsSpreadsheetModuleBarChartTypeButton(
                                              theme: theme,
                                              onTap: widget.controller.selectChartType,
                                              tooltip: S.current.projects_module_spreadsheet_chart_chart_type_bar_simple,
                                              tabId: widget.controller.activeTab ?? 0,
                                              selectedType: widget.controller.getChartType(widget.controller.activeTab ?? 0),
                                              buttonType: CustomChartType.barSingle
                                            ),
                                            CustomProjectsSpreadsheetModuleBarChartTypeButton(
                                              theme: theme,
                                              onTap: widget.controller.selectChartType,
                                              tooltip: S.current.projects_module_spreadsheet_chart_chart_type_bar_grouped,
                                              tabId: widget.controller.activeTab ?? 0,
                                              selectedType: widget.controller.getChartType(widget.controller.activeTab ?? 0),
                                              buttonType: CustomChartType.barMultiples
                                            ),
                                            CustomProjectsSpreadsheetModuleBarChartTypeButton(
                                              theme: theme,
                                              onTap: widget.controller.selectChartType,
                                              tooltip: S.current.projects_module_spreadsheet_chart_chart_type_bar_stacked,
                                              tabId: widget.controller.activeTab ?? 0,
                                              selectedType: widget.controller.getChartType(widget.controller.activeTab ?? 0),
                                              buttonType: CustomChartType.barStacked
                                            )
                                          ],
                                        ),
                                      ),
                            
                                    // Columns selector
                                    Material(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 30),
                                        child: Text(
                                          widget.controller.chartColumns[widget.controller.activeTab ?? 0]!.length > 1 
                                            ? S.current.projects_module_spreadsheet_chart_chart_column_plural
                                            : S.current.projects_module_spreadsheet_chart_chart_column_single,
                                          style: theme.titleSmall.copyWith(color: theme.onSurface),
                                        )
                                      ),
                                    ),
                                    ...List.generate(widget.controller.chartColumns[widget.controller.activeTab ?? 0]?.length ?? 0, (index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: CustomProjectsSpreadsheetModuleColumnDropdownSelector(
                                          theme: theme,
                                          width: widget.width / 3.2,
                                          height: 40,
                                          controller: widget.controller,
                                          columnIndex: widget.controller.chartColumns[widget.controller.activeTab ?? 0]?[index] ?? 0,
                                          columnName: getColumnName(widget.controller.chartColumns[widget.controller.activeTab ?? 0]?[index] ?? -1),
                                          availableColumns: _getColumns(),
                                        ),
                                      );
                                    }),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                                      child: SizedBox(
                                        width: widget.width / 3.2,
                                        height: 40,
                                        child: IconButton(
                                          icon: Icon(Icons.add_rounded, color: theme.onPrimary),
                                          style: ButtonThemes.secondaryButtonStyle(context).copyWith(elevation: const WidgetStatePropertyAll(0)),
                                          tooltip: S.current.projects_module_spreadsheet_chart_new_column,
                                          onPressed: () async {
                                            widget.controller.addChartColumn(widget.controller.activeTab ?? 0);
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Chart
                          Container(
                            width: widget.width / 1.8,
                            height: widget.height - 10 - 10 - 50 - 40 - 20 - 30,
                            margin: EdgeInsets.only(
                              top: 30, 
                              right: widget.controller.getChartContent(
                                widget.controller.activeTab ?? 0).isEmpty || widget.controller.getChartType(widget.controller.activeTab ?? 0) == CustomChartType.donut 
                                  ? 0 
                                  : 30
                            ),
                            child: CustomChart(
                              controller: CustomChartController(
                                width: widget.width / 1.8,
                                height: widget.height - 10 - 10 - 50 - 40 - 20 - 30, 
                                type: widget.controller.getChartType(widget.controller.activeTab ?? 0), 
                                unit: widget.controller.getChartUnit(widget.controller.activeTab ?? 0),
                                content: widget.controller.getChartContent(widget.controller.activeTab ?? 0),
                              )
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
            ],
          );
        }
      )
    );
  }

  List<CustomChartType> barTypes = [CustomChartType.barMultiples, CustomChartType.barSingle, CustomChartType.barStacked];

  List<MapEntry<int, String>> _getColumns() {
    List<int> usedColumns = widget.controller.chartColumns[widget.controller.activeTab ?? 0] ?? [];

    List<MapEntry<int, CustomTableType>> compatibles = widget.controller.customTableController.columnTypes.entries.where(
      (entry) => entry.value == CustomTableType.number
    ).toList();

    compatibles.removeWhere((element) => usedColumns.contains(element.key));

    List<MapEntry<int, String>> columns = compatibles.map((entry) => MapEntry<int, String>(entry.key, getColumnName(entry.key))).toList();

    return columns;
  }

  String getColumnName(int colIndex) {
    if (colIndex == -1) {
      return S.current.projects_module_spreadsheet_chart_chart_select_column;
    } else {
      return widget.controller.customTableController.columnNames[colIndex] ?? S.current.projects_module_spreadsheet_value_unnamed;
    }
  }

  String getChartTypeName(CustomChartType type) {
    if (type == CustomChartType.donut) {
      return S.current.projects_module_spreadsheet_chart_chart_type_donut;
    } else {
      return S.current.projects_module_spreadsheet_chart_chart_type_bar;
    }
  }

  CustomChartType _getChartType(String typeName) {
    if (typeName == CustomChartType.barMultiples.name) {
      return CustomChartType.barMultiples;
    } else if (typeName == CustomChartType.barSingle.name) {
      return CustomChartType.barSingle;
    } else if (typeName == CustomChartType.barStacked.name) {
      return CustomChartType.barStacked;
    } else {
      return CustomChartType.donut;
    }
  }
}

class CustomProjectsSpreadsheetModuleBarChartTypeButton extends StatefulWidget {
  const CustomProjectsSpreadsheetModuleBarChartTypeButton({
    super.key, 
    required this.theme,
    required this.selectedType, 
    required this.buttonType,
    required this.tabId,
    required this.tooltip,
    required this.onTap
  });

  final StylesGetters theme;
  final CustomChartType selectedType;
  final CustomChartType buttonType;
  final String tooltip;
  final int tabId;
  final Function(int, CustomChartType) onTap;

  @override
  State<CustomProjectsSpreadsheetModuleBarChartTypeButton> createState() => _CustomProjectsSpreadsheetModuleBarChartTypeButtonState();
}

class _CustomProjectsSpreadsheetModuleBarChartTypeButtonState extends State<CustomProjectsSpreadsheetModuleBarChartTypeButton> {

  bool isHovering = false;

  Color getColor() {
    return widget.selectedType == widget.buttonType 
      ? widget.theme.secondary 
      : widget.theme.onSecondary;
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: GestureDetector(
        onTap: () {
          widget.onTap(widget.tabId, widget.buttonType);
        },
        child: MouseRegion(
          onEnter: (details) => isHovering = true,
          onExit: (details) => isHovering = false,
          cursor: SystemMouseCursors.click,
          child: Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.only(bottom: 5, right: 5, left: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isHovering ? getColor().withValues(alpha: 0.7) : getColor()
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: widget.buttonType == CustomChartType.barStacked 
              ? [
                SizedBox(
                  width: 8,
                  height: 30,
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            width: 8,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: widget.selectedType == widget.buttonType 
                                ? widget.theme.onSecondary 
                                : widget.theme.secondary
                            ),
                          ),
                          Container(
                            width: 8,
                            height: 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: DefaultAppColors.mintGreen.color
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 8,
                  height: 30,
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            width: 8,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: widget.selectedType == widget.buttonType 
                                ? widget.theme.onSecondary 
                                : widget.theme.secondary
                            ),
                          ),
                          Container(
                            width: 8,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: DefaultAppColors.mintGreen.color
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ]
              : [
                Container(
                  width: 8,
                  height: 15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: widget.selectedType == widget.buttonType 
                      ? widget.theme.onSecondary 
                      : widget.theme.secondary
                  ),
                ),
                Container(
                  width: 8,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: widget.buttonType == CustomChartType.barMultiples
                      ? DefaultAppColors.mintGreen.color 
                      : widget.selectedType == widget.buttonType 
                        ? widget.theme.onSecondary
                        : widget.theme.secondary
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}