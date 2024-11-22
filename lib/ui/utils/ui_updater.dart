import 'package:flutter/foundation.dart';

class UiUpdater extends ChangeNotifier {
  void update() {
    notifyListeners();
  }
}