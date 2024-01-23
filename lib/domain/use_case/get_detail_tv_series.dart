import 'package:k31_watch_flutter/common/failure.dart';
import 'package:k31_watch_flutter/domain/repositories/tv_series_repositories.dart';
import 'package:k31_watch_flutter/domain/entities/detail_tv_series.dart';

import 'package:dartz/dartz.dart';

class GetDetailTvSeries {
  GetDetailTvSeries(this.repository);
  Future<Either<Failure, DetailTvSeries>> execute(int id) {
    return repository.getDetailTvSeries(id);
  }

  final TvSeriesRepository repository;
}
