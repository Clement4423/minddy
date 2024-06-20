import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/interface/articles_element_interface.dart';
import 'package:minddy/ui/theme/theme.dart';

// ignore: must_be_immutable
class CustomTextArea extends StatelessWidget implements IArticlesWriteElement{
  CustomTextArea({
    super.key, 
    required this.initialText,
  });

  final String initialText;

  @override
  var data = "";

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    data = initialText;
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Align(
        alignment: Alignment.topLeft,
        child: TextField(
          onChanged: (value) {
            data = value;
          },
          controller: TextEditingController(text: initialText),
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
    );
  }
}
