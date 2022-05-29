import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// making a class for easy access of the flutter storage functions
class FlutterStorage {
  static const storage = FlutterSecureStorage();

  static Future readVal(String key) async {
    return await storage.read(key: key); // read the value of the key
  }

  static Future writeVal(String key, String value) async {
    return await storage.write(key: key, value: value); // write the value of the key
  }

  static Future deleteVal(String key) async {
    return await storage.delete(key: key); // delete the value of the key
  }

  static Future deleteAll() async {
    return await storage.deleteAll();  // delete all the values
  }

  static readAll() async {
    return await storage.readAll(); // read all the values
  }
}
