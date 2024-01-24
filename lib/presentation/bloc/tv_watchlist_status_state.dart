part of 'tv_watchlist_status_bloc.dart';

const String removedFromTvList = 'Removed from Tv Series Watchlist';
const String addedFromTvList = 'Added to Tv Series Watchlist';

sealed class TvWatchlistStatusState extends Equatable {
  const TvWatchlistStatusState();

  @override
  List<Object> get props => [];
}

final class TvWatchlistStatusInitial extends TvWatchlistStatusState {}

final class TvWatchlistStatusLoading extends TvWatchlistStatusState {}

final class TvWatchlistStatusLoaded extends TvWatchlistStatusState {
  final bool isAdded;
  final String message;

  const TvWatchlistStatusLoaded({
    required this.isAdded,
    required this.message,
  });

  @override
  List<Object> get props => [isAdded, message];
}
