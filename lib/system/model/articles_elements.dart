abstract class ArticleElement {
  final String type;
  final dynamic data;
  
  int order;
  
  ArticleElement(this.type, this.data, this.order);
}

class ArticleTextElement extends ArticleElement {
  ArticleTextElement(int order, String content) : super('text', content, order);
}

class ArticleSubtitleElement extends ArticleElement {
  ArticleSubtitleElement(int order, String text) : super('subtitle', text, order);
}

class ArticleImageElement extends ArticleElement {
  ArticleImageElement(int order, String url, String description) : super('image', {'url': url, 'description': description}, order);
}

class ArticleListElement extends ArticleElement {
  ArticleListElement(int order, List<dynamic> items) : super('list', items, order);
}

class ArticleCodeElement extends ArticleElement {
  ArticleCodeElement(int order, String code, int languageIndex) : super('code', {'code': code, 'language': languageIndex}, order);
}