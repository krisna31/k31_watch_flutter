part of 'tv_recommendations_bloc.dart';

sealed class TvRecommendationsEvent extends Equatable {
  const TvRecommendationsEvent();

  @override
  List<Object> get props => [];
}

final class FetchTvRecommendationsEvent extends TvRecommendationsEvent {
  final int id;

  const FetchTvRecommendationsEvent({required this.id});

  @override
  List<Object> get props => [id];
}
