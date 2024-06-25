import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:minddy/system/interface/articles_element_interface.dart';
import 'package:minddy/system/model/note_model.dart';
import 'package:minddy/system/model/project_note_module_category_model.dart';
import 'package:minddy/system/notes/app_notes.dart';
import 'package:minddy/ui/components/custom_components/Custom_element_editor_envelop.dart';
import 'package:minddy/ui/components/custom_components/custom_bulleted_list.dart';
import 'package:minddy/ui/components/custom_components/custom_code_display.dart';
import 'package:minddy/ui/components/custom_components/custom_image_display.dart';
import 'package:minddy/ui/components/custom_components/custom_text_area.dart';
import 'package:minddy/ui/components/menus/popup_menu/popup_menu_button.dart';
import 'package:minddy/ui/components/menus/popup_menu/popup_menu_item_model.dart';
import 'package:minddy/ui/components/menus/sub_menus_controllers/note_editing_submenu_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

class NoteEditingSubMenu extends StatefulWidget {
  const NoteEditingSubMenu({super.key, required this.controller});

  final NoteEditingSubMenuController controller;

  @override
  State<NoteEditingSubMenu> createState() => _NoteEditingSubMenuState();
}

class _NoteEditingSubMenuState extends State<NoteEditingSubMenu> {
  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 700,
          height: 500,
          decoration: BoxDecoration(
            color: theme.primaryContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              // Header row, with title and actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            onChanged: (value) {
                              widget.controller.noteModel.title = value;
                            },
                            controller: TextEditingController(
                              text: widget.controller.noteModel.title ==
                                      S.of(context).articles_card_untitled
                                  ? ''
                                  : widget.controller.noteModel.title,
                            ),
                            style: theme.titleLarge.copyWith(color: theme.onPrimary),
                            cursorColor: theme.onPrimary,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: S.of(context).articles_card_untitled,
                            ),
                          ),
                          // Last modified
                          Text(
                            widget.controller.formatDate(widget.controller.noteModel.lastModified),
                            style: theme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Actions row
                  Padding(
                    padding: const EdgeInsets.only(top: 10, right: 8),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SizedBox(
                            width: 42,
                            height: 42,
                            child: IconButton(
                              onPressed: () async {
                                await widget.controller.addNoteElement(NoteElementContentType.code);
                              },
                              tooltip: S.of(context).articles_add_code_semantic_text,
                              style: ButtonThemes.secondaryButtonStyle(context),
                              icon: Icon(Icons.code_rounded, color: theme.onPrimary),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SizedBox(
                            width: 42,
                            height: 42,
                            child: IconButton(
                              onPressed: () async {
                                await widget.controller.addNoteElement(NoteElementContentType.list);
                              },
                              tooltip: S.of(context).articles_add_list_semantic_text,
                              style: ButtonThemes.secondaryButtonStyle(context),
                              icon: Icon(Icons.format_list_bulleted_rounded, color: theme.onPrimary),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SizedBox(
                            width: 42,
                            height: 42,
                            child: IconButton(
                              onPressed: () async {
                                await widget.controller.addNoteElement(NoteElementContentType.text);
                              },
                              tooltip: S.of(context).articles_add_text_semantic_text,
                              style: ButtonThemes.secondaryButtonStyle(context),
                              icon: Icon(Icons.text_fields_rounded, color: theme.onPrimary),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SizedBox(
                            width: 42,
                            height: 42,
                            child: IconButton(
                              onPressed: () async {
                                await widget.controller.addNoteElement(NoteElementContentType.image);
                              },
                              tooltip: S.of(context).articles_add_image_semantic_text,
                              style: ButtonThemes.secondaryButtonStyle(context),
                              icon: Icon(Icons.photo_outlined, color: theme.onPrimary),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: CustomPopupMenuButton(
                            items: [
                              CustomPopupItemModel(
                                text: Text(
                                  S.of(context).projects_module_notes_editing_note_sub_menu_move_tooltip,
                                  style: theme.bodyMedium.copyWith(color: theme.onPrimary),
                                ),
                                icon: Icon(Icons.arrow_outward_rounded, color: theme.onPrimary),
                                action: () async {
                                  _showCategoriesDestinationMenu(context, theme, widget.controller);
                                },
                              ),
                              CustomPopupItemModel(
                                text: Text(
                                  S.of(context).project_card_duplicate,
                                  style: theme.bodyMedium.copyWith(color: theme.onPrimary),
                                ),
                                icon: Icon(Icons.copy_rounded, color: theme.onPrimary),
                                action: () async {
                                  await widget.controller.duplicateNote();
                                },
                              ),
                              CustomPopupItemModel(
                                text: Text(
                                  S.of(context).snackbar_delete_button,
                                  style: theme.bodyMedium.copyWith(color: theme.error),
                                ),
                                icon: Icon(Icons.delete_outline_rounded, color: theme.error),
                                action: () async {
                                  bool isDeleted = await widget.controller.deleteNote();
                                  if (widget.controller.onClosed != null) {
                                    await widget.controller.onClosed!();
                                  }
                                  if (isDeleted && context.mounted) {
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        // Quit button
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SizedBox(
                            width: 42,
                            height: 42,
                            child: IconButton(
                              tooltip: S.of(context).projects_module_notes_editing_note_sub_menu_save_tooltip,
                              onPressed: () async {
                                bool isSaved = await widget.controller.closeNote();
                                if (widget.controller.onClosed != null) {
                                  await widget.controller.onClosed!();
                                }
                                if (isSaved && context.mounted) {
                                  Navigator.pop(context);
                                }
                              },
                              style: ButtonThemes.primaryButtonStyle(context),
                              icon: Icon(Icons.check_rounded, color: theme.onSecondary),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Note content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: AnimatedBuilder(
                    animation: widget.controller,
                    builder: (context, child) {
                      if (widget.controller.noteModel.content.isEmpty) {
                        widget.controller.addNoteElement(NoteElementContentType.text);
                      }
                      widget.controller.noteContentWidgets.clear();
                      return ListView.builder(
                        itemCount: widget.controller.noteModel.content.length,
                        itemBuilder: (context, index) {
                          IArticlesWriteElement elementWidget = _buildNoteContentWidget(widget.controller.noteModel.content[index]);
                          widget.controller.noteContentWidgets.add(elementWidget);

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: CustomElementEditorEnvelop(
                              removeFunction: () async {
                                await widget.controller.deleteNoteElement(elementWidget.key ?? UniqueKey());
                              }, 
                              sideMenuIconOffsetOnYAxis: 5, 
                              child: elementWidget
                            ),
                          );
                        }
                      );
                    }
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}

IArticlesWriteElement _buildNoteContentWidget(NoteContentModel contentElementModel) {
  switch (contentElementModel.type) {
    case NoteElementContentType.code:
      return CustomCodeDisplay(
        initialCode: contentElementModel.data['code'] ?? '', 
        initialLanguageIndex: contentElementModel.data['language'] ?? 0,
        key: UniqueKey(),
      );
    case NoteElementContentType.text:
      return CustomTextArea(
        initialText: contentElementModel.data ?? '',
        key: UniqueKey()
      );
    case NoteElementContentType.image:
      return CustomImageDisplay(
        initialUrl: contentElementModel.data['url'] ?? '', 
        initialDescription: contentElementModel.data['description'] ?? '',
        key: UniqueKey()
      );
    case NoteElementContentType.list:
      return CustomBulletedList(
        initialContent: contentElementModel.data ?? [], 
        key: UniqueKey()
      );
  }
}

_showCategoriesDestinationMenu(BuildContext context, StylesGetters theme, NoteEditingSubMenuController controller) async {
    List<PopupMenuItem> items = [];

    List<ProjectNoteModuleCategoryModel> categories = await AppNotes.getCategories();

    if (StaticVariables.currentProjectInfo != null) {

      categories.insert(
        0, 
        ProjectNoteModuleCategoryModel(
          title: S.current.projects_module_notes_project_notes_title,
          icon: Icons.chair_outlined,
          noteCount: 0,
          isPrivate: false,
          categoryName: 'PROJECT',
        ),
      );
    }

    for (ProjectNoteModuleCategoryModel category in categories) {
      items.add(
        PopupMenuItem(
          onTap: () async {
            await controller.saveNote();
            await controller.moveNote(category.categoryName);
            if (context.mounted) {
              Navigator.pop(context);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(category.title),
              Icon(category.icon),
            ],
          ), 
        )
      );
    }

    if (context.mounted) {
      RenderBox renderBox = context.findRenderObject() as RenderBox;
      final offset = renderBox.localToGlobal(Offset.zero);

      showMenu(
        context: context,
        position: RelativeRect.fromLTRB(
          offset.dx + 1, // Left
          offset.dy + 70, // Top
          offset.dx, // Right
          offset.dy, // Bottom
        ),
        color: theme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13)
        ),
        items: items
      );
    }
}