import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k31_watch_flutter/domain/entities/movie.dart';
import 'package:k31_watch_flutter/domain/use_case/search_movies.dart';
import 'package:rxdart/rxdart.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovies _searchMovie;

  SearchMovieBloc(this._searchMovie) : super(SearchMovieInitial()) {
    on<QuerySearchMovieFromBloc>((event, emit) async {
      emit(SearchMovieLoading());
      final result = await _searchMovie.execute(event.query);

      result.fold(
        (failure) {
          emit(SearchMovieError(failure.message));
        },
        (data) {
          emit(SearchMovieHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 543)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
