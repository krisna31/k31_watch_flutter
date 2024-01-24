part of 'detail_tv_series_bloc.dart';

sealed class DetailTvSeriesEvent extends Equatable {
  const DetailTvSeriesEvent();

  @override
  List<Object> get props => [];
}

final class FetchDetailTvSeriesEvent extends DetailTvSeriesEvent {
  final int id;

  const FetchDetailTvSeriesEvent({required this.id});

  @override
  List<Object> get props => [id];
}
