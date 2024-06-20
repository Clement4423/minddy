import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/model/note_model.dart';
import 'package:minddy/system/notes/app_notes.dart';
import 'package:minddy/ui/components/custom_components/note_widget.dart';
import 'package:minddy/ui/components/articles/articles_pages_controllers/articles_view_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

class ArticlesBottomMenuNotesViewController extends ChangeNotifier {

  List<NoteModel> notesList = [];

  late ArticlesViewController articleController;

  
  Future<List<NoteModel>> getNotes() async {
    return await AppNotes.getNotes("for_later");
  }

  deleteNote(NoteModel note) async {
    await AppNotes.deleteNote(note, "for_later");
  }

  notesChanged() async {
    await getNotes().then((value) {
      notesList = value;
      notifyListeners();
    });
  }
}

class ArticlesBottomMenuNotesView extends StatefulWidget {
  const ArticlesBottomMenuNotesView({super.key, required this.articleController});

  final ArticlesViewController articleController;

  @override
  State<ArticlesBottomMenuNotesView> createState() => _ArticlesBottomMenuNotesViewState();
}

class _ArticlesBottomMenuNotesViewState extends State<ArticlesBottomMenuNotesView> {
  final ArticlesBottomMenuNotesViewController controller = ArticlesBottomMenuNotesViewController();

  @override
  void initState() {
    controller.articleController = widget.articleController;
    initialize();
    super.initState();
  }

  initialize() {
    controller.getNotes().then((value) => setState(() {
      controller.notesList = value;
    }));
  }

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
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
                  if (controller.notesList.isEmpty) 
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                        decoration: BoxDecoration(
                          color: theme.surface,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.layers_clear_rounded, color: theme.onPrimary, size: 60),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                S.of(context).articles_no_notes(S.of(context).articles_copy_to_notes_text),
                                style: theme.bodyMedium.copyWith(color: theme.onPrimary),
                              ),
                            )
                          ],
                        ),
                      ),
                    ) 
                  else 
                  ..._buildArticlesNotesElements(controller.notesList, theme, controller),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}


List<Widget> _buildArticlesNotesElements(List<NoteModel> notesList, StylesGetters theme, ArticlesBottomMenuNotesViewController controller) {
  List<Widget> notesElements = [];
  for (NoteModel note in notesList) {
    notesElements.add(
      NoteWidget(
        noteModel: note, 
        category: note.category,
        actionTooltip: S.current.articles_add_to_content,
        actionIcon: Icons.add_rounded,
        onDelete: () async {
          await controller.notesChanged();
        },
        action: () async {
          await _addElementsToArticle(note, controller);
        }
      )
    );
  }
  return notesElements;
}

Future<void> _addElementsToArticle(NoteModel noteModel, ArticlesBottomMenuNotesViewController controller) async {
  for (NoteContentModel element in noteModel.content) {
    switch (element.type) {
      case NoteElementContentType.code:
        controller.articleController.addCodeElement(initialContent: element.data['code'], language: element.data['language']);
        break;
      case NoteElementContentType.text:
        controller.articleController.addTextElement(initialText: element.data);
        break;
      case NoteElementContentType.image:
        controller.articleController.addImageElement(initialUrl: element.data['url'], initialDescription: element.data['description']);
        break;
      case NoteElementContentType.list:
        controller.articleController.addListElement(initialContent: element.data);
        break;
    }
  }
}


