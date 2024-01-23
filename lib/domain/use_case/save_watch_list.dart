import 'package:k31_watch_flutter/common/failure.dart';
import 'package:k31_watch_flutter/domain/entities/movie_detail.dart';
import 'package:k31_watch_flutter/domain/repositories/movie_repositories.dart';
import 'package:dartz/dartz.dart';

class SaveWatchlist {
  SaveWatchlist(this.repository);
  final MovieRepository repository;
  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.saveWatchlist(movie);
  }
}
