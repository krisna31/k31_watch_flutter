import 'package:k31_watch_flutter/common/failure.dart';
import 'package:k31_watch_flutter/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:k31_watch_flutter/domain/repositories/movie_repositories.dart';

class GetWatchlistMovies {
  GetWatchlistMovies(this._repository);
  final MovieRepository _repository;
  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
