part of 'search_tv_series_bloc.dart';

sealed class SearchTvSeriesState extends Equatable {
  const SearchTvSeriesState();

  @override
  List<Object> get props => [];
}

class SearchTvEmpty extends SearchTvSeriesState {}

class SearchTvLoading extends SearchTvSeriesState {}

class SearchTvError extends SearchTvSeriesState {
  final String message;

  const SearchTvError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchTvHasData extends SearchTvSeriesState {
  final List<TvSeries> result;

  const SearchTvHasData(this.result);

  @override
  List<Object> get props => [result];
}
