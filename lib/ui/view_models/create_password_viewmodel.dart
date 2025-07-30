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
import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/files/app_config.dart';
import 'package:minddy/system/files/encryption.dart';
import 'package:minddy/system/files/secure_storage.dart';
import 'package:minddy/system/initialize/login_state.dart';
import 'package:minddy/system/router/app_router.dart';

class CreatePasswordViewModel extends ChangeNotifier {
  String _errorMessage = "";

  String get errorMessage => _errorMessage;

  void _setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  String password = "";
  String confirmedPassword = "";

  String _hashedPassword = "";
  String _hashedConfirmedPassword = "";

  final RegExp _passwordExpectation = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$');

  Future<bool> _savePassword() async {
    await SecuredStorage.write("minddy_password", _hashedPassword);
    if (await SecuredStorage.read("minddy_password") == _hashedPassword) {
      bool? isLoginInitialized = await LoginState.tryUnlock(_hashedPassword);
      if (isLoginInitialized == null) {
        return false;
      }
      if (isLoginInitialized) {
        bool isDataEncryptionKeyCreated = await AppEncrypter.createDataEncryptionKey();
        return isDataEncryptionKeyCreated;
      }
    } 
    return false;
  }

  void validatePassword() async {
    if (password.isEmpty || confirmedPassword.isEmpty) {
      _setErrorMessage(S.current.welcome_password_creation_error_must_provide);
      return;
    } else if (!_passwordExpectation.hasMatch(password)) {
      _setErrorMessage(S.current.welcome_password_creation_password_requirements);
      return;
    }

    _hashedPassword = await AppEncrypter.hashPassword(password);
    _hashedConfirmedPassword = await AppEncrypter.hashPassword(confirmedPassword);

    if (_hashedPassword != _hashedConfirmedPassword) {
      _setErrorMessage(S.current.welcome_password_creation_error_not_match);
      return;
    } else {
      _setErrorMessage("");
      bool isPasswordSaved = await _savePassword();
      if (!isPasswordSaved) {
        _setErrorMessage(S.current.welcome_password_creation_error_password_save);
        return;
      } else {
        AppConfig.data.isFirstAppStart = false;
        await AppConfig.saveConfig();
        AppRouter.router.navigateToAndReplace('/home'); // Welcome
      }
    }
  }
}