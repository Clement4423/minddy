import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/project_info.dart';
import 'package:minddy/system/notifications/notification_handler.dart';
import 'package:minddy/system/projects/app_project.dart';
import 'package:minddy/system/router/app_router.dart';
import 'package:minddy/system/utils/calculate_text_contrast.dart';
import 'package:minddy/system/utils/color_spaces_permutations.dart';
import 'package:minddy/ui/components/custom_components/custom_chart/custom_chart_colors.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/components/menus/sub_menus/unlock_content_submenu.dart';
import 'package:minddy/ui/components/notifications/notification_widget.dart';
import 'package:minddy/ui/components/settings/settings_menu.dart';
import 'package:minddy/ui/theme/theme.dart';

class ProjectCard extends StatefulWidget {
  final ProjectInfo projectInfo;
  final Function function;
  const ProjectCard({super.key, required this.projectInfo, required this.function});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {

  bool isHovering = false;

  late List<Color> colors = generateSequentialPalette(2, widget.projectInfo.color);

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () async {
              if (widget.projectInfo.isPrivate) {
                bool isUnlocked = await showUnlockContentSubMenu(context);
                if (isUnlocked && context.mounted) {
                  await AppRouter.router.showProject(context, widget.projectInfo);
                }
              } else {
                await AppRouter.router.showProject(context, widget.projectInfo);
              }
            },
            child: MouseRegion(
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
              cursor: SystemMouseCursors.click,
              child: Container(
                  width: 185,
                  height: 185,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: colors
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(5, 5),
                        blurStyle: BlurStyle.normal,
                        blurRadius: 10,
                        color: theme.shadow.withValues(alpha: 0.15)                        
                      )
                    ]
                  ),
                  child: Column (
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Title box
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: TweenAnimationBuilder(
                              key: UniqueKey(),
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeOut,
                              tween: Tween<double>(
                                begin: 0.0,
                                end: 1.0
                              ),
                              builder: (context, opacity, child) {
                                return Opacity(
                                  opacity: opacity,
                                  child: Container(
                                    width: 165,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: isHovering 
                                        ? theme.secondary
                                        : theme.primaryContainer,
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(left: widget.projectInfo.isPrivate ? 15 : 10),
                                          child: Text(
                                            isHovering 
                                              ? S.of(context).projetcs_module_spreadsheet_open_website('')
                                              : widget.projectInfo.name, 
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: theme.titleMedium.
                                            copyWith(color: isHovering
                                              ? theme.onSecondary
                                              : hasSufficientContrast(theme.onPrimary, mixColors(theme.primaryContainer, widget.projectInfo.color, 0.3)) 
                                                ? theme.onPrimary
                                                : theme.brightness == Brightness.dark ? theme.onPrimary : theme.primary
                                            ),
                                          ),
                                        ),
                                        if (widget.projectInfo.isPrivate && isHovering)
                                          Positioned(
                                            left: 5,
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                color: theme.secondary
                                              ),
                                              child: Icon(
                                                Icons.lock_outline_rounded,
                                                color: theme.onSecondary,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
            ),
          ),
          Positioned(
            top: 15,
            right: 15,
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
                    showSettings(context, pageRouteName: "/project", argument: {'info': widget.projectInfo, 'function': widget.function});
                  }
                ),
                CustomSelectionMenuItem(
                  label: S.of(context).project_card_duplicate, 
                  icon: Icons.copy_rounded, 
                  onTap: () async {
                    await AppProject.duplicateProject(widget.projectInfo.path); widget.function();
                  }
                ),
                CustomSelectionMenuItem(
                  label: S.of(context).project_card_delete, 
                  icon: Icons.delete_outline_rounded, 
                  foregroundColor: theme.error,
                  onTap: () {
                    NotificationHandler.addNotification(
                      NotificationModel(
                        content: S.of(context).snackbar_delete_element_text(widget.projectInfo.name),
                        action: () async {
                          if (widget.projectInfo.isPrivate) {
                            bool isUnlocked = await showUnlockContentSubMenu(context);
                            if (isUnlocked) {
                              await AppProject.removeProject(widget.projectInfo.path);
                              widget.function();
                            }
                          } else {
                            await AppProject.removeProject(widget.projectInfo.path);
                            widget.function();
                          }
                        }, 
                        actionLabel: S.of(context).snackbar_delete_button, 
                        duration: NotificationDuration.long
                      )
                    );
                  }
                ),
              ], 
              child: Icon(
                Icons.more_horiz_rounded, 
                color: hasSufficientContrast(theme.onPrimary, mixColors(theme.primaryContainer, widget.projectInfo.color, 0.3)) 
                  ? theme.onPrimary
                  : theme.brightness == Brightness.dark ? theme.onPrimary : theme.primary
              )
            )
          ),
        ],
      ),
    );
  }
}