import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k31_watch_flutter/domain/entities/detail_tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/get_detail_tv_series.dart';
part 'detail_tv_series_event.dart';
part 'detail_tv_series_state.dart';

class DetailTvSeriesBloc
    extends Bloc<DetailTvSeriesEvent, DetailTvSeriesState> {
  final GetDetailTvSeries getDetailTvSeries;

  DetailTvSeriesBloc(
    this.getDetailTvSeries,
  ) : super(DetailTvSeriesInitial()) {
    on<FetchDetailTvSeriesEvent>((event, emit) async {
      emit(DetailTvSeriesLoading());

      final getDetailTv = await getDetailTvSeries.execute(event.id);

      getDetailTv.fold(
        (failure) {
          emit(
            DetailTvSeriesError(message: failure.message),
          );
        },
        (detailTv) {
          emit(DetailTvSeriesLoaded(tvSeries: detailTv));
        },
      );
    });
  }
}
