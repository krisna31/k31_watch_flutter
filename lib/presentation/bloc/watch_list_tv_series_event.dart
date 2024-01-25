part of 'watch_list_tv_series_bloc.dart';

sealed class WatchListTvSeriesEvent extends Equatable {
  const WatchListTvSeriesEvent();

  @override
  List<Object> get props => [];
}

final class FetchWatchListTvSeriesEvent extends WatchListTvSeriesEvent {}
