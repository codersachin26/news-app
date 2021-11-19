// run on Android device
// CMD : flutter run test/unit_test.dart

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:short_news/models/data_model.dart';
import 'package:short_news/services/auth.dart';
import 'package:short_news/services/db.dart';
import 'package:short_news/services/internet_connectivity.dart';
import 'package:short_news/services/news_api.dart';
import 'package:short_news/services/news_app.dart';

main() {
  group('testing Database functions -->', () {
    test('DB.hasConnection -- return null', () {
      expect(DB.hasConnection(), equals(false));
    });

    test('DB.openDbConnection() -- initialize Database connection instance',
        () async {
      final r = await DB.openDbConnection();
      expect(r, isTrue);
      expect(DB.hasConnection(), equals(true));
    });

    test('DB.addArticle() -- add dummy article', () async {
      final newArticle = Article(
          'testing_id', 'title', 'source', 'content', 'imgURL', 'publshedAt');
      final result = await DB.addArticle(newArticle);
      expect(result, greaterThan(0));
    });

    test('DB.getBookmarks() - return list of article', () async {
      final bookmarks = await DB.getBookmarks();
      expect(bookmarks, isA<List>());
      expect(bookmarks.isNotEmpty, equals(true));
    });

    test('DB.removeArticle()', () async {
      final result = await DB.removeArticle('testing_id');
      expect(result, greaterThan(0));
    });

    test('DB.getBookmarks() - return empty list', () async {
      final bookmarks = await DB.getBookmarks();
      expect(bookmarks, isA<List>());
      expect(bookmarks.isNotEmpty, equals(false));
    });
  });

  group('checking hasInternetConnection() function --> ', () {
    test('testing with data ON internet connection', () async {
      final r = await hasInternetConnection();
      expect(r, equals(true));
    });
  });

  group('testing NewsAPI service class', () {
    test('getNews() method -- return json object', () async {
      final jsonData = await NewsAPI.getData();
      expect(jsonData['status'], equals('ok'));
    });
  });

  group('testing NewsApp methods -->', () {
    late NewsAppNotifier model;
    setUp(() async {
      await Firebase.initializeApp();
      final pref = await SharedPreferences.getInstance();
      model = NewsAppNotifier(OAuth(), pref);
      pref.clear();
    });

    test('getTheme() -- return current theme(light)', () async {
      final currentThemeData = await model.getTheme();
      expect(currentThemeData, isA<ThemeData>());
      expect(model.currentThemeMode, equals(ThemeMode.light));
    });

    test('setTheme() -- set dark theme', () async {
      await model.setTheme(ThemeMode.dark);
      expect(model.currentThemeMode, equals(ThemeMode.dark));
    });

    test('bookmarkArticke() -- adding a article', () async {
      final article = Article(
          'testing_id', 'title', 'source', 'content', 'imgURL', 'publshedAt');
      final r = await model.bookmarkArticle(article, false);
      expect(r, equals(1));
    });

    test('bookmarkArticke() -- removing a article', () async {
      final article = Article(
          'testing_id', 'title', 'source', 'content', 'imgURL', 'publshedAt');
      final r = await model.bookmarkArticle(article, true);
      expect(r, equals(1));
    });

    test('getBookmarkArticle() -- return empty list of Article', () async {
      final r = await model.getBookmarkArticle();
      expect(r, isA<List>());
      expect(r.isEmpty, equals(true));
    });

    test('bookmarkArticke() -- add a article', () async {
      final article = Article(
          'testing_id', 'title', 'source', 'content', 'imgURL', 'publshedAt');
      final r = await model.bookmarkArticle(article, false);
      expect(r, equals(1));
    });

    test('getBookmarkArticle() -- return non-empty list of Article', () async {
      final r = await model.getBookmarkArticle();
      expect(r, isA<List>());
      expect(r.isEmpty, equals(false));
      expect(r[0].id, equals('testing_id'));
    });

    test('getNews()', () async {
      final news = await model.getNews();
      expect(news, isA<List>());
      expect(news.isNotEmpty, equals(true));
    });

    test(
        'getNotification() -- return non-empty list of article from firestore service',
        () async {
      final r = await model.getNotification();
      expect(r, isA<List>());
      expect(r.isEmpty, equals(false));
      expect(r[0].title, equals('flutter 2.5'));
    });
  });
}
