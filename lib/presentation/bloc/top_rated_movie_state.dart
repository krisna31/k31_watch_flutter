part of 'top_rated_movie_bloc.dart';

sealed class TopRatedMovieState extends Equatable {
  const TopRatedMovieState();

  @override
  List<Object> get props => [];
}

final class TopRatedMovieInitial extends TopRatedMovieState {}

final class TopRatedMovieLoading extends TopRatedMovieState {}

final class TopRatedMovieHasData extends TopRatedMovieState {
  final List<Movie> movies;

  const TopRatedMovieHasData(this.movies);

  @override
  List<Object> get props => [movies];
}

final class TopRatedMovieError extends TopRatedMovieState {
  final String message;

  const TopRatedMovieError(this.message);

  @override
  List<Object> get props => [message];
}
