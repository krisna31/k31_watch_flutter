part of 'search_movie_bloc.dart';

sealed class SearchMovieState extends Equatable {
  const SearchMovieState();

  @override
  List<Object> get props => [];
}

final class SearchMovieInitial extends SearchMovieState {}

final class SearchMovieLoading extends SearchMovieState {}

final class SearchMovieHasData extends SearchMovieState {
  final List<Movie> result;
  const SearchMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}

final class SearchMovieError extends SearchMovieState {
  final String message;
  const SearchMovieError(this.message);

  @override
  List<Object> get props => [message];
}
