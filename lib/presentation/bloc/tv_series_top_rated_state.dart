part of 'tv_series_top_rated_bloc.dart';

sealed class TvSeriesTopRatedState extends Equatable {
  const TvSeriesTopRatedState();

  @override
  List<Object> get props => [];
}

final class TvSeriesTopRatedInitial extends TvSeriesTopRatedState {}

final class TvSeriesTopRatedLoading extends TvSeriesTopRatedState {}

final class TvSeriesTopRatedHasData extends TvSeriesTopRatedState {
  final List<TvSeries> tvSeries;

  const TvSeriesTopRatedHasData(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

final class TvSeriesTopRatedError extends TvSeriesTopRatedState {
  final String message;

  const TvSeriesTopRatedError(this.message);

  @override
  List<Object> get props => [message];
}
