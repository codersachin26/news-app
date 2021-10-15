import 'package:flutter/material.dart';

class Themes {
  static final darkTheme = ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.black,
      brightness: Brightness.dark,
      dividerColor: Colors.white);

  static final lightTheme = ThemeData(
      primarySwatch: Colors.deepPurple,
      primaryColor: Colors.deepPurple,
      brightness: Brightness.light,
      dividerColor: Colors.white);
}
