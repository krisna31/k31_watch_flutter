part of 'now_playing_movie_bloc.dart';

sealed class NowPlayingMovieState extends Equatable {
  const NowPlayingMovieState();

  @override
  List<Object> get props => [];
}

final class NowPlayingMovieInitial extends NowPlayingMovieState {}

final class NowPlayingMovieLoading extends NowPlayingMovieState {}

final class NowPlayingMovieHasData extends NowPlayingMovieState {
  final List<Movie> movies;

  const NowPlayingMovieHasData(this.movies);

  @override
  List<Object> get props => [movies];
}

final class NowPlayingMovieError extends NowPlayingMovieState {
  final String message;

  const NowPlayingMovieError(this.message);

  @override
  List<Object> get props => [message];
}
