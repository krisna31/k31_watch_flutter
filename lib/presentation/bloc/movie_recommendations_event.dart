part of 'movie_recommendations_bloc.dart';

sealed class MovieRecommendationsEvent extends Equatable {
  const MovieRecommendationsEvent();

  @override
  List<Object> get props => [];
}

final class FetchMovieRecommendationsFromBloc
    extends MovieRecommendationsEvent {
  final int id;
  const FetchMovieRecommendationsFromBloc(this.id);

  @override
  List<Object> get props => [id];
}
