import 'package:k31_watch_flutter/common/failure.dart';
import 'package:k31_watch_flutter/domain/entities/movie_detail.dart';
import 'package:dartz/dartz.dart';
import 'package:k31_watch_flutter/domain/repositories/movie_repositories.dart';

class GetMovieDetail {
  GetMovieDetail(this.repository);
  final MovieRepository repository;
  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
