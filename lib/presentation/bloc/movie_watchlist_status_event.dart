part of 'movie_watchlist_status_bloc.dart';

sealed class MovieWatchlistStatusEvent extends Equatable {
  const MovieWatchlistStatusEvent();

  @override
  List<Object> get props => [];
}

final class FetchMovieWatchlistStatusFromBloc
    extends MovieWatchlistStatusEvent {
  final int id;
  const FetchMovieWatchlistStatusFromBloc(this.id);

  @override
  List<Object> get props => [id];
}

final class AddMovieToWatchlistFromBloc extends MovieWatchlistStatusEvent {
  final MovieDetail movieDetail;
  const AddMovieToWatchlistFromBloc(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

final class RemoveMovieFromWatchlistFromBloc extends MovieWatchlistStatusEvent {
  final MovieDetail movieDetail;
  const RemoveMovieFromWatchlistFromBloc(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
