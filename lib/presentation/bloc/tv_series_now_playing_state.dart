part of 'tv_series_now_playing_bloc.dart';

sealed class TvSeriesNowPlayingState extends Equatable {
  const TvSeriesNowPlayingState();

  @override
  List<Object> get props => [];
}

final class TvSeriesNowPlayingInitial extends TvSeriesNowPlayingState {}

final class TvSeriesNowPlayingLoading extends TvSeriesNowPlayingState {}

final class TvSeriesNowPlayingHasData extends TvSeriesNowPlayingState {
  final List<TvSeries> tvSeries;

  const TvSeriesNowPlayingHasData(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

final class TvSeriesNowPlayingError extends TvSeriesNowPlayingState {
  final String message;

  const TvSeriesNowPlayingError(this.message);

  @override
  List<Object> get props => [message];
}
