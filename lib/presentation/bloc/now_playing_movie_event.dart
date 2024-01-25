part of 'now_playing_movie_bloc.dart';

sealed class NowPlayingMovieEvent extends Equatable {
  const NowPlayingMovieEvent();

  @override
  List<Object> get props => [];
}

final class FetchNowPlayingMovieFromBloc extends NowPlayingMovieEvent {}
