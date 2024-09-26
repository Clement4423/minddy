import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/project_info.dart';
import 'package:minddy/system/notifications/notification_handler.dart';
import 'package:minddy/system/projects/app_project.dart';
import 'package:minddy/system/router/app_router.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/components/notifications/notification_widget.dart';
import 'package:minddy/ui/components/settings/settings_menu.dart';
import 'package:minddy/ui/theme/theme.dart';

class ProjectCard extends StatelessWidget {
  final ProjectInfo projectInfo;
  final Function function;
  final Color? background;
  const ProjectCard({super.key, required this.projectInfo, required this.function, required this.background});

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () async {
              await AppRouter.router.showProject(context, projectInfo);
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                  width: 185,
                  height: 185,
                  decoration: BoxDecoration(
                    color: background ?? theme.secondary,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(5, 5),
                        blurStyle: BlurStyle.normal,
                        blurRadius: 10,
                        color: theme.shadow.withOpacity(0.15)                        
                      )
                    ]
                  ),
                  child: Column (
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 185,
                        height: 60,
                        decoration: BoxDecoration(
                          color: theme.primaryContainer,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(25), 
                            bottomRight: Radius.circular(25)
                          )
                        ),
                        child: Center(
                          child: Text(
                            projectInfo.name, 
                            overflow: TextOverflow.ellipsis,
                            style: theme.titleMedium.
                            copyWith(color: theme.onPrimary),
                          ),
                        ),
                      )
                      ],
                  ),
                ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            width: 40,
            height: 40,
            child: CustomSelectionMenu(
              theme: theme, 
              type: CustomSelectionMenuButttonType.icon,
              buttonStyle: ButtonThemes.primaryButtonStyle(context).copyWith(
                backgroundColor: WidgetStatePropertyAll(theme.primaryContainer),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                ))
              ),
              items: [
                CustomSelectionMenuItem(
                  label: S.of(context).project_card_open_settings, 
                  icon: Icons.brush_rounded, 
                  onTap: () {
                    showSettings(context, pageRouteName: "/project", argument: {'info': projectInfo, 'function': function});
                  }
                ),
                CustomSelectionMenuItem(
                  label: S.of(context).project_card_duplicate, 
                  icon: Icons.copy_rounded, 
                  onTap: () async {
                    await AppProject.duplicateProject(projectInfo.path); function();
                  }
                ),
                CustomSelectionMenuItem(
                  label: S.of(context).project_card_delete, 
                  icon: Icons.delete_outline_rounded, 
                  foregroundColor: theme.error,
                  onTap: () {
                    NotificationHandler.addNotification(
                      NotificationModel(
                        content: S.of(context).snackbar_delete_element_text(projectInfo.name),
                        action: () async {
                          await AppProject.removeProject(projectInfo.path);
                          function();
                        }, 
                        actionLabel: S.of(context).snackbar_delete_button, 
                        duration: NotificationDuration.long
                      )
                    );
                  }
                ),
              ], 
              child: Icon(Icons.more_horiz_rounded, color: theme.secondary)
            )
          ),
        ],
      ),
    );
  }
}

// CustomPopupItemModel(
//   text: Text(S.of(context).project_card_open_settings, style: theme.bodyMedium.copyWith(color: theme.onPrimary)),
//   icon: Icon(Icons.brush_rounded, color: theme.onPrimary,),
//   action: () {showSettings(context, pageRouteName: "/project", argument: {'info': projectInfo, 'function': function});},
// ),
// // Duplicate
// CustomPopupItemModel(
//   text: Text(S.of(context).project_card_duplicate, style: theme.bodyMedium.copyWith(color: theme.onPrimary)),
//   icon: Icon(Icons.copy_rounded, color: theme.onPrimary,),
//   action: () async {await AppProject.duplicateProject(projectInfo.path); function();},
// ),
// // Delete
// CustomPopupItemModel(
//   text: Text(S.of(context).project_card_delete, style: theme.bodyMedium.copyWith(color: theme.error)),
//   icon: Icon(Icons.delete_outline_rounded, color: theme.error,), 
//   action: () {
//     NotificationHandler.addNotification(
//       NotificationModel(
//         content: S.of(context).snackbar_delete_element_text(projectInfo.name),
//         action: () async {
//           await AppProject.removeProject(projectInfo.path);
//           function();
//         }, 
//         actionLabel: S.of(context).snackbar_delete_button, 
//         duration: NotificationDuration.long
//       )
//     );
//   },
// ),