import 'package:k31_watch_flutter/common/failure.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:k31_watch_flutter/domain/repositories/tv_series_repositories.dart';

import 'package:dartz/dartz.dart';

class GetWatchlistTv {
  Future<Either<Failure, List<TvSeries>>> execute() {
    return _repository.getWatchlistTvSeries();
  }
  GetWatchlistTv(this._repository);
  final TvSeriesRepository _repository;
}
