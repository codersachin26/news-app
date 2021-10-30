import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:short_news/services/internet_connectivity.dart';
import 'package:short_news/services/news_app.dart';
import 'package:short_news/screens/home_screen.dart';
import 'package:short_news/screens/login_screen.dart';
import 'package:short_news/services/notification_handler.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    HttpOverrides.global = MyHttpoverrides();
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FirebaseCrashlytics.instance.log('app start');
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    FirebaseMessaging.onBackgroundMessage(onMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(onMessageForegroundHandler);
    runApp(MyApp());
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => NewsApp(),
        child:
            Consumer<NewsApp>(builder: (context, model, _) => ShortNewsApp()));
  }
}

class ShortNewsApp extends StatelessWidget {
  ShortNewsApp({Key? key}) : super(key: key);

  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    if (user != null) {
      return HomeScreen();
    } else {
      return LogInScreen();
    }
  }
}
