import 'package:k31_watch_flutter/common/database_exception.dart';
import 'package:k31_watch_flutter/data/datasources/db/db_helper_tv_series.dart';
import 'package:k31_watch_flutter/data/models/table_tv_series.dart';

class LocalDataTvSourceImplementation implements LocalDataTvSeriesSource {
  LocalDataTvSourceImplementation({required this.dbHelper});

  final DbHelperTvSeries dbHelper;

  @override
  Future<String> removeWatchlist(TableTvSeries tv) async {
    try {
      // from db helper remove tv series from watchlist
      await dbHelper.removeTvSeriesFromWatchlist(tv);

      // return 'Removed from Tv Series Watchlist'
      return 'Removed from Tv Series Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> insertWatchlist(TableTvSeries tv) async {
    try {
      // from db helper insert tv series to watchlist
      await dbHelper.insertTvSeriesToWatchlist(tv);

      // return 'Added to Tv Series Watchlist'
      return 'Added to Tv Series Watchlist';
    } catch (e) {

      throw DatabaseException(e.toString());
    }
  }



  @override
  Future<List<TableTvSeries>> getWatchlistTv() async {
    // from db helper get watchlist tv series
    final result = await dbHelper.getWatchlistTvSeries();

    // return result after map
    return result.map((data) => TableTvSeries.fromMap(data)).toList();
  }

  
  @override
  Future<TableTvSeries?> getTvById(int id) async {
    // from db helper get tv series by id
    final result = await dbHelper.getTvSeriesById(id);

    // if result is null return null
    if (result == null) {
      return null;
    }

    // otherwise return TableTvSeries.fromMap(result)
    return TableTvSeries.fromMap(result);
  }
}

// Local Data Tv Series Source Abstraction
abstract class LocalDataTvSeriesSource {
  Future<String> insertWatchlist(TableTvSeries tv);
  Future<String> removeWatchlist(TableTvSeries tv);
  Future<TableTvSeries?> getTvById(int id);
  Future<List<TableTvSeries>> getWatchlistTv();
}
