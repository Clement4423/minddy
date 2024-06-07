import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/custom_appbar_button_model.dart';
import 'package:minddy/system/model/projects_modules.dart';
import 'package:minddy/ui/components/appbar/custom_appbar.dart';
import 'package:minddy/ui/components/appbar/custom_appbar_controller.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_buttons_components/articles_menu_button.dart';
import 'package:minddy/ui/components/calendar/calendar_button.dart';
import 'package:minddy/ui/components/projects/toolbar/projects_toolbar.dart';
import 'package:minddy/ui/components/settings/settings_menu.dart';
import 'package:minddy/ui/theme/theme.dart';
import 'package:minddy/ui/view_models/project_viewmodel.dart';

class ProjectView extends StatefulWidget {
  const ProjectView(this._viewmodel, {super.key});

  final ProjectViewModel _viewmodel;

  @override
  State<ProjectView> createState() => _ProjectViewState();
}

class _ProjectViewState extends State<ProjectView> {

  @override
  void initState() {
    widget._viewmodel.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.background,
        image: const DecorationImage(
         image: AssetImage(
          "assets/background/backround_project.PNG"
         ),
         fit: BoxFit.cover,
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(CustomAppBarController(
          widget._viewmodel.projectInfo.name,
          true,
              [
                CustomAppBarButtonModel(
                  icon: Icons.settings_rounded, 
                  semanticText: S.of(context).settings_title,
                  isPrimary: false, 
                  action: () async {await showSettings(context);}
                ),
                CustomAppBarButtonModel(
                  icon: Icons.add_box_outlined, 
                  semanticText: "New module",
                  isPrimary: true, 
                  action: () async {await _showAddModuleMenu(context, widget._viewmodel);}
                ),
                CustomAppBarButtonModel(
                  icon: Icons.save_rounded, 
                  semanticText: "Save",
                  isPrimary: true, 
                  action: () async {await widget._viewmodel.saveProject();}
                ),              ] 
          )),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return AnimatedBuilder(
              animation: widget._viewmodel,
              builder: (context, child) {
                widget._viewmodel.buildContainers(constraints.biggest);
                return Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 25),
                          child: SizedBox(),
                        ),
                        Expanded(
                          child: PageView.builder(
                            itemCount: widget._viewmodel.modulesContainer.length,
                            itemBuilder: (context, index) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ...widget._viewmodel.modulesContainer[index].modules,
                                ],
                              );
                            },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 25),
                          child: SizedBox(),
                        )
                      ],
                    ),
                    const ProjectsToolbar(),
                    const ArticlesMenuButton(),
                    const CalendarButton(),
                  ],
                );
              }
            );
          }
        ),
      ),
    );
  }
}


Future<dynamic> _showAddModuleMenu(BuildContext context, ProjectViewModel viewModel) async {
  RenderBox renderBox = context.findRenderObject() as RenderBox;
  final offset = renderBox.localToGlobal(Offset.zero);
  const iconSize = 25.0;
  const menuHeight = 80.0;
  StylesGetters theme = StylesGetters(context);
  showMenu(
    context: context,
    color: theme.primary,
    position: RelativeRect.fromLTRB(
      double.infinity,
      offset.dy + menuHeight - iconSize, // top
      75,
      offset.dy, // bottom
    ),
      items: [
        PopupMenuItem(
          onTap: () {
            viewModel.newModule(ProjectsModules.tasks);
          },
          child: Text(S.current.projects_module_tasks_title)
        ),
      ]
  );
}