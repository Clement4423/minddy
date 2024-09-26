import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/notes/app_notes.dart';
import 'package:minddy/ui/components/cards/project_note_module_category_card.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/components/menus/sub_menus/new_note_category_sub_menu.dart';
import 'package:minddy/ui/components/menus/sub_menus/sub_menus_container.dart';
import 'package:minddy/ui/components/projects/modules/notes/project_note_module_notes_list_view.dart';
import 'package:minddy/ui/components/projects/modules/notes/projects_modules_note_view_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

class ProjectNotesModuleNoteCategoriesView extends StatefulWidget {
  const ProjectNotesModuleNoteCategoriesView({
    super.key,
    required this.width,
    required this.height,
    required this.controller,
    required this.deleteFunction,
    required this.duplicateFunction
  });

  final double width;
  final double height;
  final ProjectsNotesModuleController controller;
  final Function(int) deleteFunction;
  final Function(int) duplicateFunction;

  @override
  State<ProjectNotesModuleNoteCategoriesView> createState() => _ProjectNotesModuleNoteCategoriesViewState();
}

class _ProjectNotesModuleNoteCategoriesViewState extends State<ProjectNotesModuleNoteCategoriesView> {
  @override
  void initState() {
    _loadCategories();
    super.initState();
  }

  Future<bool> _loadCategories() async {
    try {
      await widget.controller.getCategories();
      return true;
    } catch (e) {
      return false;
    }
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
                    S.of(context).projects_module_notes_title,
                    style: theme.titleMedium.copyWith(color: theme.onSurface),
                  ),
                  // Module options
                  CustomSelectionMenu(
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
                ],
              ),
              // New task button
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 38,
                  width: widget.width,
                  child: IconButton(
                    tooltip: S.of(context).projects_module_notes_new_category_tooltip,
                    onPressed: () async {
                      await showSubMenu(context, NewNoteCategorySubMenu(onCompleted: () async {
                        setState(() {});
                      }));
                    },
                    style: ButtonThemes.primaryButtonStyle(context),
                    icon: Icon(Icons.add_rounded, color: theme.onSecondary)
                  ),
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
              child: FutureBuilder(
                future: _loadCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading");
                  } else if (snapshot.hasError) {
                    return const Text("ERROR");
                  } else if (snapshot.hasData && snapshot.data == true) {
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8
                      ),
                      padding: const EdgeInsets.only(right: 12),
                      itemCount: widget.controller.categories.length,
                      itemBuilder: (context, index) {
                        return ProjectNoteModuleCategoryCard(
                          title: widget.controller.categories[index].title,
                          itemCount: widget.controller.categories[index].noteCount,
                          isPrivate: widget.controller.categories[index].isPrivate,
                          icon: widget.controller.categories[index].icon,
                          isManageable: _checkIfCategoryIsManageable(widget.controller.categories[index].categoryName),
                          categoryName: widget.controller.categories[index].categoryName,
                          onDelete: () async {
                            setState(() {});
                          },
                          action: () {
                            widget.controller.actualView = ProjectNoteModuleNotesListView(
                              category: widget.controller.categories[index].categoryName,
                              width: widget.width,
                              height: widget.height,
                              categoryTitle: widget.controller.categories[index].title,
                              controller: widget.controller, 
                              deleteFunction: widget.deleteFunction,
                              duplicateFunction: widget.duplicateFunction
                            );
                            widget.controller.viewChanged();
                          },
                        );
                      },
                    );
                  } else {
                    return const Text("ERROR");
                  }
                }
              ),
            ),
          )
        )
      ],
    );
  }
}

bool _checkIfCategoryIsManageable(String categoryName) {
  if (categoryName == 'PROJECT' || AppNotes.defaultNotesCategories.keys.contains(categoryName)) {
    return false;
  } else {
    return true;
  }
}

