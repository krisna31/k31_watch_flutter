import 'package:k31_watch_flutter/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:k31_watch_flutter/domain/entities/detail_tv_series.dart';
import 'package:k31_watch_flutter/domain/repositories/tv_series_repositories.dart';

class SaveWatchlistTv {
  Future<Either<Failure, String>> execute(DetailTvSeries tv) {
    return repository.saveWatchlistTv(tv);
  }
  SaveWatchlistTv(this.repository);
  final TvSeriesRepository repository;
}
