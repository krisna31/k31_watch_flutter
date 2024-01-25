part of 'watch_list_movie_bloc.dart';

sealed class WatchListMovieEvent extends Equatable {
  const WatchListMovieEvent();

  @override
  List<Object> get props => [];
}

final class FetchWatchListMovieEvent extends WatchListMovieEvent {}
