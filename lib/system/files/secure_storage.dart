import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:minddy/ui/components/snackbar/snackbar.dart';

class SecuredStorage {
  static const _storage = FlutterSecureStorage();

  static Future<void> write(String key, dynamic value) async {
    await _storage.write(key: key, value: value);
  }

  static Future<void> deleteDataEncryptionKeys(BuildContext context) async {
    if (!kDebugMode) {
      return;
    }
    showBottomSnackBar(context, 
      "This will delete all existing encryption keys. All the data encrypted with those will not work anymore.", 
      "I'm sure", 
      () async {
        await _storage.delete(key: "minddy_encrypted_key");
        await _storage.delete(key: "minddy_encrypted_iv");
      }, 
      30
    );
  }

  static Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }
}