import 'package:flutter/material.dart';

class Themes {
  static final darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
  );

  static final lightTheme = ThemeData(
    primarySwatch: Colors.deepPurple,
    primaryColor: Colors.white,
    brightness: Brightness.light,
  );
}
