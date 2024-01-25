part of 'tv_series_popular_bloc.dart';

sealed class TvSeriesPopularEvent extends Equatable {
  const TvSeriesPopularEvent();

  @override
  List<Object> get props => [];
}

final class FetchTvSeriesPopularEvent extends TvSeriesPopularEvent {}