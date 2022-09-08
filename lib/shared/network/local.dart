import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static Future<SharedPreferences> initial() async {
    return sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<dynamic> saveData({
    required String? key,
    required dynamic value,
  }) {
    if (value is String) {
      return sharedPreferences!.setString(key!, value);
    } else if (value is bool) {
      return sharedPreferences!.setBool(key!, value);
    } else if (value is double) {
      return sharedPreferences!.setDouble(key!, value);
    } else
      return sharedPreferences!.setInt(key!, value);
  }

  static dynamic getData({
    required String? key,
  }) {
    return sharedPreferences!.get(key!);
  }

  static Future<dynamic> removeData({
    required String? key,
  }) async {
    return await sharedPreferences!.remove(key!);
  }
}
