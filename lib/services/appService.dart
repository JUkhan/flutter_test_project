import 'package:shared_preferences/shared_preferences.dart';

abstract class AppService {
  static void writeBySharedPref<T>(String key, T value) {
    SharedPreferences.getInstance().then((prefs) {
      if (value is int)
        prefs.setInt(key, value);
      else if (value is String)
        prefs.setString(key, value);
      else if (value is bool)
        prefs.setBool(key, value);
      else if (value is double) prefs.setDouble(key, value);
    });
  }

  static Future<T> readBySharedPref<T>(String key, T defaultValue) async {
    var prefs = await SharedPreferences.getInstance();
    if (defaultValue is int)
      return (prefs.getInt(key) ?? defaultValue) as T;
    else if (defaultValue is String)
      return (prefs.getString(key) ?? defaultValue) as T;
    else if (defaultValue is bool)
      return (prefs.getBool(key) ?? defaultValue) as T;
    else if (defaultValue is double)
      return (prefs.getDouble(key) ?? defaultValue) as T;
    return defaultValue;
  }
}
