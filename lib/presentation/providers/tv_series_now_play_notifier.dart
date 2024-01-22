import 'package:flutter/material.dart';
import 'package:k31_watch_flutter/common/request_state.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/get_now_playing_tv_series.dart';

class TvSeriesNowPlayNotifier extends ChangeNotifier {
  var _nowPlayingTvSeries = <TvSeries>[];
  List<TvSeries> get nowPlayingTvSeries => _nowPlayingTvSeries;

  RequestState _nowPlayingState = RequestState.empty;
  RequestState get nowPlayingState => _nowPlayingState;

  String _message = '';
  String get message => _message;

  TvSeriesNowPlayNotifier({
    required this.getNowPlayingTvSeries,
  });

  final GetNowPlayingTvSeries getNowPlayingTvSeries;

  Future<void> fetchNowPlayingTvSeriesFromNotifier() async {
    _nowPlayingState = RequestState.loading;
    notifyListeners();

    final result = await getNowPlayingTvSeries.execute();
    result.fold(
      (failure) {
        _nowPlayingState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _nowPlayingState = RequestState.loaded;
        _nowPlayingTvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }
}
