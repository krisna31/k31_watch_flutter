import 'package:k31_watch_flutter/common/request_state.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/get_top_rated_tv_series.dart';
import 'package:flutter/material.dart';

class TvSeriesTopRatedNotifier extends ChangeNotifier {
  final GetTopRatedTvSeries getTopRatedTvSeries;
  var _topRatedTvSeries = <TvSeries>[];
  List<TvSeries> get topRatedTvSeries => _topRatedTvSeries;
  RequestState _topRatedTvSeriesState = RequestState.empty;
  RequestState get topRatedTvSeriesState => _topRatedTvSeriesState;
  String _message = '';
  String get message => _message;
  TvSeriesTopRatedNotifier({
    required this.getTopRatedTvSeries,
  });


  Future<void> fetchTopRatedTvSeriesFromNotifier() async {
    _topRatedTvSeriesState = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedTvSeries.execute();
    result.fold(
      (failure) {
        _topRatedTvSeriesState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _topRatedTvSeriesState = RequestState.loaded;
        _topRatedTvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }
}
