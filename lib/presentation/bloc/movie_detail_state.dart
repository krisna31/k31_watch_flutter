part of 'movie_detail_bloc.dart';

sealed class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

final class MovieDetailInitial extends MovieDetailState {}

final class MovieDetailLoading extends MovieDetailState {}

final class MovieDetailHasData extends MovieDetailState {
  final MovieDetail movieDetail;
  const MovieDetailHasData(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

final class MovieDetailError extends MovieDetailState {
  final String message;
  const MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}
