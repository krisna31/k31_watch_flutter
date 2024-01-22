import 'package:k31_watch_flutter/common/exception.dart';
import 'package:k31_watch_flutter/data/datasources/db/db_helper_tv_series.dart';
import 'package:k31_watch_flutter/data/models/table_tv_series.dart';

abstract class LocalDataTvSeriesSource {
  Future<String> insertWatchlist(TableTvSeries tv);
  Future<String> removeWatchlist(TableTvSeries tv);
  Future<TableTvSeries?> getTvById(int id);
  Future<List<TableTvSeries>> getWatchlistTv();
}

class LocalDataTvSourceImplementation implements LocalDataTvSeriesSource {
  final DbHelperTvSeries dbHelper;

  LocalDataTvSourceImplementation({required this.dbHelper});

  @override
  Future<String> insertWatchlist(TableTvSeries tv) async {
    try {
      await dbHelper.insertTvSeriesToWatchlist(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TableTvSeries tv) async {
    try {
      await dbHelper.removeTvSeriesFromWatchlist(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TableTvSeries?> getTvById(int id) async {
    final result = await dbHelper.getTvSeriesById(id);
    if (result != null) {
      return TableTvSeries.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TableTvSeries>> getWatchlistTv() async {
    final result = await dbHelper.getWatchlistTvSeries();
    return result.map((data) => TableTvSeries.fromMap(data)).toList();
  }
}
