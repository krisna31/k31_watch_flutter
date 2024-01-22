import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:k31_watch_flutter/domain/entities/detail_tv_series.dart';
import 'package:k31_watch_flutter/domain/entities/movie.dart';
import 'package:k31_watch_flutter/domain/entities/movie_detail.dart';
import 'package:k31_watch_flutter/common/request_state.dart';
import 'package:k31_watch_flutter/domain/use_case/get_detail_tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/get_movie_recommendations.dart';
import 'package:k31_watch_flutter/domain/use_case/get_movie_detail.dart';
import 'package:k31_watch_flutter/domain/use_case/get_watch_list_status.dart';
import 'package:k31_watch_flutter/domain/use_case/remove_watch_list.dart';
import 'package:k31_watch_flutter/domain/use_case/save_watch_list.dart';

class DetailTvSeriesNotifier extends ChangeNotifier {
  // static const watchlistAddSuccessMessage = 'Added to Watchlist';
  // static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetDetailTvSeries getDetailTvSeries;
  // final GetWatchListStatus getWatchListStatus;
  // final SaveWatchlist saveWatchlist;
  // final RemoveWatchlist removeWatchlist;

  DetailTvSeriesNotifier({
    required this.getDetailTvSeries,
    // required this.getWatchListStatus,
    // required this.saveWatchlist,
    // required this.removeWatchlist,
  });

  late DetailTvSeries _tvSeries;
  DetailTvSeries get tvSeries => _tvSeries;

  RequestState _tvSeriesState = RequestState.empty;
  RequestState get tvSeriesState => _tvSeriesState;

  String _message = '';
  String get message => _message;

  // final bool _isAddedtoWatchlist = false;
  // bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchDetailTvSeries(int id) async {
    _tvSeriesState = RequestState.loading;
    notifyListeners();
    final detailResult = await getDetailTvSeries.execute(id);
    detailResult.fold(
      (failure) {
        _tvSeriesState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeries) {
        _tvSeries = tvSeries;
        notifyListeners();
        _tvSeriesState = RequestState.loaded;
        notifyListeners();
      },
    );
  }

  // String _watchlistMessage = '';
  // String get watchlistMessage => _watchlistMessage;

  // Future<void> addWatchlist(MovieDetail movie) async {
  //   final result = await saveWatchlist.execute(movie);

  //   await result.fold(
  //     (failure) async {
  //       _watchlistMessage = failure.message;
  //     },
  //     (successMessage) async {
  //       _watchlistMessage = successMessage;
  //     },
  //   );

  //   await loadWatchlistStatus(movie.id);
  // }

  // Future<void> removeFromWatchlist(MovieDetail movie) async {
  //   final result = await removeWatchlist.execute(movie);

  //   await result.fold(
  //     (failure) async {
  //       _watchlistMessage = failure.message;
  //     },
  //     (successMessage) async {
  //       _watchlistMessage = successMessage;
  //     },
  //   );

  //   await loadWatchlistStatus(movie.id);
  // }

  // Future<void> loadWatchlistStatus(int id) async {
  //   final result = await getWatchListStatus.execute(id);
  //   _isAddedtoWatchlist = result;
  //   notifyListeners();
  // }
}
