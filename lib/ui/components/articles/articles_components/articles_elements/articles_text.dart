import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/interface/articles_element_interface.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_elements/articles_element_envelop.dart';
import 'package:minddy/ui/theme/theme.dart';

class ArticlesTextElementController {
  final String initalContent;
  late String textContent;

  ArticlesTextElementController(this.initalContent) {
    textContent = initalContent;
  }
}

class ArticlesTextElement extends StatefulWidget {
  final String? initialContent;
  final Function(Key) removeFunction;
  late final ArticlesTextElementController controller;

  ArticlesTextElement({super.key, this.initialContent, required this.removeFunction}) {
    controller = ArticlesTextElementController(initialContent ?? "");
  }

  @override
  State<ArticlesTextElement> createState() => _ArticlesTextViewState();
}

class _ArticlesTextViewState extends State<ArticlesTextElement> {
  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 25),
      child: ArticlesElementEnvelop(
        sideMenuIconOffsetOnYAxis: 5.5,
        removeFunction: widget.removeFunction,
        keyToRemove: widget.key ?? UniqueKey(), 
        child: _ArticlesTextViewContent(theme: theme, controller: widget.controller),
        ),
    );
  }
}

class _ArticlesTextViewContent extends StatelessWidget implements IArticlesWriteElement {
  const _ArticlesTextViewContent({
    required this.theme,
    required this.controller,
  });

  @override
  dynamic get data => controller.textContent;

  @override
  set data(dynamic data) {}


  final StylesGetters theme;
  final ArticlesTextElementController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Align(
          alignment: Alignment.topLeft,
          child: TextField(
            onChanged: (value) {
              controller.textContent = value;
            },
            controller: TextEditingController(text: controller.textContent),
            style: theme.bodyMedium.copyWith(color: theme.onPrimary),
            cursorColor: theme.onPrimary,
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
    );
  }
}
