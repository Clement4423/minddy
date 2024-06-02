int calculateReadingTime(String text) {
  List<String> words = text.split(RegExp(r'\s+'));
  
  int totalWords = words.length;
  
  double readingTime = totalWords / 238;
  
  return readingTime.ceil();
}