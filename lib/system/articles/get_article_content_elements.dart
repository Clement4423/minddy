import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/model/articles_elements.dart';

Future<List<ArticleElement>> getArticleContentElements(List<dynamic> content) async {
  List<ArticleElement> elements = [];

  for (dynamic elementData in content) {
    final type = elementData['type'] as String;
    final order = elementData['order'] as int;
    
    switch (type) {
      case 'text':
        elements.add(ArticleTextElement(order, elementData['content'] as String));
        break;
      case 'image':
        elements.add(ArticleImageElement(order, elementData['url'] as String, elementData['description'] as String));
        break;
      case 'list':
        elements.add(ArticleListElement(order, List<dynamic>.from(elementData['items'] as List)));
        break;
      case 'subtitle':
        elements.add(ArticleSubtitleElement(order, elementData["text"] as String));
      case 'code':
        elements.add(ArticleCodeElement(order, elementData['code'] as String, elementData['language'] as int));
      default:
        AppLogs.writeError("Incorrect type or corrupted file", "json_to_articles_elements.dart - convertJsonToArticlesElements");
        throw ArgumentError();
    }
  }

  return elements;
}
