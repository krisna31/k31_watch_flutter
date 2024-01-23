import 'package:k31_watch_flutter/domain/repositories/movie_repositories.dart';

class GetWatchListStatus {
  GetWatchListStatus(this.repository);
  final MovieRepository repository;
  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
