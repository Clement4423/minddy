import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/utils/create_unique_id.dart';
import 'package:minddy/system/model/note_model.dart';
import 'package:minddy/system/notes/app_notes.dart';
import 'package:minddy/system/interfaces/articles_element_interface.dart';
import 'package:minddy/ui/components/custom_components/custom_selection_menu.dart';
import 'package:minddy/ui/theme/theme.dart';

class ArticlesElementEnvelop extends StatefulWidget {
  final IArticlesWriteElement child;
  final Function removeFunction;
  final Key keyToRemove;
  final double sideMenuIconOffsetOnYAxis;
  final bool readOnly;

  const ArticlesElementEnvelop({
    required this.child,
    required this.removeFunction,
    required this.keyToRemove,
    required this.sideMenuIconOffsetOnYAxis,
    required this.readOnly,
    super.key
  });

  @override
  State<ArticlesElementEnvelop> createState() => _ArticlesElementEnvelopState();
}

class _ArticlesElementEnvelopState extends State<ArticlesElementEnvelop> {  
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: SizedBox(
        width: MediaQuery.of(context).size.width > 1000 
          ? MediaQuery.of(context).size.width / 2.5 
          : MediaQuery.of(context).size.width / 2,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            AnimatedOpacity(
              opacity: _hovering ? 1.0 : 0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.linear,
              child: Transform.translate(
                offset: Offset(0, widget.sideMenuIconOffsetOnYAxis),
                child: CustomSelectionMenu(
                  theme: theme, 
                  buttonStyle: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                    overlayColor: WidgetStatePropertyAll(Colors.transparent)
                  ),
                  items: [
                    // Copy (Clipboard)
                    CustomSelectionMenuItem(
                      label: S.of(context).articles_copy_text, 
                      icon: Icons.copy_rounded, 
                      onTap: () {
                        if (widget.child.data is String) {
                          Clipboard.setData(ClipboardData(text: widget.child.data));
                        } else if (widget.child.data is List) {
                          Clipboard.setData(ClipboardData(text: _formatListInText(widget.child.data)));
                        } else if (widget.child.data is Map) {
                          final Map data = widget.child.data as Map;
                          if (data.keys.contains('decription')) {
                            Clipboard.setData(ClipboardData(text: data['description']));
                          } else if (data.keys.contains('code')) {
                            Clipboard.setData(ClipboardData(text: data['code']));
                          }
                        }
                      }
                    ),
                    // Copy (Notes)
                    CustomSelectionMenuItem(
                      label: S.of(context).articles_copy_to_notes_text, 
                      icon: Icons.notes_rounded, 
                      onTap: () async {
                        await AppNotes.addNote(
                          NoteModel(
                            title: '',
                            id: createUniqueId(),
                            category: 'for_later', 
                            lastModified: AppNotes.getCurrentTime(),
                            content: [
                              AppNotes.createNoteContentMap(widget.child.data)
                              ]
                            ),
                            "for_later"
                          );
                      },
                    ),
                    // Delete
                    if (!widget.readOnly)
                      CustomSelectionMenuItem(
                        label: S.of(context).snackbar_delete_button, 
                        icon: Icons.delete_outline_rounded,
                        foregroundColor: theme.error, 
                        onTap: () async {
                          await widget.removeFunction(widget.keyToRemove);
                        },
                      ),
                  ], 
                  type: CustomSelectionMenuButttonType.icon,
                  child: Icon(
                    Icons.add_rounded,
                    color: theme.onPrimary,
                    size: 25
                  ),
                ),
              ),
            ),
            widget.child,
          ],
        ),
      ),
    );
  }
}


String _formatListInText(List<dynamic> list) {
  String finalText = "";
  for (String text in list) {
    finalText += "- $text\n";
  }
  return finalText;
}