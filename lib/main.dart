import 'package:flutter/material.dart';
import 'package:short_news/screens/home_screen.dart';
import 'package:short_news/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(brightness: Brightness.dark),
      darkTheme: ThemeData.dark(),
      home: const ShortNewsApp(),
    );
  }
}

class ShortNewsApp extends StatelessWidget {
  const ShortNewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!true)
      return HomeScreen();
    else
      return LogInScreen();
  }
}
