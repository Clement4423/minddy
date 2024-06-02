import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/articles/app_articles.dart';
import 'package:minddy/system/files/app_images.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_bottom_menu/articles_notes/articles_bottom_menu_notes_view.dart';
import 'package:minddy/ui/theme/theme.dart';
import 'package:path/path.dart' as path;

class ArticlesNoteImageModel {
  String url;
  String description;

  ArticlesNoteImageModel({required this.url, required this.description});
}

class ArticlesNoteImageElement extends StatefulWidget {
  const ArticlesNoteImageElement({
    super.key, 
    required this.note, 
    required this.controller,
  });

  final ArticlesNoteImageModel note;
  final ArticlesBottomMenuNotesViewController controller;

  @override
  State<ArticlesNoteImageElement> createState() => ArticlesNoteImageElementState();
}

class ArticlesNoteImageElementState extends State<ArticlesNoteImageElement> {
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
                        await widget.controller.deleteNote({'url': widget.note.url});
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
                        String actualImagePath = await _getImagePath(widget.note.url);
                        String imageExtension = path.extension(actualImagePath);
                        String newImageName = "${AppArticles.createFileName(widget.note.url)}$imageExtension";
                        await AppImages.saveImage(actualImagePath, newImageName);
                        widget.controller.articleController.addImageElement(initialUrl: newImageName, initialDescription: widget.note.description);
                        _hasJustBeenCopied = true;
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
            decoration: BoxDecoration(
              color: theme.surface,
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
            ),
            child: TextSelectionTheme(
              data: TextSelectionThemeData(
                selectionColor: theme.brightness == Brightness.light ? Colors.white : theme.secondary,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                  future: AppImages.getImage(widget.note.url),
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
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Future<String> _getImagePath(String imageName) async {
  String documentDirectoryPath = await StaticVariables.fileSource.getAppDirectoryPath();
  return "$documentDirectoryPath/ressources/images/$imageName";
}