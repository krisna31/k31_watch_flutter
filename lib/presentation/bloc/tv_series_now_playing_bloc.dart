import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/get_now_playing_tv_series.dart';

part 'tv_series_now_playing_event.dart';
part 'tv_series_now_playing_state.dart';

class TvSeriesNowPlayingBloc
    extends Bloc<TvSeriesNowPlayingEvent, TvSeriesNowPlayingState> {
  final GetNowPlayingTvSeries getNowPlayingTvSeries;

  TvSeriesNowPlayingBloc(this.getNowPlayingTvSeries)
      : super(TvSeriesNowPlayingInitial()) {
    on<FetchTvSeriesNowPlayingEvent>((event, emit) async {
      emit(TvSeriesNowPlayingLoading());

      final result = await getNowPlayingTvSeries.execute();

      result.fold(
        (failure) => emit(TvSeriesNowPlayingError(failure.message)),
        (data) => emit(TvSeriesNowPlayingHasData(data)),
      );
    });
  }
}
