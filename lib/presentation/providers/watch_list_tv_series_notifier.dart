import 'package:k31_watch_flutter/domain/use_case/get_watch_list_tv.dart';
import 'package:flutter/foundation.dart';
import 'package:k31_watch_flutter/common/request_state.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';

class WatchlistTvSeriesNotifier extends ChangeNotifier {
  final GetWatchlistTv getWatchlistTv;
  WatchlistTvSeriesNotifier({required this.getWatchlistTv});
  var _watchlistTvSeries = <TvSeries>[];
  List<TvSeries> get watchlistTvSeriess => _watchlistTvSeries;
  var _watchlistState = RequestState.empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  Future<void> fetchWatchlistTvSeriess() async {
    _watchlistState = RequestState.loading;
    notifyListeners();
    final result = await getWatchlistTv.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _watchlistState = RequestState.loaded;
        _watchlistTvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }
}
