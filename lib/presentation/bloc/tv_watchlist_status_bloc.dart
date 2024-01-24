import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k31_watch_flutter/domain/entities/detail_tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/get_watch_list_status_tv.dart';
import 'package:k31_watch_flutter/domain/use_case/remove_watch_list_tv.dart';
import 'package:k31_watch_flutter/domain/use_case/save_watch_list_tv.dart';

part 'tv_watchlist_status_event.dart';
part 'tv_watchlist_status_state.dart';

class TvWatchlistStatusBloc
    extends Bloc<TvWatchlistStatusEvent, TvWatchlistStatusState> {
  final GetWatchListStatusTv getWatchListStatus;
  final SaveWatchlistTv saveWatchlistTv;
  final RemoveWatchlistTv removeWatchlistTv;

  TvWatchlistStatusBloc({
    required this.getWatchListStatus,
    required this.saveWatchlistTv,
    required this.removeWatchlistTv,
  }) : super(TvWatchlistStatusInitial()) {
    on<FetchTvWatchlistStatusEvent>((event, emit) async {
      emit(TvWatchlistStatusLoading());

      final result = await getWatchListStatus.execute(event.id);

      emit(TvWatchlistStatusLoaded(isAdded: result, message: ''));
    });

    on<AddTvWatchlistEvent>((event, emit) async {
      emit(TvWatchlistStatusLoading());

      final result = await saveWatchlistTv.execute(event.tvSeries);

      result.fold(
        (failure) {
          emit(TvWatchlistStatusLoaded(
              isAdded: false, message: failure.message));
        },
        (data) {
          emit(TvWatchlistStatusLoaded(isAdded: true, message: data));
        },
      );
    });

    on<RemoveTvWatchlistEvent>((event, emit) async {
      emit(TvWatchlistStatusLoading());

      final result = await removeWatchlistTv.execute(event.tvSeries);

      result.fold(
        (failure) => emit(
            TvWatchlistStatusLoaded(isAdded: true, message: failure.message)),
        (data) => emit(TvWatchlistStatusLoaded(isAdded: false, message: data)),
      );
    });
  }
}
