import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/interfaces/articles_element_interface.dart';
import 'package:minddy/ui/theme/theme.dart';

class CustomElementEditorEnvelop extends StatefulWidget {
  final IArticlesWriteElement child;
  final Function removeFunction;
  final double sideMenuIconOffsetOnYAxis;

  const CustomElementEditorEnvelop({
    required this.removeFunction,
    required this.sideMenuIconOffsetOnYAxis,
    required this.child,
    super.key
  });

  @override
  State<CustomElementEditorEnvelop> createState() => _CustomElementEditorEnvelopState();
}

class _CustomElementEditorEnvelopState extends State<CustomElementEditorEnvelop> {  
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
              child: GestureDetector(
              onTap: () {
                RenderBox renderBox = context.findRenderObject() as RenderBox;
                final offset = renderBox.localToGlobal(Offset.zero);
                const iconSize = 25.0;
                const menuHeight = 80.0;
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(
                    offset.dx, // left
                    offset.dy + menuHeight - iconSize, // top
                    offset.dx + renderBox.size.width, // right
                    offset.dy, // bottom
                  ),
                  color: theme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13)
                  ),
                  items: [
                    // Copy (Clipboard)
                    PopupMenuItem(
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
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).articles_copy_text,
                            style: theme.bodyMedium.copyWith(color: theme.onPrimary),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Icon(Icons.copy_outlined, color: theme.onPrimary),
                        ],
                      )
                    ),
                    // Delete element
                    PopupMenuItem(
                      onTap: () async {
                        await widget.removeFunction();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).snackbar_delete_button,
                            style: theme.bodyMedium.copyWith(color: theme.error),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Icon(Icons.delete_outline_rounded, color: theme.error),
                        ],
                      ),
                    )
                  ],
                );
              },
                child: Transform.translate(
                  offset: Offset(-5, widget.sideMenuIconOffsetOnYAxis),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Icon(
                      Icons.add_rounded,
                      color: theme.onPrimary,
                      size: 25
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: widget.child
            ),
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