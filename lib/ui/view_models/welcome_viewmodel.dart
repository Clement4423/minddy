import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/files/app_config.dart';
import 'package:minddy/system/router/app_router.dart';

class WelcomeViewModel extends ChangeNotifier {
  String _username = "";
  String _errorMessage = "";

  String get username => _username;
  String get errorMessage => _errorMessage;

  void usernameChanged(String newUsername) {
    _username = newUsername;
  }

  _setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<bool> validateUsername() async {
    if (_username.replaceAll(' ', '').isEmpty) {
      _setErrorMessage(S.current.welcome_should_provide);
      return false;
    }
    if (_username.length > 25) {
      _setErrorMessage(S.current.welcome_first_name_too_long);
      return false;
    }
    if (_username != "") {
      _username = _username.trim();
     bool savedUsername = await _saveUsername();
     if (!savedUsername) {
      _setErrorMessage(S.current.welcome_error_save_username);
      return false;
     }
    goToPasswordPage();
     notifyListeners();
     return true;
    } else {
      _setErrorMessage(S.current.welcome_should_provide);
      return false;
    }
  }

  Future<bool> _saveUsername() async {
    final writtenUsername = await AppConfig.modifyConfigValue("username", _username);
    return writtenUsername;
  }

  Future<bool> skipUsername() async {
    _username = S.current.welcome_pass_default_username;
    bool isDefaultUsernameSaved = await _saveUsername();
    if (isDefaultUsernameSaved) {
      goToPasswordPage();
      return true;
    } else {
      _setErrorMessage(S.current.welcome_error_save_username);
      return false;
    }
  }

  goToPasswordPage() {
    AppRouter.router.navigateTo('/create_password');
  }
}