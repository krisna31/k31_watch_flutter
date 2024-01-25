part of 'tv_series_top_rated_bloc.dart';

sealed class TvSeriesTopRatedEvent extends Equatable {
  const TvSeriesTopRatedEvent();

  @override
  List<Object> get props => [];
}

final class FetchTvSeriesTopRatedEvent extends TvSeriesTopRatedEvent {}