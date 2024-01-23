import 'package:k31_watch_flutter/data/models/movie_table.dart';
import 'package:k31_watch_flutter/data/datasources/db/db_helper_movies.dart';
import 'package:k31_watch_flutter/common/database_exception.dart';

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  MovieLocalDataSourceImpl({required this.dbHelper});


  final DbHelperMovies dbHelper;

  @override
  Future<String> removeWatchlist(MovieTable movie) async {
    try {
      // from db helper remove tv series from watchlist
      await dbHelper.removeMovieFromWatchlist(movie);

      // return 'Removed from Tv Series Watchlist'
      return 'Removed from Watchlist Movies';
    } catch (e) {
      throw DatabaseException(e.toString());

    }
  }

  @override
  Future<List<MovieTable>> getWatchlistMovies() async {
    // from db helper get watchlist tv series
    final result = await dbHelper.getWatchlistMovies();

    // return result after mapping
    return result.map((data) => MovieTable.fromMap(data)).toList();
  }

  @override
  Future<MovieTable?> getMovieById(int id) async {
    // from db helper get tv series by id
    final result = await dbHelper.getMovieById(id);

    // if result is null return null
    if (result == null) {
      return null;
    } 

    // otherwise return TableTvSeries.fromMap(result)
    return MovieTable.fromMap(result);
  }

  @override
  Future<String> insertWatchlist(MovieTable movie) async {
    try {
      // from db helper insert tv series to watchlist
      await dbHelper.insertMovieToWatchlist(movie);

      // return 'Added to Tv Series Watchlist'
      return 'Added to Watchlist Movies';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}

abstract class MovieLocalDataSource {
  Future<String> insertWatchlist(MovieTable movie);
  Future<String> removeWatchlist(MovieTable movie);
  Future<MovieTable?> getMovieById(int id);
  Future<List<MovieTable>> getWatchlistMovies();
}
