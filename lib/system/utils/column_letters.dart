String getColumnLetter(int columnIndex) {
  String letter = lettersList.first;
  if (columnIndex <= 26) {
    letter = lettersList[columnIndex];
  } else {
    letter = '${lettersList[columnIndex ~/ columnIndex]}${lettersList[26 - columnIndex]}';
  }
  return letter;
}

int getColumnIndex(String letter) {  
  if (letter.isEmpty || !RegExp(r'^[A-Z]+$').hasMatch(letter)) {
    return -1;
  }
  
  int columnIndex = 0;
  for (int i = 0; i < letter.length; i++) {
    int letterIndex = lettersList.indexOf(letter[i]) + 1;
    if (letterIndex == 0) {
      throw ArgumentError('Invalid letter: ${letter[i]}');
    }
    columnIndex = columnIndex * 26 + letterIndex;
  }
  
  return columnIndex;
}

const List<String> lettersList = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];


