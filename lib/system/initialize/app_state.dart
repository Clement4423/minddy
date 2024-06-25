import 'dart:async';

class AppState {
  static StreamController<void> streamController = StreamController();

  static void stateChanged() {
    void event = '';
    streamController.add(event);
  }
}