import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:minddy/system/notifications/notification_handler.dart';
import 'package:minddy/ui/components/notifications/notification_widget.dart';

class SecuredStorage {
  static const _storage = FlutterSecureStorage();

  static Future<void> write(String key, dynamic value) async {
    await _storage.write(key: key, value: value);
  }

  static Future<void> deleteDataEncryptionKeys(BuildContext context) async {
    if (!kDebugMode) {
      return;
    }
    NotificationHandler.addNotification(
      NotificationModel(
        content: "This will delete all existing encryption keys. All the data encrypted with those will not work anymore.",
        action: () async {
          await _storage.delete(key: "minddy_encrypted_key");
          await _storage.delete(key: "minddy_encrypted_iv");
        }, 
        actionLabel: "I'm sure", 
        duration: NotificationDuration.untilClosed
      )
    );
  }

  static Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }
}