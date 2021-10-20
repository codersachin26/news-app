import 'package:flutter/material.dart';
import 'package:short_news/models/data_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DB {
  static Database? _dbConnection;
  static const String tableName = 'bookmark';

  // open database connection
  static Future openDbConnection() async {
    WidgetsFlutterBinding.ensureInitialized();
    final String dbpath = join(await getDatabasesPath() + "bookmark.db");
    final dbCon = await openDatabase(dbpath, onCreate: (db, virsion) {
      db.execute(
        'CREATE TABLE $tableName(id TEXT,title TEXT,source TEXT,content TEXT,imgURL TEXT, publshedAt TEXT)',
      );
    }, version: 1);

    DB._dbConnection = dbCon;
  }

// remove article from bookmark table
  static Future<void> removeArticle(String id) async {
    if (DB._dbConnection != null) {
      await DB._dbConnection?.delete(tableName, where: 'id=?', whereArgs: [id]);
    } else {
      await DB.openDbConnection();
      await DB._dbConnection?.delete(tableName, where: 'id=?', whereArgs: [id]);
    }
  }

// add article into bookmark table
  static Future<void> addArticle(Article article) async {
    final values = {
      'id': article.id,
      'title': article.title,
      'source': article.source,
      'content': article.content,
      'imgURL': article.imgURL,
      'publshedAt': article.publshedAt
    };
    if (DB._dbConnection != null) {
      await DB._dbConnection?.insert(tableName, values);
    } else {
      await DB.openDbConnection();
      await DB._dbConnection?.insert(tableName, values);
    }
  }

// fetch all articles from table
  static Future<List<Map<String, dynamic>>> getBookmarks() async {
    const sqlQuery = 'SELECT * FROM $tableName';
    List<Map<String, dynamic>> articles = [];
    if (DB._dbConnection != null) {
      final result = await DB._dbConnection?.rawQuery(sqlQuery);
      if (result != null) {
        articles = result;
      }
    } else {
      await DB.openDbConnection();
      final result = await DB._dbConnection?.rawQuery(sqlQuery);
      if (result != null) {
        articles = result;
      }
    }

    return articles;
  }
}
