import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:flutter/foundation.dart';
import 'package:k31_watch_flutter/common/request_state.dart';
import 'package:k31_watch_flutter/domain/use_case/search_tv.dart';

class SearchTvNotifier extends ChangeNotifier {
  final SearchTv searchTv;
  SearchTvNotifier({required this.searchTv});
  String _message = '';
  String get message => _message;
  RequestState _state = RequestState.empty;
  RequestState get state => _state;
  List<TvSeries> _searchResult = [];
  List<TvSeries> get searchResult => _searchResult;
  Future<void> fetchTvSearchFromNotifier(String query) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await searchTv.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
