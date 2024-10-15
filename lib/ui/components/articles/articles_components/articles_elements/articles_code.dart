import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/interfaces/articles_element_interface.dart';
import 'package:minddy/system/model/code_languages_enum.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_elements/articles_element_envelop.dart';
import 'package:minddy/ui/theme/theme.dart';

class ArticlesCodeElementController {
  final String initialCode;
  final int initialLanguageIndex;
  late String code;
  late int languageIndex;

  ArticlesCodeElementController(this.initialCode, this.initialLanguageIndex) {
    code = initialCode;
    languageIndex = initialLanguageIndex;
  }
}

class ArticlesCodeElement extends StatefulWidget {
  ArticlesCodeElement({super.key, this.initialContent, required this.removeFunction, this.language, this.readOnly = false}) {
    controller = ArticlesCodeElementController(initialContent ?? "", language ?? 0);
  }

  final String? initialContent;
  final int? language;
  final Function(Key) removeFunction;
  late final ArticlesCodeElementController controller;

  final bool readOnly;

  @override
  State<ArticlesCodeElement> createState() => _ArticlesCodeElementState();
}

class _ArticlesCodeElementState extends State<ArticlesCodeElement> {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      child: ArticlesElementEnvelop(
        sideMenuIconOffsetOnYAxis: 5.5,
        removeFunction: widget.removeFunction, 
        keyToRemove: widget.key ?? UniqueKey(),
        readOnly: widget.readOnly, 
        child: _ArticleCodeElementContent(controller: widget.controller, readOnly: widget.readOnly),
        ),
    );
  }
}

class _ArticleCodeElementContent extends StatefulWidget implements IArticlesWriteElement {
  const _ArticleCodeElementContent({
    required this.controller,
    required this.readOnly
  });

  final ArticlesCodeElementController controller;

  final bool readOnly;

  @override
  State<_ArticleCodeElementContent> createState() => __ArticleCodeElementContentState();
  
  @override
  Map<String, dynamic> get data => {'code': controller.code, 'language': controller.languageIndex};
  
  @override
  set data(newData) => controller.code = newData;
}

class __ArticleCodeElementContentState extends State<_ArticleCodeElementContent> {

  late CodeLanguages selectedLanguage;

  @override
  void initState() {
    selectedLanguage = CodeLanguages.values[widget.controller.languageIndex];
    super.initState();
  }

  bool _hasJustBeenCopied = false;

  @override
  Widget build(BuildContext context) {
    StylesGetters theme = StylesGetters(context);
    double screenWidth =  MediaQuery.of(context).size.width;
    double maxWidth = screenWidth > 1000 ? screenWidth / 2.5 : screenWidth / 2;

    String firstLetter = selectedLanguage.name.substring(0, 1).toUpperCase();

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: maxWidth,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 68, 68, 68),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                    height: 38,
                    decoration: BoxDecoration(
                      color: theme.surface,
                      borderRadius: BorderRadius.circular(10)
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
                          widget.controller.languageIndex = selectedLanguage.index;                       
                        });
                      },
                      borderRadius: BorderRadius.circular(13),
                      icon: Icon(Icons.arrow_drop_down_rounded, color: theme.onSurface),
                      dropdownColor: theme.primary,
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
                        Clipboard.setData(ClipboardData(text: widget.controller.code));
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
            width: maxWidth,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 34, 34, 34),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
              child: TextSelectionTheme(
                data: TextSelectionThemeData(
                  selectionColor: theme.secondary.withOpacity(0.5)
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: 1200,
                    child: TextField(
                      onChanged: (value) {
                        widget.controller.code = value;
                      },
                      readOnly: widget.readOnly,
                      controller: TextEditingController(text: widget.controller.code),
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
      ),
    );
  }
}