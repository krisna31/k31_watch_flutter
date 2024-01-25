import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k31_watch_flutter/domain/entities/movie.dart';
import 'package:k31_watch_flutter/domain/use_case/get_watch_list_movies.dart';

part 'watch_list_movie_event.dart';
part 'watch_list_movie_state.dart';

class WatchListMovieBloc
    extends Bloc<WatchListMovieEvent, WatchListMovieState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchListMovieBloc(this.getWatchlistMovies) : super(WatchListMovieInitial()) {
    on<FetchWatchListMovieEvent>((event, emit) async {
      emit(WatchListMovieLoading());

      final result = await getWatchlistMovies.execute();

      result.fold(
        (failure) => emit(WatchListMovieError(failure.message)),
        (data) => emit(WatchListMovieHasData(data)),
      );
    });
  }
}
