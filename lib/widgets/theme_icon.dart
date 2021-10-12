import 'package:flutter/material.dart';

class ThemeIcon extends StatelessWidget {
  ThemeIcon({Key? key}) : super(key: key);
  ThemeMode currentTheme = ThemeMode.dark;
  @override
  Widget build(BuildContext context) {
    if (ThemeMode.dark == currentTheme) {
      return IconButton(onPressed: () {}, icon: const Icon(Icons.dark_mode));
    } else {
      return IconButton(onPressed: () {}, icon: const Icon(Icons.light_mode));
    }
  }
}
