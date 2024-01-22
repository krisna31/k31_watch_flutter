import 'package:dartz/dartz.dart';
import 'package:k31_watch_flutter/common/failure.dart';
import 'package:k31_watch_flutter/domain/entities/detail_tv_series.dart';
// import 'package:k31_watch_flutter/domain/entities/movie_detail.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeries>>> getNowPlayingTvSeries();
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries();
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries();
  Future<Either<Failure, DetailTvSeries>> getDetailTvSeries(int id);
  Future<Either<Failure, List<TvSeries>>> getRecommendationsTvSeries(int id);
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query);
  // Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query);
  // Future<Either<Failure, String>> saveWatchlist(MovieDetail movie);
  // Future<Either<Failure, String>> removeWatchlist(MovieDetail movie);
  // Future<bool> isAddedToWatchlist(int id);
  // Future<Either<Failure, List<TvSeries>>> getWatchlistTvSeries();
}
