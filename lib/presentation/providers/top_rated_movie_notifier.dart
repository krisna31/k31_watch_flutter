import 'package:k31_watch_flutter/common/request_state.dart';
import 'package:k31_watch_flutter/domain/entities/movie.dart';
import 'package:flutter/foundation.dart';
import 'package:k31_watch_flutter/domain/use_case/get_top_rated_movies.dart';

class TopRatedMoviesNotifier extends ChangeNotifier {
  final GetTopRatedMovies getTopRatedMovies;
  String _message = '';
  String get message => _message;
  TopRatedMoviesNotifier({required this.getTopRatedMovies});
  RequestState _state = RequestState.empty;
  RequestState get state => _state;
  List<Movie> _movies = [];
  List<Movie> get movies => _movies;
  Future<void> fetchTopRatedMovies() async {
    _state = RequestState.loading;
    notifyListeners();
    final result = await getTopRatedMovies.execute();
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (moviesData) {
        _movies = moviesData;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
