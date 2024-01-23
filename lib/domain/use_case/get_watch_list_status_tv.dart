import 'package:k31_watch_flutter/domain/repositories/tv_series_repositories.dart';

class GetWatchListStatusTv {
  GetWatchListStatusTv(this.repository);
  final TvSeriesRepository repository;
  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlistTv(id);
  }
}
