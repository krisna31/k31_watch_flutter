import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:k31_watch_flutter/domain/entities/detail_tv_series.dart';
import 'package:k31_watch_flutter/common/request_state.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/get_detail_tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/get_recommendations_tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/get_watch_list_status_tv.dart';
import 'package:k31_watch_flutter/domain/use_case/remove_watch_list_tv.dart';
import 'package:k31_watch_flutter/domain/use_case/save_watch_list_tv.dart';

class DetailTvSeriesNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetDetailTvSeries getDetailTvSeries;
  final GetRecommendationsTvSeries getRecommendationsTvSeries;
  final GetWatchListStatusTv getWatchListStatusTv;
  final SaveWatchlistTv saveWatchlistTv;
  final RemoveWatchlistTv removeWatchlistTv;

  DetailTvSeriesNotifier({
    required this.getDetailTvSeries,
    required this.getRecommendationsTvSeries,
    required this.getWatchListStatusTv,
    required this.saveWatchlistTv,
    required this.removeWatchlistTv,
  });

  late DetailTvSeries _tvSeries;
  DetailTvSeries get tvSeries => _tvSeries;

  RequestState _tvSeriesState = RequestState.empty;
  RequestState get tvSeriesState => _tvSeriesState;

  late List<TvSeries> _tvRecommendations = [];
  List<TvSeries> get recommendationsTvSEries => _tvRecommendations;

  RequestState _recommendationState = RequestState.empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchDetailTvSeries(int id) async {
    _tvSeriesState = RequestState.loading;
    _recommendationState = RequestState.loading;
    notifyListeners();
    final detailResult = await getDetailTvSeries.execute(id);
    final recommendationResult = await getRecommendationsTvSeries.execute(id);
    detailResult.fold(
      (failure) {
        _tvSeriesState = RequestState.error;
        _recommendationState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeries) {
        _tvSeriesState = RequestState.loaded;
        _tvSeries = tvSeries;
        notifyListeners();
        _recommendationState = RequestState.loading;
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.error;
            _message = failure.message;
          },
          (tvSeries) {
            _recommendationState = RequestState.loaded;
            _tvRecommendations = tvSeries;
          },
        );
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(DetailTvSeries tv) async {
    final result = await saveWatchlistTv.execute(tv);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> removeFromWatchlist(DetailTvSeries tv) async {
    final result = await removeWatchlistTv.execute(tv);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatusTv.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
