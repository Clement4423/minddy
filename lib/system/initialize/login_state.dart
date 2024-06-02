import 'dart:async';
import 'package:flutter/material.dart';
import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/files/encryption.dart';
import 'package:minddy/system/files/secure_storage.dart';

class LoginState {
  @protected
  static bool _unlocked = false;
  
  static final StreamController<bool> _unlockedController = StreamController<bool>.broadcast();

  static bool get isUnlocked => _unlocked;

  static Stream<bool> get unlockedStream => _unlockedController.stream;

  static Future<bool?> tryUnlock(String hashedPassword) async {
    try {
      String? savedPassword = await SecuredStorage.read("minddy_password");
      if (savedPassword != null && hashedPassword == savedPassword) {
        bool isEncryptionInitialized = await AppEncrypter.initializeKeyEncrypter(hashedPassword);
        _unlocked = isEncryptionInitialized;
        _unlockedController.add(_unlocked);
        return isEncryptionInitialized;
      } else {
        return false;
      }
    } catch (e) {
      await AppLogs.writeError(e, "login_state.dart - tryUnlock");
      return null;
    }
  }

  static void dispose() {
    _unlockedController.close();
  }
}
