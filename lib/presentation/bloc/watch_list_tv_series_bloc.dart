import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/get_watch_list_tv.dart';

part 'watch_list_tv_series_event.dart';
part 'watch_list_tv_series_state.dart';

class WatchListTvSeriesBloc
    extends Bloc<WatchListTvSeriesEvent, WatchListTvSeriesState> {
  final GetWatchlistTv getWatchlistTv;

  WatchListTvSeriesBloc(this.getWatchlistTv)
      : super(WatchListTvSeriesInitial()) {
    on<FetchWatchListTvSeriesEvent>((event, emit) async {
      emit(WatchListTvSeriesLoading());

      final result = await getWatchlistTv.execute();

      result.fold(
        (failure) => emit(WatchListTvSeriesError(failure.message)),
        (data) => emit(WatchListTvSeriesHasData(data)),
      );
    });
  }
}
