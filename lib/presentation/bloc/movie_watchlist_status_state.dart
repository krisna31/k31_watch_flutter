part of 'movie_watchlist_status_bloc.dart';

sealed class MovieWatchlistStatusState extends Equatable {
  const MovieWatchlistStatusState();

  @override
  List<Object> get props => [];
}

final class MovieWatchlistStatusInitial extends MovieWatchlistStatusState {}

final class MovieWatchlistStatusLoading extends MovieWatchlistStatusState {}

final class MovieWatchlistStatusHasData extends MovieWatchlistStatusState {
  final bool isAdded;
  final String? message;

  const MovieWatchlistStatusHasData(this.isAdded, this.message);

  @override
  List<Object> get props => [isAdded];
}
