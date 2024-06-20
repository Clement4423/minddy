import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/articles/app_articles.dart';
import 'package:minddy/system/model/note_model.dart';
import 'package:minddy/system/notes/app_notes.dart';
import 'package:minddy/ui/components/custom_components/note_widget.dart';
import 'package:minddy/ui/components/menus/popup_menu/popup_menu_button.dart';
import 'package:minddy/ui/components/menus/popup_menu/popup_menu_item_model.dart';
import 'package:minddy/ui/components/menus/sub_menus/note_editing_sub_menu.dart';
import 'package:minddy/ui/components/menus/sub_menus/sub_menus_container.dart';
import 'package:minddy/ui/components/menus/sub_menus_controllers/note_editing_submenu_controller.dart';
import 'package:minddy/ui/components/projects/modules/notes/project_notes_module_note_categories_view.dart';
import 'package:minddy/ui/components/projects/modules/notes/projects_modules_note_view_controller.dart';
import 'package:minddy/ui/theme/theme.dart';


class ProjectNoteModuleNotesListView extends StatefulWidget {
  const ProjectNoteModuleNotesListView({super.key, required this.category, required this.width, required this.height, required this.controller, required this.deleteFunction, required this.duplicateFunction, required this.categoryTitle});

  final String category;

  final String categoryTitle;

  final double width;
  final double height;
  final ProjectsNotesModuleController controller;

  final Function(int) deleteFunction;

  final Function(int) duplicateFunction;

  @override
  State<ProjectNoteModuleNotesListView> createState() => _ProjectNoteModuleNotesListViewState();
}

class _ProjectNoteModuleNotesListViewState extends State<ProjectNoteModuleNotesListView> {

  List<NoteWidget> notesWidgets = [];


  @override
  void initState() {
    _loadNotes(context);
    super.initState();
  }

  Future<void> _loadNotes(BuildContext context) async {
    List<NoteModel> models = widget.category == 'PROJECT'
      ? await widget.controller.getProjectNotes()
      : await AppNotes.getNotes(widget.category);

    if (!context.mounted) {
      return;
    }

    final widgets = await _getNotesWidgets(
      widget.category, 
      context,
      () {_loadNotes(context);},
      models, 
      _loadNotes,
      widget.controller
    );
    
    setState(() {
      notesWidgets = widgets;
    });
  }

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Column(
      children: [
        // Header
        Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(5),
          height: 100,
          decoration: BoxDecoration(
            color: theme.surface,
            borderRadius: BorderRadius.circular(15)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon and title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Icon(Icons.notes_rounded, color: theme.onSurface),
                  ),
                  Text(
                    widget.categoryTitle,
                    style: theme.titleMedium.copyWith(color: theme.onSurface),
                  ),
                  // Module options
                  CustomPopupMenuButton(items: [
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
                ],
              ),
              // New task button
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 38,
                      width: widget.width / 2.15,
                      child: IconButton(
                        tooltip: "Go back",
                        onPressed: () async {
                          widget.controller.actualView = ProjectNotesModuleNoteCategoriesView(
                            width: widget.width, 
                            height: widget.height, 
                            controller: widget.controller, 
                            deleteFunction: widget.deleteFunction, 
                            duplicateFunction: widget.duplicateFunction
                          );
                          widget.controller.viewChanged();
                        },
                        style: ButtonThemes.secondaryButtonStyle(context),
                        icon: Icon(Icons.arrow_back_rounded, color: theme.onPrimary)
                      ),
                    ),
                    SizedBox(
                      height: 38,
                      width: widget.width / 2.15,
                      child: IconButton(
                        tooltip: "New note",
                        onPressed: () async {
                          NoteModel model = NoteModel(
                                title: '',
                                id: int.parse(AppArticles.createFileName(widget.category)), 
                                category: widget.category, 
                                content: []
                              );
                          if (widget.category == 'PROJECT') {
                            await widget.controller.addProjectNote(model);
                          } else {
                            await AppNotes.addNote(model, widget.category);
                          }
                          if (context.mounted) {
                            NoteEditingSubMenuController noteController = NoteEditingSubMenuController(
                              noteModel: model,
                              onClosed: () {_loadNotes(context);},
                              notesModuleController: widget.controller
                            );
                            showSubMenu(
                              context, 
                              NoteEditingSubMenu(
                                controller: noteController
                              ),
                              onMenuDismissed: () async {
                                await noteController.closeNote();

                                if (context.mounted) {
                                  await _loadNotes(context);
                                } 
                              }
                            );
                            await _loadNotes(context);
                          }
                        },
                        style: ButtonThemes.primaryButtonStyle(context),
                        icon: Icon(Icons.add_rounded, color: theme.onSecondary)
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
              child: ListView(
                padding: const EdgeInsets.only(right: 12),
                children: notesWidgets,
              ),
            ),
          )
        )
      ],
    );
  }
}

Future<List<NoteWidget>> _getNotesWidgets(String category, BuildContext context, Function onDelete, List<NoteModel> models, Function onDismissed, ProjectsNotesModuleController controller) async {
  
  List<NoteWidget> widgets = [];

  for (NoteModel model in models) {
    widgets.add(
      NoteWidget(
        noteModel: model, 
        category: category,
        actionTooltip: "Modify this note",
        action: () {
          NoteEditingSubMenuController noteController = NoteEditingSubMenuController(
            noteModel: model, 
            onClosed: () {onDismissed(context);},
            notesModuleController: controller
          );
          showSubMenu(
            context, 
            NoteEditingSubMenu(
              controller: noteController
            ),
            onMenuDismissed: () async {
              await noteController.closeNote();

              if (context.mounted) {
                onDismissed(context);
              } 
            }
          );
        },
        deleteMethod: _getNoteWidgetDeleteMethod(category, model, controller), 
        actionIcon: Icons.brush_rounded,
        onDelete: onDelete,
      )
    );
  }
  return widgets;
}

Function? _getNoteWidgetDeleteMethod(String notesCategory, NoteModel noteModel, ProjectsNotesModuleController controller) {
  if (notesCategory == 'PROJECT') {
    return () async {
      await controller.deleteProjectNote(noteModel);
    };
  }
  return null;
}