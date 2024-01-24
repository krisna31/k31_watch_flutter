part of 'tv_watchlist_status_bloc.dart';

// import 'package:k31_watch_flutter/domain/entities/detail_tv_series.dart';

sealed class TvWatchlistStatusEvent extends Equatable {
  const TvWatchlistStatusEvent();

  @override
  List<Object> get props => [];
}

final class FetchTvWatchlistStatusEvent extends TvWatchlistStatusEvent {
  final int id;

  const FetchTvWatchlistStatusEvent({required this.id});

  @override
  List<Object> get props => [id];
}

final class AddTvWatchlistEvent extends TvWatchlistStatusEvent {
  final DetailTvSeries tvSeries;

  const AddTvWatchlistEvent({required this.tvSeries});

  @override
  List<Object> get props => [tvSeries];
}

final class RemoveTvWatchlistEvent extends TvWatchlistStatusEvent {
  final DetailTvSeries tvSeries;

  const RemoveTvWatchlistEvent({required this.tvSeries});

  @override
  List<Object> get props => [tvSeries];
}
