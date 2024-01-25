part of 'tv_series_now_playing_bloc.dart';

sealed class TvSeriesNowPlayingEvent extends Equatable {
  const TvSeriesNowPlayingEvent();

  @override
  List<Object> get props => [];
}

final class FetchTvSeriesNowPlayingEvent extends TvSeriesNowPlayingEvent {}
