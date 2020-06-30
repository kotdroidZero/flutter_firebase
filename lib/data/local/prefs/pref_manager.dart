import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PrefUtil {
  static remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static addString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? null;
  }

  static addObject(String key, Object value) async {
    var jsonString = jsonEncode(value);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonString);
  }

  static getObject(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key));
  }

  static setBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static getBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }
}
