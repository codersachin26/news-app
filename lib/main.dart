import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:short_news/models/news_app.dart';
import 'package:short_news/screens/home_screen.dart';
import 'package:short_news/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewsApp(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(brightness: Brightness.dark),
        darkTheme: ThemeData.dark(),
        home: Consumer<NewsApp>(
            builder: (context, model, _) => FutureBuilder(
                future: _initialization,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print("error");
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    return HomeScreen();
                  } else {
                    return Container();
                  }
                })),
      ),
    );
  }
}

class ShortNewsApp extends StatelessWidget {
  ShortNewsApp({Key? key}) : super(key: key);

  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    if (user != null) {
      return const HomeScreen();
    } else {
      return const LogInScreen();
    }
  }
}
