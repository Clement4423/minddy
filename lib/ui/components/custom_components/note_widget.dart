import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/files/app_images.dart';
import 'package:minddy/system/model/note_model.dart';
import 'package:minddy/system/notes/app_notes.dart';
import 'package:minddy/ui/theme/theme.dart';

class NoteWidget extends StatefulWidget {
  const NoteWidget({
    super.key,
    required this.noteModel,
    required this.category,
    required this.action,
    required this.actionIcon,
    required this.actionTooltip,
    required this.onDelete,
    this.deleteMethod,
    this.isDeletable = true
  });

  final NoteModel noteModel;
  final String category;
  final Function action;
  final IconData actionIcon;
  final String actionTooltip;
  final bool isDeletable;
  final Function onDelete;
  final Function? deleteMethod;

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
                  widget.isDeletable 
                    ? MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () async {
                          widget.deleteMethod != null 
                          ? await widget.deleteMethod!()
                          : await AppNotes.deleteNote(widget.noteModel, widget.category);
                          if (context.mounted) {
                            await widget.onDelete();
                          }
                        },
                        child: Tooltip(
                          message: S.current.snackbar_delete_button,
                          child: Icon(Icons.delete_outline_rounded, color: theme.error)
                        ),
                      ),
                    )
                    : const SizedBox(),
                  // Note title
                  Text(
                    widget.noteModel.title.isEmpty 
                      ? S.of(context).articles_card_untitled 
                      : widget.noteModel.title.substring(0, widget.noteModel.title.length > 14 ? 14 : widget.noteModel.title.length),
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
                        message: widget.actionTooltip,
                        child: Icon(widget.actionIcon == Icons.add_rounded ? _hasJustBeenCopied ? Icons.check_rounded: Icons.add_rounded : widget.actionIcon, color: theme.onPrimary)
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
  int lengthLimit = content.length > 2 ? 2 : content.length;
  for (int i = 0; i < lengthLimit; i++) {
    switch (content[i].type) {
      case NoteElementContentType.code:
        Map dataAsMap = content[i].data as Map;
        contentWidgets.add(
          Align(
            alignment: Alignment.centerLeft, 
            child:Text(
              dataAsMap.entries.first.value as String, 
              style: theme.bodyMedium.
              copyWith(color: theme.onSurface),
              maxLines: 2,
            )
          )
        );
        break;
      case NoteElementContentType.image:
        contentWidgets.add(
          _getNoteImageBuilder(content[i].data['url'], theme)
        );
        break;
      case NoteElementContentType.text:
        contentWidgets.add(
          Align(
            alignment: Alignment.centerLeft, 
            child:Text(
              content[i].data as String, 
              style: theme.bodyMedium.
              copyWith(color: theme.onSurface),
              maxLines: 2,
            )
          )
        );
        break;
      case NoteElementContentType.list:
        contentWidgets.add(
          _buildNotesListElements(content[i].data, theme)
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
  int lengthLimit = textList.length > 2 ? 2 : textList.length;
  for (int i = 0; i < lengthLimit; i++) {
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