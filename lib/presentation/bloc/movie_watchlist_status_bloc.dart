import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k31_watch_flutter/domain/entities/movie_detail.dart';
import 'package:k31_watch_flutter/domain/use_case/get_watch_list_status.dart';
import 'package:k31_watch_flutter/domain/use_case/remove_watch_list.dart';
import 'package:k31_watch_flutter/domain/use_case/save_watch_list.dart';

part 'movie_watchlist_status_event.dart';
part 'movie_watchlist_status_state.dart';

class MovieWatchlistStatusBloc
    extends Bloc<MovieWatchlistStatusEvent, MovieWatchlistStatusState> {
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieWatchlistStatusBloc(
    this.getWatchListStatus,
    this.saveWatchlist,
    this.removeWatchlist,
  ) : super(MovieWatchlistStatusInitial()) {
    on<FetchMovieWatchlistStatusFromBloc>((event, emit) async {
      emit(MovieWatchlistStatusLoading());

      final result = await getWatchListStatus.execute(event.id);

      emit(MovieWatchlistStatusHasData(result, null));
    });

    on<AddMovieToWatchlistFromBloc>((event, emit) async {
      emit(MovieWatchlistStatusLoading());

      final result = await saveWatchlist.execute(event.movieDetail);

      result.fold(
        (failure) => emit(MovieWatchlistStatusHasData(false, failure.message)),
        (success) => emit(MovieWatchlistStatusHasData(true, success)),
      );
    });

    on<RemoveMovieFromWatchlistFromBloc>((event, emit) async {
      emit(MovieWatchlistStatusLoading());

      final result = await removeWatchlist.execute(event.movieDetail);

      result.fold(
        (failure) => emit(MovieWatchlistStatusHasData(true, failure.message)),
        (success) => emit(MovieWatchlistStatusHasData(false, success)),
      );
    });
  }
}
