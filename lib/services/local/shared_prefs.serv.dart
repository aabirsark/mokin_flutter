import 'package:mokingbird_flutter/app/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences prefs;

  static setPrefs(newPrefs) {
    prefs = newPrefs;
  }

  // for auth info
  static saveAuthInfo(
      {required String username,
      required String name,
      required String jwt,
      required String refresh}) async {
    await prefs.setString(nameKey, name);
    await prefs.setString(usernameKey, username);
    await prefs.setString(jwtKey, jwt);
    await prefs.setString(refreshkey, refresh);
    await prefs.setBool(authenticatedkey, true);
  }
}
