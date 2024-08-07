import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_elements/articles_list.dart';
import 'package:minddy/ui/theme/theme.dart';

class ArticlesListElementModel {
  String text;
  final int index;
  final bool isNew;
  final FocusNode focusNode;


  ArticlesListElementModel({required this.text, required this.index, required this.isNew, required this.focusNode});
}

// ignore: must_be_immutable
class ArticlesListElementWidget extends StatefulWidget {
  ArticlesListElementWidget({
    super.key,
    required this.initialText,
    required this.controller,
    required this.maxWidth,
    required this.index,
    required this.focusNode, 
    required this.isNew,
  });

  final String initialText;
  final ArticlesListElementcontroller controller;
  final int index;
  final bool isNew;
  final double maxWidth;
  final FocusNode focusNode;

  String text = "";

  @override
  State<ArticlesListElementWidget> createState() => _ArticlesListElementWidgetState();
}

class _ArticlesListElementWidgetState extends State<ArticlesListElementWidget> {
  late TextEditingController _textEditingController;

  bool isRemoving = false;


  @override
  void initState() {
    super.initState();
    widget.text = widget.initialText;
    _textEditingController = TextEditingController(text: widget.initialText);
    FocusManager.instance.addLateKeyEventHandler((event) {
      try {
        if (event.logicalKey == LogicalKeyboardKey.backspace) {
          if (widget.text.isEmpty && widget.controller.content.length > 1 && isRemoving == false) {
            setState(() {
              isRemoving = true;
            });
            widget.controller.removeElementAtIndex(widget.index);
            return KeyEventResult.handled;
          }
        }
      return KeyEventResult.ignored;
     } catch(e) {
      return KeyEventResult.ignored;
     }
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    widget.focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        mainAxisAlignment: MainAxisAlignment.start,
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
          SizedBox(
            width: widget.maxWidth,
            child: CallbackShortcuts(
              bindings: {
                const SingleActivator(LogicalKeyboardKey.enter): () {
                  if (widget.text.isNotEmpty) {
                    widget.controller.modifyText(widget.text, widget.index);
                  }
                  widget.controller.addNewElement(
                    ArticlesListElementModel(
                      text: "", 
                      index: widget.controller.content.length, 
                      isNew: true,
                      focusNode: FocusNode()
                    ), 
                    widget.focusNode
                  );
                }
              },
              child: Focus(
                child: TextField(
                  onChanged: (value) {
                    widget.text = value;
                    widget.controller.modifyText(widget.text, widget.index);
                  },
                  focusNode: widget.focusNode,
                  controller: _textEditingController,
                  style: theme.bodyMedium.copyWith(color: theme.onPrimary),
                  onTap: () {
                    widget.controller.content.map((e) => {
                      if (e.index != widget.index) {
                        FocusScope.of(context).unfocus(),
                        e.focusNode.unfocus()
                      }
                    });
                  },
                  onTapOutside: (event) {
                    FocusScope.of(context).focusedChild?.unfocus();
                    widget.focusNode.unfocus();
                  },
                  cursorColor: theme.onPrimary,
                  autofocus: widget.isNew,
                  minLines: 1,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    hintText: S.of(context).articles_text_hint,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}