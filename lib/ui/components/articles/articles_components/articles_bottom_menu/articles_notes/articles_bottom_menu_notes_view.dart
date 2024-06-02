import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/articles/articles_notes.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_bottom_menu/articles_notes/articles_note_element.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_bottom_menu/articles_notes/articles_note_image_element.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_bottom_menu/articles_notes/articles_note_list_element.dart';
import 'package:minddy/ui/components/articles/articles_pages_controllers/articles_view_controller.dart';
import 'package:minddy/ui/theme/theme.dart';

// Tout séparer dans différents fichiers

class ArticlesBottomMenuNotesViewController extends ChangeNotifier {

  List<dynamic> notesList = [];

  late ArticlesViewController articleController;

  
  Future<List> getNotes() async {
    return await AppArticlesNotes.getNotes();
  }

  deleteNote(dynamic note) async {
    await AppArticlesNotes.deleteNote(note);
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

List<Widget> _buildArticlesNotesElements(List<dynamic> notesList, StylesGetters theme, ArticlesBottomMenuNotesViewController controller) {
  List<Widget> notesElements = [];
  for (dynamic note in notesList) {
    if (note is String) {
      notesElements.add(
        ArticlesNoteElement(note: note, controller: controller)
      );
    } else if (note is Map) {
      if (note.keys.contains('code')) {
        notesElements.add(
          ArticlesNoteElement(note: note['code'], isCode: true, language: note['language'], controller: controller)
        );
      } else {
        ArticlesNoteImageModel noteModel = ArticlesNoteImageModel(url: note['url'], description: note['description']);
        notesElements.add(
          ArticlesNoteImageElement(note: noteModel, controller: controller)
        );
      }
    } else if (note is List) {
      notesElements.add(
        ArticlesNoteListElement(note: note, controller: controller)
      );
    }

  }
  return notesElements;
}



