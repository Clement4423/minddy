import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/files/config.dart';
import 'package:minddy/ui/components/snackbar/snackbar.dart';

class AccountViewController extends ChangeNotifier {

  
  AccountViewController() {
    _getUsername().then((value) => {
      _username = value,
      notifyListeners(),
    });
  }
  resetSettings(context) {
    showBottomSnackBar(
      context,
      S.of(context).snackbar_reset_text, 
      S.of(context).snackbar_reset_button, 
      AppConfig.resetConfigFile,
      12,
      argument: context
    );
  }

  String _username = "";

  String get username => _username;

  void usernameChanged(String newUsername) {
    _username = newUsername;
    _saveUsername();
  }

  Future<bool> _saveUsername() async {
    final writtenUsername = await AppConfig.modifyConfigValue("username", _username);
    return writtenUsername;
  }

  Future<String> _getUsername() async {
    return await AppConfig.getConfigValue("username");
  }
}