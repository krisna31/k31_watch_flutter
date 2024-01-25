part of 'popular_movie_bloc.dart';

sealed class PopularMovieState extends Equatable {
  const PopularMovieState();

  @override
  List<Object> get props => [];
}

final class PopularMovieInitial extends PopularMovieState {}

final class PopularMovieLoading extends PopularMovieState {}

final class PopularMovieHasData extends PopularMovieState {
  final List<Movie> movies;

  const PopularMovieHasData(this.movies);

  @override
  List<Object> get props => [movies];
}

final class PopularMovieError extends PopularMovieState {
  final String message;

  const PopularMovieError(this.message);

  @override
  List<Object> get props => [message];
}
