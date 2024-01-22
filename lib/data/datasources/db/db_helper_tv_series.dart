import 'dart:async';

import 'package:k31_watch_flutter/data/models/table_tv_series.dart';
import 'package:k31_watch_flutter/data/datasources/db/db_helper.dart';

class DbHelperTvSeries {
  final DbHelper dbHelper = DbHelper();
  static const String _tblWatchlist = 'watchlist_tv_series';

  Future<int> insertTvSeriesToWatchlist(TableTvSeries tv) async {
    final db = await dbHelper.database;
    return await db!.insert(_tblWatchlist, tv.toJson());
  }

  Future<int> removeTvSeriesFromWatchlist(TableTvSeries tv) async {
    final db = await dbHelper.database;
    return await db!.delete(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [tv.id],
    );
  }

  Future<Map<String, dynamic>?> getTvSeriesById(int id) async {
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

  Future<List<Map<String, dynamic>>> getWatchlistTvSeries() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlist);

    return results;
  }
}
