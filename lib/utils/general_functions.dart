import 'package:flutter/material.dart';

TextStyle getBoldStyle() {
  return TextStyle(
    fontFamily: "Raleway",
    fontWeight: FontWeight.w700,
  );
}

TextStyle getItalicStyle() {
  return TextStyle(
    fontFamily: "Raleway",
    fontWeight: FontWeight.w300,
  );
}

TextStyle getRegularStyle() {
  return TextStyle(
    fontFamily: "Raleway",
  );
}

ThemeData darkTheme() {
  return ThemeData(
      primarySwatch: Colors.green,
      brightness: Brightness.dark,
      accentColor: Colors.red);
}

ThemeData lightTheme() {
  return ThemeData(
      primarySwatch: Colors.green,
      brightness: Brightness.light,
      accentColor: Colors.red);
}

bool isValidEmail(String email) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(email);
}
