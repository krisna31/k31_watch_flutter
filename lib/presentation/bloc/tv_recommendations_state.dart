part of 'tv_recommendations_bloc.dart';

sealed class TvRecommendationsState extends Equatable {
  const TvRecommendationsState();

  @override
  List<Object> get props => [];
}

final class TvRecommendationsInitial extends TvRecommendationsState {}

final class TvRecommendationsLoading extends TvRecommendationsState {}

final class TvRecommendationsHasData extends TvRecommendationsState {
  final List<TvSeries> tvSeries;

  const TvRecommendationsHasData({required this.tvSeries});

  @override
  List<Object> get props => [tvSeries];
}

class TvRecommendationsError extends TvRecommendationsState {
  final String message;

  const TvRecommendationsError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
