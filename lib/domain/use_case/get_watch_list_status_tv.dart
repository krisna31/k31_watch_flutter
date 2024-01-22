import 'package:k31_watch_flutter/domain/repositories/tv_series_repositories.dart';

class GetWatchListStatusTv {
  final TvSeriesRepository repository;

  GetWatchListStatusTv(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlistTv(id);
  }
}
