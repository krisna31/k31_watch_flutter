part of 'popular_movie_bloc.dart';

sealed class PopularMovieEvent extends Equatable {
  const PopularMovieEvent();

  @override
  List<Object> get props => [];
}

final class FetchPopularMovieFromBloc extends PopularMovieEvent {}
