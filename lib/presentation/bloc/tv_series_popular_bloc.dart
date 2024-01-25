import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/get_popular_tv_series.dart';

part 'tv_series_popular_event.dart';
part 'tv_series_popular_state.dart';

class TvSeriesPopularBloc
    extends Bloc<TvSeriesPopularEvent, TvSeriesPopularState> {
  final GetPopularTvSeries getPopularTvSeries;
  TvSeriesPopularBloc(this.getPopularTvSeries)
      : super(TvSeriesPopularInitial()) {
    on<FetchTvSeriesPopularEvent>((event, emit) async {
      emit(TvSeriesPopularLoading());

      final result = await getPopularTvSeries.execute();

      result.fold(
        (failure) => emit(TvSeriesPopularError(failure.message)),
        (data) => emit(TvSeriesPopularHasData(data)),
      );
    });
  }
}
