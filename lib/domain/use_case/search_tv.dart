import 'package:dartz/dartz.dart';
import 'package:k31_watch_flutter/common/failure.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:k31_watch_flutter/domain/repositories/tv_series_repositories.dart';

class SearchTv {
  SearchTv(this.repository);
  final TvSeriesRepository repository;
  Future<Either<Failure, List<TvSeries>>> execute(String query) {
    return repository.searchTvSeries(query);
  }
}
