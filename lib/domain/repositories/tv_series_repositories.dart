import 'package:dartz/dartz.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:k31_watch_flutter/domain/entities/detail_tv_series.dart';
import 'package:k31_watch_flutter/common/failure.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries();
  Future<Either<Failure, List<TvSeries>>> getNowPlayingTvSeries();
  Future<Either<Failure, DetailTvSeries>> getDetailTvSeries(int id);
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries();
  Future<Either<Failure, List<TvSeries>>> getRecommendationsTvSeries(int id);
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query);
  Future<Either<Failure, String>> removeWatchlistTv(DetailTvSeries tv);
  Future<Either<Failure, String>> saveWatchlistTv(DetailTvSeries tv);
  Future<Either<Failure, List<TvSeries>>> getWatchlistTvSeries();
  Future<bool> isAddedToWatchlistTv(int id);
}
