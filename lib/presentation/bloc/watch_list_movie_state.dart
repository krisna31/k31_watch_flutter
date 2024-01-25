part of 'watch_list_movie_bloc.dart';

sealed class WatchListMovieState extends Equatable {
  const WatchListMovieState();

  @override
  List<Object> get props => [];
}

final class WatchListMovieInitial extends WatchListMovieState {}

final class WatchListMovieLoading extends WatchListMovieState {}

final class WatchListMovieHasData extends WatchListMovieState {
  final List<Movie> movies;

  const WatchListMovieHasData(this.movies);

  @override
  List<Object> get props => [movies];
}

final class WatchListMovieError extends WatchListMovieState {
  final String message;

  const WatchListMovieError(this.message);

  @override
  List<Object> get props => [message];
}
