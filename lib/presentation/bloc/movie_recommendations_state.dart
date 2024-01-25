part of 'movie_recommendations_bloc.dart';

sealed class MovieRecommendationsState extends Equatable {
  const MovieRecommendationsState();

  @override
  List<Object> get props => [];
}

final class MovieRecommendationsInitial extends MovieRecommendationsState {}

final class MovieRecommendationsLoading extends MovieRecommendationsState {}

final class MovieRecommendationsHasData extends MovieRecommendationsState {
  final List<Movie> movies;
  const MovieRecommendationsHasData(this.movies);

  @override
  List<Object> get props => [movies];
}

final class MovieRecommendationsError extends MovieRecommendationsState {
  final String message;
  const MovieRecommendationsError(this.message);

  @override
  List<Object> get props => [message];
}
