import 'package:minddy/system/model/articles_elements.dart';

List<Map<String, dynamic>> getDartMapsFromArticlesElements(List<ArticleElement> articlesElementList) {
  List<Map<String, dynamic>> dartMaps = [];

  for (var element in articlesElementList) {
    Map<String, dynamic> map = {
      'type': element.type,
      'order': element.order,
    };

    switch (element.type) {
      case 'text':
        map['content'] = (element as ArticleTextElement).data;
        break;
      case 'image':
        var data = (element as ArticleImageElement).data;
        map['url'] = data['url'];
        map['description'] = data['description'];
        break;
      case 'list':
        map['items'] = (element as ArticleListElement).data;
        break;
      case 'subtitle':
        map['text'] = (element as ArticleSubtitleElement).data;
        break;
      case 'code':
        var data = (element as ArticleCodeElement).data;
        map['code'] = data['code'];
        map['language'] = data['language'];
      default:
        throw ArgumentError('Invalid article element type: ${element.type}');
    }

    dartMaps.add(map);
  }

  return dartMaps;
}
