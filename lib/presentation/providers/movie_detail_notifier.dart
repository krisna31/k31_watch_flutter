import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:k31_watch_flutter/domain/entities/movie.dart';
import 'package:k31_watch_flutter/domain/entities/movie_detail.dart';
import 'package:k31_watch_flutter/common/request_state.dart';
import 'package:k31_watch_flutter/domain/use_case/get_movie_recommendations.dart';
import 'package:k31_watch_flutter/domain/use_case/get_movie_detail.dart';
import 'package:k31_watch_flutter/domain/use_case/get_watch_list_status.dart';
import 'package:k31_watch_flutter/domain/use_case/remove_watch_list.dart';
import 'package:k31_watch_flutter/domain/use_case/save_watch_list.dart';

class MovieDetailNotifier extends ChangeNotifier {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  static const watchlistAddSuccessMessage = 'Added to Watchlist Movies';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist Movies';

  late MovieDetail _movie;
  MovieDetail get movie => _movie;
  RequestState _movieState = RequestState.empty;
  RequestState get movieState => _movieState;

  List<Movie> _movieRecommendations = [];
  List<Movie> get movieRecommendations => _movieRecommendations;
  RequestState _recommendationState = RequestState.empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;
  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  MovieDetailNotifier({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  });

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> fetchMovieDetail(int id) async {
    _movieState = RequestState.loading;
    notifyListeners();
    final detailResult = await getMovieDetail.execute(id);
    final recommendationResult = await getMovieRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _movieState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (movie) {
        _recommendationState = RequestState.loading;
        _movie = movie;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.error;
            _message = failure.message;
          },
          (movies) {
            _recommendationState = RequestState.loaded;
            _movieRecommendations = movies;
          },
        );
        _movieState = RequestState.loaded;
        notifyListeners();
      },
    );
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }

  Future<void> removeFromWatchlist(MovieDetail movie) async {
    final result = await removeWatchlist.execute(movie);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(movie.id);
  }

  Future<void> addWatchlist(MovieDetail movie) async {
    final result = await saveWatchlist.execute(movie);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(movie.id);
  }
}
