import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/get_recommendations_tv_series.dart';

part 'tv_recommendations_event.dart';
part 'tv_recommendations_state.dart';

class TvRecommendationsBloc
    extends Bloc<TvRecommendationsEvent, TvRecommendationsState> {
  final GetRecommendationsTvSeries getRecommendationsTvSeries;

  TvRecommendationsBloc(this.getRecommendationsTvSeries)
      : super(TvRecommendationsInitial()) {
    on<FetchTvRecommendationsEvent>((event, emit) async {
      emit(TvRecommendationsLoading());
      final result = await getRecommendationsTvSeries.execute(event.id);

      result.fold(
        (failure) => emit(TvRecommendationsError(message: failure.message)),
        (data) => emit(TvRecommendationsHasData(tvSeries: data)),
      );
    });
  }
}
