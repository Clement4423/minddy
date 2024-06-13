import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/files/app_images.dart';
import 'package:minddy/system/model/note_model.dart';
import 'package:minddy/system/notes/notes.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_bottom_menu/articles_notes/articles_bottom_menu_notes_view.dart';
import 'package:minddy/ui/theme/theme.dart';

class NoteWidget extends StatefulWidget {
  const NoteWidget({
    super.key,
    required this.noteModel,
    required this.controller,
    required this.category,
    required this.action
  });

  final NoteModel noteModel;
  final String category;
  final ArticlesBottomMenuNotesViewController controller;
  final Function action;

  @override
  State<NoteWidget> createState() => NoteWidgetState();
}

class NoteWidgetState extends State<NoteWidget> {
  bool _hasJustBeenCopied = false;

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Container(
      margin: const EdgeInsets.only(right: 12, top: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.primary,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
            ),
            child: SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Delete button
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () async {
                        await AppNotes.deleteNote(widget.noteModel, widget.category);
                        widget.controller.notesChanged();
                      },
                      child: Tooltip(
                        message: S.current.snackbar_delete_button,
                        child: Icon(Icons.delete_outline_rounded, color: theme.error)
                      ),
                    ),
                  ),
                  // Note title
                  Text(
                    widget.noteModel.title.substring(0, widget.noteModel.title.length > 14 ? 14 : widget.noteModel.title.length),
                    style: theme.titleMedium.copyWith(color: theme.onPrimary, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Action button
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () async {
                        await widget.action();
                        setState(() {
                          _hasJustBeenCopied = true;            
                        });
                        Future.delayed(const Duration(milliseconds: 1500), () {
                          if (context.mounted) {
                            setState(() {
                              _hasJustBeenCopied = false;
                            });
                          }
                        });
                      },
                      child: Tooltip(
                        message: S.current.articles_add_to_content,
                        child: Icon(_hasJustBeenCopied ? Icons.check_rounded: Icons.add_rounded, color: theme.onPrimary)
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.surface,
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ..._buildNoteContent(widget.noteModel.content, theme)
                ],
              )
            ),
          )
        ],
      ),
    );
  }
}

List<Widget> _buildNoteContent(List<NoteContentModel> content, StylesGetters theme) {
  List<Widget> contentWidgets = [];
  for (NoteContentModel model in content) {
    switch (model.type) {
      case NoteElementContentType.code:
        contentWidgets.add(
          Text(model.data as String, style: theme.bodyMedium.copyWith(color: theme.onSurface))
        );
        break;
      case NoteElementContentType.image:
        _getNoteImageBuilder(model.data['url'], theme);
        break;
      case NoteElementContentType.text:
        contentWidgets.add(
          Text(model.data as String, style: theme.bodyMedium.copyWith(color: theme.onSurface))
        );
        break;
      case NoteElementContentType.list:
        contentWidgets.add(
          _buildNotesListElements(model.data, theme)
        );
        break;
    }

  }
  return contentWidgets;
}

FutureBuilder _getNoteImageBuilder(String imageUrl, StylesGetters theme) {
  return FutureBuilder(
    future: AppImages.getImage(imageUrl),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Container(
          constraints: const BoxConstraints(maxWidth: 330),
          height: 220,
          color: theme.primaryContainer,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (snapshot.hasError) {
        return Container(
          constraints: const BoxConstraints(maxWidth: 330),
          height: 220,
          color: Colors.red,
          child: const Center(
            child: Text('Failed to load image'),
          ),
        );
      } else {
        return ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 330),
            child: snapshot.data
            ??Center(
              child: Container(
                width: 330,
                height: 220,
                color: theme.primaryContainer,
                child: Center(
                  child: Icon(Icons.error_outline_rounded, color: theme.onPrimary)
                ),
              ),
            ),
          ),
        );
      }
    },
  );
}

Widget _buildNotesListElements(List textList, StylesGetters theme) {
  List<Widget> notesListElementsList = [];
  for (int i = 0; i < textList.length; i++) {
    notesListElementsList.add(
      Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: 3,
                height: 3,
                decoration: BoxDecoration(
                    color: theme.onPrimary,
                    borderRadius: BorderRadius.circular(2)),
              ),
            ),
          ),          
          Expanded(
            child: Text(
              textList[i],
              style: theme.bodyMedium.
              copyWith(color: theme.onSurface),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
  return SingleChildScrollView(
    child: Column(
      children: notesListElementsList,
    ),
  );
}