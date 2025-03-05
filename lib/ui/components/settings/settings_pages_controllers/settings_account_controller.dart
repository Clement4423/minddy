import 'package:flutter/material.dart';
import 'package:minddy/generated/l10n.dart';
import 'package:minddy/system/files/app_config.dart';
import 'package:minddy/system/notifications/notification_handler.dart';
import 'package:minddy/ui/components/notifications/notification_widget.dart';

class AccountViewController extends ChangeNotifier {

  
  AccountViewController() {_username = AppConfig.data.username;}


  resetSettings(context) {
    NotificationHandler.addNotification(
      NotificationModel(
        content: S.of(context).snackbar_reset_text,
        action: () {
          AppConfig.resetConfig(context);
        }, 
        actionLabel: S.of(context).snackbar_reset_text, 
        duration: NotificationDuration.long
      )
    );
  }

  String _username = "";

  String get username => _username;

  void usernameChanged(String newUsername) async {
    if (newUsername.isEmpty) {
      newUsername = S.current.welcome_pass_default_username;
    }
    _username = newUsername;
  }

  Future<bool> saveUsername() async {
    AppConfig.data.username = _username;
    return await AppConfig.saveConfig();
  }
}