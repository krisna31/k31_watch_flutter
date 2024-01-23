import 'package:k31_watch_flutter/common/failure.dart';
import 'package:k31_watch_flutter/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:k31_watch_flutter/domain/repositories/movie_repositories.dart';

class GetTopRatedMovies {
  GetTopRatedMovies(this.repository);
  final MovieRepository repository;
  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getTopRatedMovies();
  }
}
