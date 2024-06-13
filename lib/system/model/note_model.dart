class NoteModel {
  String title;
  String category;
  int id;
  List<NoteContentModel> content;

  NoteModel({required this.title, required this.id, required this.category, required this.content}); 
}

class NoteContentModel {
  NoteElementContentType type;
  dynamic data;

  NoteContentModel({required this.type, required this.data});
}

enum NoteElementContentType {
  text,
  image,
  list,
  code
}