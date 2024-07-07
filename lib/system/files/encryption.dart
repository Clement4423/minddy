import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:minddy/system/files/app_logs.dart';
import 'package:minddy/system/files/secure_storage.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/key_derivators/api.dart';
import 'package:pointycastle/key_derivators/pbkdf2.dart';
import 'package:pointycastle/macs/hmac.dart';

class AppEncrypter {
  static late encrypt.IV _keyIv;
  static late encrypt.Encrypter _keyEncrypter;

  static bool _isInitialized = false;

  static bool get isInitialized => _isInitialized;

  static Future<bool> initializeKeyEncrypter(String hashedPassword) async {
    try {
      bool generatedKeyEncrypter = await _generateKeyEncrypter(hashedPassword);
      if (generatedKeyEncrypter) {
        _isInitialized = true;
      }
      return generatedKeyEncrypter;
    } catch (e) {
      await _handleError(e);
      return false;
    }
  }

  static Future<String?> getSalt() async {
    try {
      String? salt = await SecuredStorage.read("minddy_salt");

      if (salt == null) {
        salt = _generateSalt();
        await SecuredStorage.write("minddy_salt", salt);
      }
      return salt;
    } catch (e) {
      await AppLogs.writeError(e, 'encryption.dart');
      return null;
    }
  }

  static Future<bool> _generateKeyEncrypter(String hashedPassword) async {
    try {
      final generator = PBKDF2KeyDerivator(HMac(SHA256Digest(), 64));

      String? salt = await getSalt();

      if (salt == null) {
        return false;
      }

      final params = Pbkdf2Parameters(utf8.encode(salt), 10000, 32);

      generator.init(params);

      final keyBytes = generator.process(utf8.encode(hashedPassword));
      final key = encrypt.Key(keyBytes);
      _keyEncrypter = encrypt.Encrypter(encrypt.AES(key));
      _keyIv = encrypt.IV.fromUtf8(hashedPassword.substring(0, 15));
      return true;
    } catch (e) {
      await _handleError(e);
      return false;
    }
  }

  static String _generateSalt([int length = 32]) {
    final rnd = Random.secure();
    final values = List<int>.generate(length, (i) => rnd.nextInt(256));
    return base64Url.encode(values);
  }

  /// Make sure that the encrytion has been initialized before doing this.
  /// 
  /// Can be done once, at the first start ever of the app.
  static Future<bool> createDataEncryptionKey() async {
    bool existingKey = await _isKeyExisting();
    if (existingKey) {
      return true;
    }
    try {
      final random = Random.secure();
      final dataKey = Uint8List.fromList(List.generate(32, (_) => random.nextInt(256)));
      final ivString = String.fromCharCodes(List.generate(8, (_) => random.nextInt(256)));
      final dataIv = encrypt.IV.fromUtf8(ivString);
      final key = encrypt.Key(dataKey);
      await _saveDataKey(key.base64);
      await _saveDataIv(dataIv.base64);
      return true;
    } catch (e) {
      await _handleError(e);
      return false;
    }
  }

  static Future<String?> _saveDataKey(final keyToSave) async {
    final encryptedKey = await _encryptKey(keyToSave);
    if (encryptedKey == null) {
      await _handleEncryptionError("An error occurred while encrypting the data key");
      return null;
    } else {
      await SecuredStorage.write("minddy_encrypted_key", encryptedKey);
      return encryptedKey;
    }
  }

  static Future<String?> _saveDataIv(final ivToSave) async {
    final encryptedIv = await _encryptKey(ivToSave);
    if (encryptedIv == null) {
      await _handleEncryptionError("An error occurred while encrypting the data iv");
      return null;
    } else {
      await SecuredStorage.write("minddy_encrypted_iv", encryptedIv);
      return encryptedIv;
    }
  }

  static Future<String?> _encryptKey(final keyToEncrypt) async {
    try {
      final encryptedKey = _keyEncrypter.encrypt(keyToEncrypt, iv: _keyIv);
      return encryptedKey.base64;
    } catch (e) {
      await _handleError(e);
      return null;
    }
  }

  static Future<String?> _decryptKey(final keyToDecrypt) async {
    try {
      final decryptedKey = _keyEncrypter.decrypt64(keyToDecrypt, iv: _keyIv);
      return decryptedKey;
    } catch (e) {
      await _handleError(e);
      return null;
    }
  }

  static Future<String?> decryptData(final dataToDecrypt) async {
    if (!_isInitialized) {
      return null;
    }
    final openedEncrypter = await _openDataEncrypter();
    final decryptedData = openedEncrypter!.encrypter.decrypt64(dataToDecrypt, iv: openedEncrypter.iv);
    return decryptedData;
  }

  static Future<String?> encryptData(final dataToEncrypt) async {
    if (!_isInitialized) {
      return null;
    }
    try{
      final openedEncrypter = await _openDataEncrypter();
      final encryptedData = openedEncrypter!.encrypter.encrypt(dataToEncrypt, iv: openedEncrypter.iv);
      return encryptedData.base64;
    } catch(e) {
      await _handleEncryptionError(e);
      return null;
    }
  }

  static Future<bool> _isKeyExisting() async {
    if (await SecuredStorage.read("minddy_encrypted_key") != null ||
        await SecuredStorage.read("minddy_encrypted_iv") != null) {
      return true;
    }
    return false;
  }

  static Future<EncrypterModel?> _openDataEncrypter() async {
    try {
      dynamic encryptedKey = await SecuredStorage.read("minddy_encrypted_key");
      dynamic encryptedIv = await SecuredStorage.read("minddy_encrypted_iv");

      final String? decryptedKey = await _decryptKey(encryptedKey);
      final String? decryptedIv = await _decryptKey(encryptedIv);

      if (decryptedKey != null && decryptedIv != null) {
        final key = encrypt.Key.fromBase64(decryptedKey);
        final iv = encrypt.IV.fromBase64(decryptedIv);
        final encrypter = encrypt.Encrypter(encrypt.AES(key));
        final encrypterModel = EncrypterModel(encrypter: encrypter, iv: iv);
        return encrypterModel;
      } else {
        return null;
      }
    } catch (e) {
      await _handleError(e);
      return null;
    }
  }

  static Future<void> _handleError(error) async {
    await AppLogs.writeError(error, "encryption.dart - _handleError");
  }

  static Future<void> _handleEncryptionError(error) async {
    await AppLogs.writeError(error, "encryption.dart - _handleEncryptionError");
  }
  

  static Future<String> hashPassword(String password) async {
    final salt = await getSalt();

    if (salt == null) {
      return '';
    }

    final saltedPassword = password + salt;
    final bytes = utf8.encode(saltedPassword);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}

class EncrypterModel {
  final encrypt.Encrypter encrypter;
  final encrypt.IV iv;

  EncrypterModel({required this.encrypter, required this.iv});
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   String data = "Hello, my name is clément and this is my encryption system !";
//   await initializeApp();
//   var encryptedData = await AppEncrypter.encryptData(data);
//   print(encryptedData);
//   var decryptedData = await AppEncrypter.decryptData(encryptedData);
//   print(decryptedData);
// }