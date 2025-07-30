/*
 * minddy - Free project management
 * Copyright (C) 2025 mangué
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 */

import 'package:flutter/foundation.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/files/app_config.dart';
import 'package:minddy/system/files/secure_storage.dart';
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
    AppConfig.data.username = _username;
    return await AppConfig.saveConfig();
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

  goToPasswordPage() async {
    String? isPassowrdAlreadyExist = await SecuredStorage.read('minddy_password');
    if (kDebugMode) {
      isPassowrdAlreadyExist = null; // If in debug mode, null, for debuging
    }
    if (isPassowrdAlreadyExist != null) {
      AppRouter.router.navigateTo('/home');
      return;
    }
    AppRouter.router.navigateTo('/create_password');
  }
}