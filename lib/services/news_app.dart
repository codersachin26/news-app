import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:short_news/models/data_model.dart';
import 'package:short_news/services/db.dart';
import 'package:short_news/services/news_api.dart';
import 'package:short_news/models/themes.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

// return current theme
  Future<ThemeData> getTheme() async {
    ThemeData currentTheme;
    final pref = await SharedPreferences.getInstance();
    dynamic themeMode = pref.get('themeMode');
    currentTheme = themeMode == 'dark' ? Themes.darkTheme : Themes.lightTheme;
    _themeMode = themeMode == 'dark' ? ThemeMode.dark : ThemeMode.light;

    return currentTheme;
  }

// set theme
  Future<void> setTheme(ThemeMode themeMode) async {
    final myTheme = ThemeMode.dark == themeMode ? 'dark' : 'light';
    final pref = await SharedPreferences.getInstance();

    pref.setString('themeMode', myTheme);
    _themeMode = themeMode;

    notifyListeners();
  }

  // bookmark article
  void bookmarkArticle(Article article, bool isbookmark) async {
    if (isbookmark) {
      await DB.removeArticle(article.id);
    } else {
      await DB.addArticle(article);
    }
  }

// fetch bookmark articles from db
  Future<List<Article>> getBookmarkArticle() async {
    final List<Article> articles = [];
    final result = await DB.getBookmarks();
    result.forEach((bookmarkArticle) {
      final article = Article(
        bookmarkArticle['id'],
        bookmarkArticle['title'],
        bookmarkArticle['source'],
        bookmarkArticle['content'],
        bookmarkArticle['imgURL'],
        bookmarkArticle['publshedAt'],
        true,
      );
      articles.add(article);
    });
    return articles;
  }

  // get news from NewsAPI
  Future<List<Article>> getNews() async {
    List<Article> articles = [];
    final jsonData = await NewsAPI.getData();
    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((jsonarticle) {
        if (jsonarticle['urlToImage'] != null &&
            jsonarticle['content'] != null) {
          Article article = Article(
              const Uuid().v1(),
              jsonarticle['title'],
              jsonarticle['source']['name'],
              jsonarticle["description"],
              jsonarticle['urlToImage'],
              jsonarticle['publishedAt']);
          ;
          articles.add(article);
        }
      });
    }
    return articles;
  }

// fetch notifications from firebase firestore
  Future<List<Article>> getNotification() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<Article> articles = [];
    final result = await firestore.collection('notifications').get();
    final docs = result.docs;
    docs.forEach((doc) {
      print(doc);
      final article = Article(
        const Uuid().v1(),
        doc['title'],
        doc['source'],
        doc["content"],
        doc['imgURL'],
        '',
      );
      articles.add(article);
    });
    return articles;
  }
}
