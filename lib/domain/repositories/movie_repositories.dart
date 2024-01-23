import 'package:k31_watch_flutter/common/failure.dart';
import 'package:k31_watch_flutter/domain/entities/movie_detail.dart';
import 'package:k31_watch_flutter/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();
  Future<Either<Failure, List<Movie>>> getTopRatedMovies();
  Future<Either<Failure, List<Movie>>> getPopularMovies();
  Future<Either<Failure, List<Movie>>> getMovieRecommendations(int id);
  Future<Either<Failure, MovieDetail>> getMovieDetail(int id);
  Future<Either<Failure, String>> saveWatchlist(MovieDetail movie);
  Future<Either<Failure, List<Movie>>> searchMovies(String query);
  Future<Either<Failure, String>> removeWatchlist(MovieDetail movie);
  Future<Either<Failure, List<Movie>>> getWatchlistMovies();
  Future<bool> isAddedToWatchlist(int id);
}
