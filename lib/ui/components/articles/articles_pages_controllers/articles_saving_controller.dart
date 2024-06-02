import 'package:flutter/material.dart';

class SavingController extends ChangeNotifier {
  bool isSaving = false;

  startSaving() {
    isSaving = true;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 500), () {
      stopSaving();
    });
  }

  stopSaving() {
    isSaving = false;
    notifyListeners();
  }
}
