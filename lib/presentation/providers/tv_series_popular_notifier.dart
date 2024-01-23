import 'package:k31_watch_flutter/common/request_state.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/get_popular_tv_series.dart';
import 'package:flutter/material.dart';

class TvSeriesPopularNotifier extends ChangeNotifier {
  final GetPopularTvSeries getPopularTvSeries;
  var _popularTvSeries = <TvSeries>[];
  List<TvSeries> get popularTvSeries => _popularTvSeries;
  RequestState _popularTvSeriesState = RequestState.empty;
  RequestState get popularTvSeriesState => _popularTvSeriesState;

  String _message = '';
  String get message => _message;
  TvSeriesPopularNotifier({
    required this.getPopularTvSeries,
  });

  Future<void> fetchPopularTvSeriesFromNotifier() async {
    _popularTvSeriesState = RequestState.loading;
    notifyListeners();
    final result = await getPopularTvSeries.execute();
    result.fold((failure) {
      _message = failure.message;
      _popularTvSeriesState = RequestState.error;

      notifyListeners();
    }, (tvSeriesData) {
      _popularTvSeries = tvSeriesData;
      _popularTvSeriesState = RequestState.loaded;

      notifyListeners();
    });
  }
}
