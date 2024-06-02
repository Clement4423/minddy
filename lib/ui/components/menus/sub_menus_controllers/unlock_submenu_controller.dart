import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/files/config.dart';
import 'package:minddy/system/files/encryption.dart';
import 'package:minddy/system/files/secure_storage.dart';
import 'package:minddy/system/initialize/login_state.dart';
import 'package:minddy/ui/view_models/home_viewmodel.dart';

class UnlockSubMenuController extends ChangeNotifier {
  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  final Function? function;

  UnlockSubMenuController({this.function});

  String username = "";

  void _setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<String> setTitle() async {
    String gotUsername = await AppConfig.getConfigValue("username");
    username = gotUsername;
    String title = await HomeViewModel.getGreetingText(gotUsername);
    return title;
  }

  Future<String> getMnemonicSentence() async {
    String? mnemonicSentence = await SecuredStorage.read("minddy_mnemonic_sentence");
    if (mnemonicSentence != null) {
      return mnemonicSentence;
    } else {
      return "";
    }
  }

  Future<bool> checkPassword(String password) async {
    if (password.isEmpty) {
      _setErrorMessage(S.current.submenu_unlock_error_message_please_enter_password);
      return false;
    }

    String hashedPassword = AppEncrypter.hashPassword(password);
    bool? isUnlocled = await LoginState.tryUnlock(hashedPassword);

    if (isUnlocled == null) {
      _setErrorMessage(S.current.submenu_unlock_error_message_error_login);
      return false;
    }

    if (isUnlocled) {
      if (function != null) {
        await function!();
      }
      return true;
    } else {
      _setErrorMessage(S.current.submenu_unlock_error_message_incorrect_password);
      return false;
    }
  }
}