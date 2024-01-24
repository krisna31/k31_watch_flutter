part of 'detail_tv_series_bloc.dart';

sealed class DetailTvSeriesState extends Equatable {
  const DetailTvSeriesState();

  @override
  List<Object> get props => [];
}

class DetailTvSeriesInitial extends DetailTvSeriesState {}

class DetailTvSeriesLoading extends DetailTvSeriesState {}

class DetailTvSeriesLoaded extends DetailTvSeriesState {
  final DetailTvSeries tvSeries;

  const DetailTvSeriesLoaded({
    required this.tvSeries,
  });
}

class DetailTvSeriesError extends DetailTvSeriesState {
  final String message;

  const DetailTvSeriesError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
