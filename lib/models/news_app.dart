import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:short_news/models/themes.dart';

class NewsApp extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late ThemeMode _themeMode;

  ThemeMode get currentThemeMode => _themeMode;

  // sign in with google
  Future<void> googleSignIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      await _auth.signInWithCredential(authCredential);
    }
    notifyListeners();
  }

  // sign out from google
  void signOut() {
    _auth.signOut();
    notifyListeners();
  }

  Future<ThemeData> getTheme() async {
    ThemeData currentTheme;
    final pref = await SharedPreferences.getInstance();
    dynamic themeMode = pref.get('themeMode');
    currentTheme = themeMode == 'dark' ? Themes.darkTheme : Themes.lightTheme;
    _themeMode = themeMode == 'dark' ? ThemeMode.dark : ThemeMode.light;

    return currentTheme;
  }

  Future<void> setTheme(ThemeMode themeMode) async {
    final myTheme = ThemeMode.dark == themeMode ? 'dark' : 'light';
    final pref = await SharedPreferences.getInstance();

    pref.setString('themeMode', myTheme);
    _themeMode = themeMode;

    notifyListeners();
  }
}
