import 'package:k31_watch_flutter/common/failure.dart';
import 'package:k31_watch_flutter/domain/entities/detail_tv_series.dart';
import 'package:k31_watch_flutter/domain/repositories/tv_series_repositories.dart';
import 'package:dartz/dartz.dart';

class RemoveWatchlistTv {
  Future<Either<Failure, String>> execute(DetailTvSeries tv) {
    return repository.removeWatchlistTv(tv);
  }
  final TvSeriesRepository repository;
  RemoveWatchlistTv(this.repository);
}
