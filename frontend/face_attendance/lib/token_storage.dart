import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const storage = FlutterSecureStorage();

  static Future readToken(String key) async {
    return await storage.read(key: key);
  }

  static Future writeToken(String key, String value) async {
    return await storage.write(key: key, value: value);
  }

  static Future deleteToken(String key) async {
    return await storage.delete(key: key);
  }
}
