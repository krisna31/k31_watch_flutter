import 'package:dartz/dartz.dart';
import 'package:k31_watch_flutter/common/failure.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:k31_watch_flutter/domain/repositories/tv_series_repositories.dart';

class GetRecommendationsTvSeries {
  final TvSeriesRepository repository;

  GetRecommendationsTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(id) {
    return repository.getRecommendationsTvSeries(id);
  }
}
