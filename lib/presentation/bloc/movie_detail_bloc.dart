import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k31_watch_flutter/domain/entities/movie_detail.dart';
import 'package:k31_watch_flutter/domain/use_case/get_movie_detail.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;

  MovieDetailBloc(this.getMovieDetail) : super(MovieDetailInitial()) {
    on<FetchMovieDetailFromBloc>((event, emit) async {
      emit(MovieDetailLoading());

      final result = await getMovieDetail.execute(event.id);

      result.fold(
        (failure) => emit(MovieDetailError(failure.message)),
        (movieDetail) => emit(MovieDetailHasData(movieDetail)),
      );
    });
  }
}
