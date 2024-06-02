import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_bottom_menu/articles_notes/articles_bottom_menu_notes_view.dart';
import 'package:minddy/ui/theme/theme.dart';

class ArticlesNoteElement extends StatefulWidget {
  const ArticlesNoteElement({
    super.key,
    required this.note, 
    required this.controller,
    this.isCode = false,
    this.language = 0
  });

  final String note;
  final ArticlesBottomMenuNotesViewController controller;
  final bool isCode;
  final int language;

  @override
  State<ArticlesNoteElement> createState() => ArticlesNoteElementState();
}

class ArticlesNoteElementState extends State<ArticlesNoteElement> {
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
                        widget.isCode 
                        ? await widget.controller.deleteNote({'code': widget.note})
                        : await widget.controller.deleteNote(widget.note);
                        widget.controller.notesChanged();
                      },
                      child: Tooltip(
                        message: S.current.snackbar_delete_button,
                        child: Icon(Icons.delete_outline_rounded, color: theme.error)
                      ),
                    ),
                  ),
                  // Copy button
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () async {
                        widget.isCode 
                        ? widget.controller.articleController.addCodeElement(initialContent: widget.note, language: widget.language)
                        : widget.controller.articleController.addTextElement(initialText: widget.note);
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
              child: Text(
                widget.note,
                style: theme.bodyMedium.
                copyWith(color: theme.onSurface),
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ],
      ),
    );
  }
}