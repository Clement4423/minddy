  /// Creates a unique file name based on the provided title.
  int createUniqueId() {
    return DateTime.now().millisecondsSinceEpoch;
  }