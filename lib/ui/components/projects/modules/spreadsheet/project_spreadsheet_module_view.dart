import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/interface/projects_modules_controller_interface.dart';
import 'package:minddy/system/interface/projects_modules_interface.dart';
import 'package:minddy/ui/components/custom_components/custom_chart/custom_chart_types.dart';
import 'package:minddy/ui/components/custom_components/custom_table/custom_table_view.dart';
import 'package:minddy/ui/components/menus/popup_menu/popup_menu_button.dart';
import 'package:minddy/ui/components/menus/popup_menu/popup_menu_item_model.dart';
import 'package:minddy/ui/components/projects/modules/spreadsheet/chart_tab_widget.dart';
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
                          tooltip: widget.controller.showTable ? "Convert to chart" : "Show table",
                          style: ButtonThemes.secondaryButtonStyle(context),
                          icon: Icon(widget.controller.showTable ? CupertinoIcons.chart_pie : CupertinoIcons.table, color: theme.onPrimary)
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5, left: 5),
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
                                    tabId: tabId, 
                                    isSelected: index == widget.controller.tabs.keys.toList().indexOf(widget.controller.activeTab ?? 0) ? true : false,
                                    chartType: _getChartType(widget.controller.chartsTypes[tabId] ?? ''), 
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
                                  style: ButtonStyle(
                                    shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)
                                      )
                                    ),
                                    backgroundColor: MaterialStatePropertyAll(theme.primary)
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
                          SingleChildScrollView(
                            child: SizedBox(
                              width: widget.width / 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  
                                ],
                              ),
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
