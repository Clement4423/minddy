import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:minddy/system/model/note_model.dart';
import 'package:minddy/system/model/project_note_module_category_model.dart';
import 'package:minddy/system/notes/app_notes.dart';
import 'package:minddy/ui/components/cards/project_note_module_category_card.dart';
import 'package:minddy/ui/components/custom_components/note_widget.dart';
import 'package:minddy/ui/components/articles/articles_pages_controllers/articles_view_controller.dart';
import 'package:minddy/ui/components/projects/modules/notes/projects_modules_note_view_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

class ArticlesBottomMenuNotesViewController extends ChangeNotifier {
  late ArticlesViewController articleController;
}

class ArticlesBottomMenuNotesView extends StatefulWidget {
  const ArticlesBottomMenuNotesView({super.key, required this.articleController});

  final ArticlesViewController articleController;

  @override
  State<ArticlesBottomMenuNotesView> createState() => _ArticlesBottomMenuNotesViewState();
}

class _ArticlesBottomMenuNotesViewState extends State<ArticlesBottomMenuNotesView> {
  final ArticlesBottomMenuNotesViewController controller = ArticlesBottomMenuNotesViewController();
  final _ActualViewController viewController = _ActualViewController();

  @override
  void initState() {
    controller.articleController = widget.articleController;
    viewController.actualView = _CategoriesView(viewController, controller);
    initialize();
    super.initState();
  }

  initialize() {
    // Initialize logic if needed
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return ListView(
                children: [
                  AnimatedBuilder(
                    animation: viewController,
                    builder: (context, child) {
                      return viewController.actualView;
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ActualViewController extends ChangeNotifier {
  Widget actualView = Container();

  viewChanged() {
    notifyListeners();
  }
}

class _CategoriesView extends StatelessWidget {
  const _CategoriesView(this.viewController, this.articlesController);

  final _ActualViewController viewController;
  final ArticlesBottomMenuNotesViewController articlesController;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Widget>>(
      future: _buildArticlesNotesCategories(viewController, articlesController),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 2,
              crossAxisSpacing: 8,
            ),
            padding: const EdgeInsets.only(right: 12),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return SingleChildScrollView(child: snapshot.data![index]);
            },
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          );
        } else {
          return const Center(child: Text("No categories available."));
        }
      },
    );
  }
}

class _NotesView extends StatefulWidget {
  const _NotesView(this.notesList, this.viewController, this.controller);

  final List<NoteModel> notesList;
  final _ActualViewController viewController;
  final ArticlesBottomMenuNotesViewController controller;

  @override
  State<_NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<_NotesView> {
  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 40,
            width: double.infinity,
            child: IconButton(
              onPressed: () {
                widget.viewController.actualView = _CategoriesView(widget.viewController, widget.controller);
                widget.viewController.viewChanged();
              },
              tooltip: S.of(context).articles_go_back_semantic_text,
              style: ButtonThemes.secondaryButtonStyle(context),
              icon: Icon(Icons.arrow_back_rounded, color: theme.onPrimary),
            ),
          ),
          if (widget.notesList.isNotEmpty)
            ..._buildArticlesNotesElements(widget.notesList, () {
              setState(() {});
            }, theme, widget.controller)
          else 
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  S.of(context).projects_module_notes_category_note_count(0),
                  style: theme.titleMedium,
                ),
              ),
            )
        ],
      ),
    );
  }
}

Future<List<Widget>> _buildArticlesNotesCategories(
  _ActualViewController viewController,
  ArticlesBottomMenuNotesViewController articlesController,
) async {
  List<Widget> categoriesWidgets = [];
  List<ProjectNoteModuleCategoryModel> categoriesModels = await AppNotes.getCategories();

  bool isInAProject = StaticVariables.currentProjectInfo != null;

  ProjectsNotesModuleController notesController = ProjectsNotesModuleController(
    id: 0,
    projectPath: StaticVariables.currentProjectInfo != null ? StaticVariables.currentProjectInfo!.path : '',
  );

  if (isInAProject) {
    categoriesModels.insert(
      0,
      ProjectNoteModuleCategoryModel(
        title: S.current.projects_module_notes_project_notes_title,
        icon: Icons.chair_outlined,
        noteCount: await notesController.getProjectNotes().then((value) => value.length),
        isPrivate: false,
        categoryName: 'PROJECT',
      ),
    );
  }

  for (ProjectNoteModuleCategoryModel model in categoriesModels) {
    categoriesWidgets.add(
      ProjectNoteModuleCategoryCard(
        title: model.title,
        icon: model.icon,
        action: () async {
          viewController.actualView = _NotesView(
            model.categoryName == 'PROJECT'
                ? await notesController.getProjectNotes()
                : await AppNotes.getNotes(model.categoryName),
            viewController,
            articlesController,
          );
          viewController.viewChanged();
        },
        itemCount: model.noteCount,
        isManageable: false,
        categoryName: model.categoryName,
        onDelete: () {},
        isPrivate: model.isPrivate,
      ),
    );
  }

  return categoriesWidgets;
}

List<Widget> _buildArticlesNotesElements(
  List<NoteModel> notesList,
  Function onDelete,
  StylesGetters theme,
  ArticlesBottomMenuNotesViewController controller,
) {
  List<Widget> notesElements = [];
  for (NoteModel note in notesList) {
    notesElements.add(
      NoteWidget(
        noteModel: note,
        category: note.category,
        actionTooltip: S.current.articles_add_to_content,
        isDeletable: false,
        actionIcon: Icons.add_rounded,
        onDelete: () async {
          await onDelete();
        },
        action: () async {
          await _addElementsToArticle(note, controller);
        },
      ),
    );
  }
  return notesElements;
}

Future<void> _addElementsToArticle(NoteModel noteModel, ArticlesBottomMenuNotesViewController controller) async {
  for (NoteContentModel element in noteModel.content) {
    switch (element.type) {
      case NoteElementContentType.code:
        controller.articleController.addCodeElement(
          initialContent: element.data['code'],
          language: element.data['language'],
        );
        break;
      case NoteElementContentType.text:
        controller.articleController.addTextElement(initialText: element.data);
        break;
      case NoteElementContentType.image:
        controller.articleController.addImageElement(
          initialUrl: element.data['url'],
          initialDescription: element.data['description'],
        );
        break;
      case NoteElementContentType.list:
        controller.articleController.addListElement(initialContent: element.data);
        break;
    }
  }
}