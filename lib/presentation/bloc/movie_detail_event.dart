part of 'movie_detail_bloc.dart';

sealed class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

final class FetchMovieDetailFromBloc extends MovieDetailEvent {
  final int id;
  const FetchMovieDetailFromBloc(this.id);

  @override
  List<Object> get props => [id];
}
