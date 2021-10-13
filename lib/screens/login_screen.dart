import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:short_news/widgets/sign_in_container.dart';
import 'package:short_news/widgets/welcome_text.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({Key? key}) : super(key: key);
  Future _initialize = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialize,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const MaterialApp(home: LogInScreenView());
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class LogInScreenView extends StatelessWidget {
  const LogInScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('background-img.jpg'))),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  WelcomeText(),
                  SizedBox(
                    height: 230,
                  ),
                  SignInConatiner(),
                  Align(
                      alignment: Alignment.center,
                      child: Text('login to continue',
                          style: TextStyle(fontSize: 18)))
                ]),
          ),
        ),
      ),
    );
  }
}
