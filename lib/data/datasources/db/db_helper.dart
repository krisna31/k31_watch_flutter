// ignore_for_file: avoid_print

import 'dart:async';

import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper? _databaseHelper;
  DbHelper._instance() {
    _databaseHelper = this;
  }

  factory DbHelper() => _databaseHelper ?? DbHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblWatchlistTv = 'watchlist_tv_series';
  static const String _tblWatchlistMovie = 'watchlist_movies';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    print('Creating tables...');
    try {
      await db.execute('''
      CREATE TABLE  $_tblWatchlistMovie (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');

      await db.execute('''
      CREATE TABLE  $_tblWatchlistTv (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
    } catch (e) {
      print(e);
    } finally {
      print('Tables created!');
    }
  }
}
