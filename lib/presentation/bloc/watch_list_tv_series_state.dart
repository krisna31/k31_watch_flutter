part of 'watch_list_tv_series_bloc.dart';

sealed class WatchListTvSeriesState extends Equatable {
  const WatchListTvSeriesState();

  @override
  List<Object> get props => [];
}

final class WatchListTvSeriesInitial extends WatchListTvSeriesState {}

final class WatchListTvSeriesLoading extends WatchListTvSeriesState {}

final class WatchListTvSeriesHasData extends WatchListTvSeriesState {
  final List<TvSeries> tvSeries;

  const WatchListTvSeriesHasData(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

final class WatchListTvSeriesError extends WatchListTvSeriesState {
  final String message;

  const WatchListTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}
