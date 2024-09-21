import 'dart:async';

class AppState {
  static StreamController<String> streamController = StreamController<String>();

  static void stateChanged() {
    String event = 'new';
    streamController.add(event);
  }
}