import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/notes/app_notes.dart';
import 'package:minddy/ui/components/menus/custom_tooltip.dart';
import 'package:minddy/ui/components/menus/popup_menu/popup_menu_button.dart';
import 'package:minddy/ui/components/menus/popup_menu/popup_menu_item_model.dart';
import 'package:minddy/ui/components/menus/sub_menus/modify_note_category_sub_menu.dart';
import 'package:minddy/ui/components/menus/sub_menus/sub_menus_container.dart';
import 'package:minddy/ui/components/menus/sub_menus/unlock_content_submenu.dart';
import 'package:minddy/ui/theme/theme.dart';

class ProjectNoteModuleCategoryCard extends StatelessWidget {
  const ProjectNoteModuleCategoryCard({super.key, required this.title, required this.icon, required this.action, required this.itemCount, required this.isManageable, required this.categoryName, required this.onDelete, required this.isPrivate});

  final String title;
  final IconData icon;

  final bool isPrivate;

  final String categoryName;

  final bool isManageable;

  final Function onDelete;

  final int itemCount;

  final Function action;

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          if (isPrivate) {
            bool isUnlocked = await showUnlockContentSubMenu(context);
            if (isUnlocked) {
              await action();
            }
          } else {
            await action();
          }
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: theme.surface,
            borderRadius: BorderRadius.circular(15)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTooltip(
                          message: title,
                          lengthTreshold: isManageable ? 11 : 17,
                          child: Text(
                            title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.titleLarge.
                            copyWith(
                              color: theme.onSurface, 
                              fontWeight: FontWeight.w600
                            )
                          ),
                        ),
                        Text(
                          isPrivate 
                            ? '' 
                            : S.of(context).projects_module_notes_category_note_count(itemCount), 
                          style: theme.bodySmall.
                          copyWith(color: theme.onSurface)
                        ),
                      ],
                    ),
                  ),
                  if (isManageable)
                    CustomPopupMenuButton(items: [
                      CustomPopupItemModel(
                        text: Text(S.of(context).projects_module_notes_modify_category, style: theme.bodyMedium.copyWith(color: theme.onPrimary)), 
                        icon: Icon(Icons.brush_rounded, color: theme.onPrimary),
                        action: () async {
                          await showSubMenu(
                            context, 
                            ModifyNoteCategorySubMenu(
                              onCompleted: onDelete, 
                              categoryTitle: title, 
                              categoryName: categoryName, 
                              isPrivate: isPrivate
                            )
                          );
                        }
                      ),
                      CustomPopupItemModel(
                        text: Text(S.of(context).snackbar_delete_button, style: theme.bodyMedium.copyWith(color: theme.error)), 
                        icon: Icon(Icons.delete_outline_rounded, color: theme.error),
                        action: () async {
                          if (isPrivate) {
                            bool isUnlocked = await showUnlockContentSubMenu(context);
                            if (isUnlocked) {
                              await AppNotes.deleteCategory(categoryName);
                            }
                          } else {
                            await AppNotes.deleteCategory(categoryName);
                          }
                          await onDelete();
                        }
                      )
                    ]
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomRight, 
                child: Icon(
                  icon, color: theme.onSurface, 
                  size: 50
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}