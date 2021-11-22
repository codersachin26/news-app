import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:short_news/models/data_model.dart';
import 'package:short_news/models/enum.dart';
import 'package:short_news/services/auth.dart';
import 'package:short_news/services/db.dart';
import 'package:short_news/services/news_api.dart';
import 'package:short_news/models/themes.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewsAppNotifier extends ChangeNotifier {
  final OAuth _oAuth;
  final SharedPreferences _sharedPreferences;
  late ThemeMode _themeMode;
  final List<Article> _notifications = [];

  NewsAppNotifier(this._oAuth, this._sharedPreferences);

  ThemeMode get currentThemeMode => _themeMode;

  // sign in with OAuthType
  Future<void> signInWith(OAuthType oAuthType) async {
    if (oAuthType == OAuthType.google) {
      await _oAuth.googleSignIn();
      notifyListeners();
    }
  }

  // sign out
  void signOut() async {
    await _oAuth.signOut();
    notifyListeners();
  }

// return current theme
  Future<ThemeData> getTheme() async {
    ThemeData currentTheme;
    dynamic themeMode = _sharedPreferences.get('themeMode');
    currentTheme = themeMode == 'dark' ? Themes.darkTheme : Themes.lightTheme;
    _themeMode = themeMode == 'dark' ? ThemeMode.dark : ThemeMode.light;

    return currentTheme;
  }

// set theme
  Future<void> setTheme(ThemeMode themeMode) async {
    final myTheme = ThemeMode.dark == themeMode ? 'dark' : 'light';

    _sharedPreferences.setString('themeMode', myTheme);
    _themeMode = themeMode;

    notifyListeners();
  }

  // bookmark article
  Future<int> bookmarkArticle(Article article, bool isbookmark) async {
    try {
      if (isbookmark) {
        await DB.removeArticle(article.id);
      } else {
        await DB.addArticle(article);
      }
      return 1;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return 0;
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
      jsonData["articles"].forEach((jsonArticle) {
        if (jsonArticle['urlToImage'] != null &&
            jsonArticle['content'] != null) {
          Article article = Article(
              const Uuid().v1(),
              jsonArticle['title'],
              jsonArticle['source']['name'],
              jsonArticle["description"],
              jsonArticle['urlToImage'],
              jsonArticle['publishedAt']);

          articles.add(article);
        }
      });
    }

    return articles;
  }

// fetch notifications from firebase firestore
  Future<List<Article>> getNotification() async {
    if (_notifications.isNotEmpty) {
      return _notifications;
    } else {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      final result = await firestore.collection('notifications').get();
      final notifications = result.docs;

      notifications.forEach((notification) {
        final article = Article(
          notification.id,
          notification['title'],
          notification['source'],
          notification["content"],
          notification['imgURL'],
          notification['publshedAt'],
        );
        _notifications.add(article);
      });
      return _notifications;
    }
  }
}
