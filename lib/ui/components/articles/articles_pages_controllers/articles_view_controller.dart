import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/articles/app_articles.dart';
import 'package:minddy/system/articles/calculate_reading_time.dart';
import 'package:minddy/system/articles/get_article_content_elements.dart';
import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/initialize/static_variables.dart';
import 'package:minddy/system/model/article_info.dart';
import 'package:minddy/system/model/articles_elements.dart';
import 'package:minddy/system/notifications/notification_handler.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_elements/articles_code.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_elements/articles_text.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_elements/articles_image.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_elements/articles_list.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_elements/articles_subtitle.dart';
import 'package:minddy/ui/components/articles/articles_pages_controllers/articles_saving_controller.dart';
import 'package:minddy/ui/components/notifications/notification_widget.dart';

class ArticlesViewController extends ChangeNotifier {
  final ArticleInfo articleInfos;
  final Function resetFunction;
  final List<ArticleElement>? initialContent;
  final bool readOnly;
  List<Widget> articleContent = [];
  List<ArticleElement>? articleElements;

  double contentWidth = 600;

  String articleTitle = "";
  String articleReadingTime = "0";
  List<dynamic> articleSources = [];

  late SavingController savingController;

  ArticlesViewController(this.articleInfos, this.resetFunction, {this.initialContent, this.readOnly = false}) {
    articleTitle = articleInfos.title;
    articleReadingTime = articleInfos.readingTime;
    try {
      if (initialContent == null) {
        AppArticles.getProperty("sources", articleInfos.path).then((value) => articleSources = value ?? []);
      }
    } catch(e) {
      articleSources = [];
    }
  }

  Future<bool> initialize(BuildContext context) async {
    if (initialContent != null) {
      articleElements = initialContent;
      sortElementsByOrder(articleElements!);
      _setContentMaxSize(context);
      _buildArticleContent(context);
      return true;
    }
    Map<String, dynamic>? fileContent = await StaticVariables.fileSource.readJsonFile(articleInfos.path);
    if (fileContent != null) {
      articleElements = await getArticleContentElements(fileContent["content"]);
      if (articleElements!.isNotEmpty && context.mounted) {
        sortElementsByOrder(articleElements!);
        _setContentMaxSize(context);
        _buildArticleContent(context);
      } else {
        if (context.mounted) {
          _setContentMaxSize(context);
        }
        _initializeFirstArticleContent();
      }
      return true;
    } else {
      if (context.mounted) {
        NotificationHandler.addNotification(
          NotificationModel(
            content: S.of(context).articles_corrupted_file,
            action: null, 
            actionLabel: S.of(context).snackbar_close_button, 
            duration: NotificationDuration.long
          )
        );
      }
      return false;
    }
  }

  List<ArticleElement> sortElementsByOrder(List<ArticleElement> elements) {
    elements.sort((a, b) => a.order.compareTo(b.order));
    return elements;
  }

  void _setContentMaxSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 1000) {
      contentWidth = screenWidth / 2.5;
    } else {
      contentWidth = screenWidth / 2;
    }
  }


  void sizeChanged(BuildContext context) async {
    _setContentMaxSize(context);
  }

  Future<void> _buildArticleContent(BuildContext context) async {
    try {
      if (articleElements != null) {
        for (ArticleElement element in articleElements!) {
          articleContent.add(_buildElement(element, context));
        }
        notifyListeners();
      } else {
        NotificationHandler.addNotification(
          NotificationModel(
            content: S.current.articles_impossible_to_load_content,
            action: null, 
            actionLabel: S.current.snackbar_close_button, 
            duration: NotificationDuration.long
          )
        );
        Navigator.pop(context);
      }
    } catch(e) {
      await AppLogs.writeError(e, "articles_write_view_controller.dart - _buildArticleContent");
    }
  }

  Widget _buildElement(ArticleElement element, BuildContext context) {
    if (element.type == 'text') {
      return ArticlesTextElement(
        initialContent: element.data as String, 
        removeFunction: removeElementFromKey,
        readOnly: readOnly,
        key: UniqueKey()
      );
    } else if (element.type == 'image') {
      var imageData = element.data as Map<String, dynamic>;
      return ArticlesImageElement(
        initialUrl: imageData["url"], 
        initialDescription: imageData["description"], 
        removeFunction: removeElementFromKey,
        readOnly: readOnly,
        key: UniqueKey(),
      );
    } else if (element.type == 'list') {
      return ArticlesListElement(
        initialContent: element.data, 
        removeFunction: removeElementFromKey,
        readOnly: readOnly,
        key: UniqueKey()
      );
    } else if (element.type == "subtitle") {
      return ArticlesSubtitleElement(
        initialContent: element.data, 
        articleController: this,
        removeFunction: removeElementFromKey,
        readOnly: readOnly,
        key: UniqueKey()
      );
    } else if (element.type == 'code') {
      var codeData = element.data as Map<String, dynamic>;
      return ArticlesCodeElement(
        initialContent: codeData['code'],
        language: codeData['language'],
        removeFunction: removeElementFromKey,
        readOnly: readOnly,
        key: UniqueKey(), 
      );
    }
    
    return const SizedBox();
  }

  Future<bool> saveArticle({bool isClosingArticle = false}) async {
    if (readOnly) {
      return true;
    }
    List<ArticleElement> articleElementsList = _getArticleElementFromArticleContent();
    bool isArticleContentEmpty = isArticleEmpty();
    if (isArticleContentEmpty && isClosingArticle) {
      bool removedFile = await StaticVariables.fileSource.removeFile(articleInfos.path);
      return removedFile;
    }
    bool isArticleSaved = await AppArticles.rewriteArticle(
      fileRelativePath: articleInfos.path,
      title: articleTitle,
      readingTime: articleReadingTime,
      content: articleElementsList,
      sources: articleSources
    );
    savingController.startSaving();
    return isArticleSaved;
  }

  bool isArticleEmpty() {
    String allArticleText = _getAllArticleText();
    allArticleText = allArticleText.replaceAll(RegExp(r' '), "");
    bool? isThereAnImage; 
    for (var element in articleContent) {
      if (element is ArticlesImageElement) {
        isThereAnImage = true;
        break;
      }
    }
    isThereAnImage ??= false; // If null, equals false
    if (allArticleText.isEmpty && !isThereAnImage) {
      return true;
    } else {
      return false;
    }
  }

  List<ArticleElement> _getArticleElementFromArticleContent() {
    List<ArticleElement> articleElementsList = [];
    for (int index = 0; index < articleContent.length; index++) {
      Widget child = articleContent[index];
      if (child is ArticlesTextElement) {
        articleElementsList.add(ArticleTextElement(index, child.controller.textContent));
      } else if (child is ArticlesSubtitleElement) {
        articleElementsList.add(ArticleSubtitleElement(index, child.controller.textContent));
      } else if (child is ArticlesImageElement) {
        articleElementsList.add(ArticleImageElement(index, child.controller.imageUrl, child.controller.description));
      } else if (child is ArticlesListElement) {
        articleElementsList.add(ArticleListElement(index, child.controller.stringContent));
      } else if (child is ArticlesCodeElement) {
        articleElementsList.add(ArticleCodeElement(index, child.controller.code, child.controller.languageIndex));
      }
    }
    return articleElementsList;
  }

  void removeElementFromKey(Key keyToRemove) {
    final removedWidget = articleContent.firstWhere((widget) => widget.key == keyToRemove);
    if (removedWidget is ArticlesImageElement) {
      StaticVariables.fileSource.removeFile("ressources/images/${removedWidget.controller.imageUrl}");
    }
    articleContent.remove(removedWidget);
    orderChanged();
  }

  void orderChanged() {
    notifyListeners();
    saveArticle();
  }

  void calculateArticleReadingTime() {
    String totalArticleText = _getAllArticleText();
    if (totalArticleText.length < 238) {
      articleReadingTime = "0";
      saveArticle();
      return;
    }
    articleReadingTime = calculateReadingTime(totalArticleText).toString();
    saveArticle();
  }

 String _getAllArticleText() {
  String totalText = "";
  for (Widget element in articleContent) {
    if (element is ArticlesTextElement) {
        totalText += "${element.controller.textContent} ";
    }
    if (element is ArticlesSubtitleElement) {
        totalText += "${element.controller.textContent} ";
    }
    if (element is ArticlesListElement) {
      totalText += "${element.controller.stringContent.join(" ")} ";
    }
    if (element is ArticlesCodeElement) {
      totalText += "${element.controller.code} ";
    }
    if (element is ArticlesImageElement) {
      totalText += "${element.controller.description} ";
    }
  }
  return totalText;
 }
  
  void _initializeFirstArticleContent() {
    articleContent.add(ArticlesTextElement(removeFunction: removeElementFromKey, key: UniqueKey()));
  } 

  void articleTitleChanged(dynamic newTitle) {
    articleTitle = newTitle;
  }

  void addTextElement({String? initialText}) async {
    articleContent.add(ArticlesTextElement(
      removeFunction: removeElementFromKey, 
      initialContent: initialText, 
      key: UniqueKey()
    ));
    await saveArticle();
    notifyListeners();
  }

  void addSubtitleElement({String? initialText}) async {
    articleContent.add(ArticlesSubtitleElement(
      removeFunction: removeElementFromKey, 
      articleController: this,
      initialContent: initialText, 
      key: UniqueKey()
    ));
    await saveArticle();
    notifyListeners();
  }

  void addImageElement({String? initialUrl, String? initialDescription}) async {
    articleContent.add(ArticlesImageElement(
      removeFunction: removeElementFromKey, 
      initialUrl: initialUrl, 
      initialDescription: initialDescription, 
      key: UniqueKey()
    ));
    await saveArticle();
    notifyListeners();
  }

  void addListElement({List? initialContent}) async {
    articleContent.add(ArticlesListElement(
      removeFunction: removeElementFromKey, 
      initialContent: initialContent, 
      key: UniqueKey()
    ));
    await saveArticle();
    notifyListeners();
  }

  void addCodeElement({String? initialContent, int? language}) async {
    articleContent.add(
      ArticlesCodeElement(
        removeFunction: removeElementFromKey,
        initialContent: initialContent,
        language: language,
        key: UniqueKey(),
      )
    );
    await saveArticle();
    notifyListeners();
  }
}

