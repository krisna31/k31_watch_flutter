import 'package:k31_watch_flutter/common/failure.dart';
import 'package:k31_watch_flutter/domain/entities/movie.dart';
import 'package:k31_watch_flutter/domain/repositories/movie_repositories.dart';
import 'package:dartz/dartz.dart';

class GetPopularMovies {
  GetPopularMovies(this.repository);
  final MovieRepository repository;
  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getPopularMovies();
  }
}
