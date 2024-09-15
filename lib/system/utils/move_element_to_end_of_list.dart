  List<T> moveElementsToEndOfList<T>(List<T> list, List<T> elementsToMove) {
    // Remove the elements from the original list that need to be moved
    list.removeWhere((item) => elementsToMove.contains(item));

    // Add the elements to the end of the list
    list.addAll(elementsToMove);

    return list;
  }