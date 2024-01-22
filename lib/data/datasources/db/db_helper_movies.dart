import 'dart:async';

import 'package:k31_watch_flutter/data/datasources/db/db_helper.dart';
import 'package:k31_watch_flutter/data/models/movie_table.dart';

class DbHelperMovies {
  static const String _tblWatchlist = 'watchlist_movies';
  final DbHelper dbHelper = DbHelper();

  Future<int> insertMovieToWatchlist(MovieTable movie) async {
    final db = await dbHelper.database;
    return await db!.insert(_tblWatchlist, movie.toJson());
  }

  Future<int> removeMovieFromWatchlist(MovieTable movie) async {
    final db = await dbHelper.database;
    return await db!.delete(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await dbHelper.database;
    final results = await db!.query(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (!results.isNotEmpty) {
      return null;
    }

    return results.first;
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlist);

    return results;
  }
}
