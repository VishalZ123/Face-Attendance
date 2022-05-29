import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterStorage {
  static const storage = FlutterSecureStorage();

  static Future readVal(String key) async {
    return await storage.read(key: key);
  }

  static Future writeVal(String key, String value) async {
    return await storage.write(key: key, value: value);
  }

  static Future deleteVal(String key) async {
    return await storage.delete(key: key);
  }

  static Future deleteAll() async {
    return await storage.deleteAll();
  }

  static readAll() async {
    return await storage.readAll();
  }
}
