import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/interfaces/articles_element_interface.dart';
import 'package:minddy/ui/components/articles/articles_pages_controllers/articles_view_controller.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_elements/articles_element_envelop.dart';
import 'package:minddy/ui/theme/theme.dart';

class ArticlesSubtitleElementController {
  final String initalText;
  late String textContent;

  ArticlesSubtitleElementController(this.initalText) {
    textContent = initalText;
  }
}

class ArticlesSubtitleElement extends StatefulWidget {
  final String? initialContent;
  final Function(Key) removeFunction;
  late final ArticlesSubtitleElementController controller;
  final ArticlesViewController articleController;

  final bool readOnly;

  ArticlesSubtitleElement({super.key, this.initialContent, required this.removeFunction, required this.articleController, this.readOnly = false}){
    controller = ArticlesSubtitleElementController(initialContent ?? "");
  }

  @override
  State<ArticlesSubtitleElement> createState() => _ArticlesSubtitleViewState();
}

class _ArticlesSubtitleViewState extends State<ArticlesSubtitleElement> {
  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: ArticlesElementEnvelop(
        sideMenuIconOffsetOnYAxis: 2.8,
        removeFunction: widget.removeFunction, 
        keyToRemove: widget.key ?? UniqueKey(),
        readOnly: widget.readOnly,
        child: _ArticlesSubtitleViewContent(
          theme: theme, 
          controller: widget.controller, 
          articleController: widget.articleController,
          readOnly: widget.readOnly,
        )
      ),
    );
  }
}

class _ArticlesSubtitleViewContent extends StatelessWidget implements IArticlesWriteElement {

  final bool readOnly;

  @override
  dynamic get data => controller.textContent;

  @override
  set data(dynamic data) {}

  const _ArticlesSubtitleViewContent({
    required this.theme,
    required this.controller, 
    required this.articleController,
    required this.readOnly
  });


  final StylesGetters theme;
  final ArticlesViewController articleController;
  final ArticlesSubtitleElementController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.enter):() {
            articleController.addTextElement();
          }
        },
        child: Focus(
          child: TextField(
            onChanged: (value) {
              controller.textContent = value;
            },
            readOnly: readOnly,
            controller: TextEditingController(text: controller.textContent),
            style: theme.titleLarge.copyWith(color: theme.onPrimary),
            cursorColor: theme.onPrimary,
            minLines: 1,
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: S.of(context).articles_subtitle_hint,
            ),
          ),
        ),
      ),
    );
  }
}
