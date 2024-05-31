import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

List<T> removeDuplicates<T>(List<T> list) {
  return list.toSet().toList();
}

Future<void> updateLoginStatus(bool status) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(MyApp.LOGIN_KEY, status);
}

Future<bool> checkLoginStatus() async {
  bool isLoggedIn = false;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getBool(MyApp.LOGIN_KEY) != null) {
    isLoggedIn = prefs.getBool(MyApp.LOGIN_KEY)!;
  }

  return isLoggedIn;
}