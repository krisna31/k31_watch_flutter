import 'package:flutter/material.dart';
import 'package:k31_watch_flutter/common/request_state.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/get_now_playing_tv_series.dart';

class TvSeriesListNotifier extends ChangeNotifier {
  var _nowPlayingTvSeries = <TvSeries>[];
  List<TvSeries> get nowPlayingTvSeries => _nowPlayingTvSeries;

  RequestState _nowPlayingState = RequestState.empty;
  RequestState get nowPlayingState => _nowPlayingState;

  // var _popularMovies = <Movie>[];
  // List<Movie> get popularMovies => _popularMovies;

  // RequestState _popularMoviesState = RequestState.empty;
  // RequestState get popularMoviesState => _popularMoviesState;

  // var _topRatedMovies = <Movie>[];
  // List<Movie> get topRatedMovies => _topRatedMovies;

  // RequestState _topRatedMoviesState = RequestState.empty;
  // RequestState get topRatedMoviesState => _topRatedMoviesState;

  String _message = '';
  String get message => _message;

  TvSeriesListNotifier({
    required this.getNowPlayingTvSeries,
    // required this.getPopularMovies,
    // required this.getTopRatedMovies,
  });

  final GetNowPlayingTvSeries getNowPlayingTvSeries;
  // final GetPopularMovies getPopularMovies;
  // final GetTopRatedMovies getTopRatedMovies;

  Future<void> fetchNowPlayingTvSeries() async {
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

  // Future<void> fetchPopularMovies() async {
  //   _popularMoviesState = RequestState.loading;
  //   notifyListeners();

  //   final result = await getPopularMovies.execute();
  //   result.fold(
  //     (failure) {
  //       _popularMoviesState = RequestState.error;
  //       _message = failure.message;
  //       notifyListeners();
  //     },
  //     (moviesData) {
  //       _popularMoviesState = RequestState.loaded;
  //       _popularMovies = moviesData;
  //       notifyListeners();
  //     },
  //   );
  // }

  // Future<void> fetchTopRatedMovies() async {
  //   _topRatedMoviesState = RequestState.loading;
  //   notifyListeners();

  //   final result = await getTopRatedMovies.execute();
  //   result.fold(
  //     (failure) {
  //       _topRatedMoviesState = RequestState.error;
  //       _message = failure.message;
  //       notifyListeners();
  //     },
  //     (moviesData) {
  //       _topRatedMoviesState = RequestState.loaded;
  //       _topRatedMovies = moviesData;
  //       notifyListeners();
  //     },
  //   );
  // }
}
