import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k31_watch_flutter/domain/entities/movie.dart';
import 'package:k31_watch_flutter/domain/use_case/get_popular_movies.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  GetPopularMovies getPopularMovies;

  PopularMovieBloc(this.getPopularMovies) : super(PopularMovieInitial()) {
    on<FetchPopularMovieFromBloc>((event, emit) async {
      emit(PopularMovieLoading());

      final result = await getPopularMovies.execute();

      result.fold(
        (failure) => emit(PopularMovieError(failure.message)),
        (movies) => emit(PopularMovieHasData(movies)),
      );
    });
  }
}
