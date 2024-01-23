import 'package:k31_watch_flutter/common/failure.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:k31_watch_flutter/domain/repositories/tv_series_repositories.dart';

class GetRecommendationsTvSeries {
  Future<Either<Failure, List<TvSeries>>> execute(id) {
    return repository.getRecommendationsTvSeries(id);
  }

  final TvSeriesRepository repository;
  GetRecommendationsTvSeries(this.repository);
}
