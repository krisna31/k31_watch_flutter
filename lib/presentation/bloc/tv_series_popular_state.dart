part of 'tv_series_popular_bloc.dart';

sealed class TvSeriesPopularState extends Equatable {
  const TvSeriesPopularState();

  @override
  List<Object> get props => [];
}

final class TvSeriesPopularInitial extends TvSeriesPopularState {}

final class TvSeriesPopularLoading extends TvSeriesPopularState {}

final class TvSeriesPopularHasData extends TvSeriesPopularState {
  final List<TvSeries> tvSeries;

  const TvSeriesPopularHasData(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

final class TvSeriesPopularError extends TvSeriesPopularState {
  final String message;

  const TvSeriesPopularError(this.message);

  @override
  List<Object> get props => [message];
}
