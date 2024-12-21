import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/interfaces/articles_element_interface.dart';
import 'package:minddy/system/model/code_languages_enum.dart';
import 'package:minddy/ui/theme/theme.dart';

// ignore: must_be_immutable
class CustomCodeDisplay extends StatefulWidget implements IArticlesWriteElement {
  CustomCodeDisplay({
    super.key,
    required this.initialCode,
    required this.initialLanguageIndex
  });

  final String initialCode;
  final int initialLanguageIndex;

  @override
  State<CustomCodeDisplay> createState() => _CustomCodeDisplay();
  
  @override
  var data = {};
}


class _CustomCodeDisplay extends State<CustomCodeDisplay> {


  late CodeLanguages selectedLanguage;

  @override
  void initState() {
    widget.data = {'code': widget.initialCode, 'language': widget.initialLanguageIndex};
    selectedLanguage = CodeLanguages.values[widget.initialLanguageIndex];
    super.initState();
  }

  bool _hasJustBeenCopied = false;

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);

    String firstLetter = selectedLanguage.name.substring(0, 1).toUpperCase();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 500,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 68, 68, 68),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  height: 38,
                  decoration: BoxDecoration(
                    color: theme.surface,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: DropdownButton(
                    hint: Text(
                      selectedLanguage == CodeLanguages.undefined 
                        ? S.of(context).articles_define_language
                        : "$firstLetter${selectedLanguage.name.substring(1)}",
                      style: theme.bodyMedium
                      .copyWith(color: theme.onSurface),
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        selectedLanguage = newValue ?? CodeLanguages.undefined;
                        widget.data['language'] = selectedLanguage.index;                      
                      });
                    },
                    dropdownColor: theme.primary,
                    borderRadius: BorderRadius.circular(13),
                    icon: Icon(Icons.arrow_drop_down_rounded, color: theme.onSurface),
                    underline: const SizedBox(),
                    items: CodeLanguages.values.map((lang) {
                      String langFirstLetter = lang.name.characters.first.toUpperCase();
                      return DropdownMenuItem<CodeLanguages>(
                        value: lang,
                        enabled: lang == CodeLanguages.undefined 
                          ? false
                          : true,
                        child: Text(
                          lang == CodeLanguages.undefined 
                            ? S.of(context).articles_define_language 
                            : "$langFirstLetter${lang.name.substring(1)}", 
                          style: lang == CodeLanguages.undefined 
                            ? theme.titleMedium.
                              copyWith(color: theme.onPrimary)
                            : theme.bodyMedium
                              .copyWith(color: theme.onPrimary)
                        ),
                      );
                    }).toList(), 
                  ),
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: widget.data['code']));
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
                      message: S.of(context).articles_copy_text,
                      child: Icon(_hasJustBeenCopied 
                      ? Icons.check_rounded
                      : Icons.content_copy_outlined, 
                      color: Colors.white
                    )
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          width: 500,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 34, 34, 34),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
            child: TextSelectionTheme(
              data: TextSelectionThemeData(
                selectionColor: theme.secondary.withValues(alpha: 0.5)
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: 1200,
                  child: TextField(
                    onChanged: (value) {
                      widget.data['code'] = value;
                    },
                    controller: TextEditingController(text: widget.data['code']),
                    style: theme.bodyMedium.copyWith(color: Colors.white, fontFamily: 'Menlo', fontSize: 15),
                    cursorColor: Colors.white,
                    minLines: 1,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      hintText: S.of(context).articles_code_hint,
                      hintStyle: theme.bodyMedium.copyWith(color: Colors.white70)
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
