import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences sharedPreferences;
  static Future cacheInitialization() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  //set data
  static Future<bool> insertToCache(
      {required String key, required String value}) async {
    return await sharedPreferences.setString(key, value);
  }

  //get data
  static String getCacheData({required String key}) {
    return sharedPreferences.getString(key) ?? "";
  }

  // delete data

  static Future<bool> deleteCacheItem({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  //clear sharedPreferences
}
