import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/get_top_rated_tv_series.dart';

part 'tv_series_top_rated_event.dart';
part 'tv_series_top_rated_state.dart';

class TvSeriesTopRatedBloc
    extends Bloc<TvSeriesTopRatedEvent, TvSeriesTopRatedState> {
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TvSeriesTopRatedBloc(this.getTopRatedTvSeries)
      : super(TvSeriesTopRatedInitial()) {
    on<FetchTvSeriesTopRatedEvent>((event, emit) async {
      emit(TvSeriesTopRatedLoading());

      final result = await getTopRatedTvSeries.execute();

      result.fold(
        (failure) => emit(TvSeriesTopRatedError(failure.message)),
        (data) => emit(TvSeriesTopRatedHasData(data)),
      );
    });
  }
}
