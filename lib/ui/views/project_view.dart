import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/custom_appbar_button_model.dart';
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
              ] 
          )),

        body: AnimatedBuilder(
          animation: widget._viewmodel,
          builder: (context, child) {
            return const Stack(
              children: [
                Column(
                  children: [
                    ProjectsToolbar()
                  ],
                ),
                ArticlesMenuButton(),
                CalendarButton(),
              ],
            );
          }
        ),
      ),
    );
  }
}
