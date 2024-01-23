import 'package:k31_watch_flutter/common/failure.dart';
import 'package:k31_watch_flutter/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:k31_watch_flutter/domain/repositories/movie_repositories.dart';

class SearchMovies {
  SearchMovies(this.repository);
  final MovieRepository repository;
  Future<Either<Failure, List<Movie>>> execute(String query) {
    return repository.searchMovies(query);
  }
}
