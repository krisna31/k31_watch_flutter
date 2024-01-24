import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/search_tv.dart';
import 'package:rxdart/rxdart.dart';

part 'search_tv_series_event.dart';
part 'search_tv_series_state.dart';

class SearchTvSeriesBloc
    extends Bloc<SearchTvSeriesEvent, SearchTvSeriesState> {
  final SearchTv _searchTv;
  SearchTvSeriesBloc(this._searchTv) : super(SearchTvEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      emit(SearchTvLoading());
      final result = await _searchTv.execute(event.query);
      result.fold(
        (failure) {
          emit(SearchTvError(failure.message));
        },
        (data) {
          emit(SearchTvHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 543)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
