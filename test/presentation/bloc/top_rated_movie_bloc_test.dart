import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:k31_watch_flutter/common/failure_child/server_failure.dart';
import 'package:k31_watch_flutter/domain/entities/movie.dart';
import 'package:k31_watch_flutter/domain/use_case/get_top_rated_movies.dart';
import 'package:k31_watch_flutter/presentation/bloc/top_rated_movie_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_movie_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedMovieBloc topRatedMovieBloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMovieBloc = TopRatedMovieBloc(mockGetTopRatedMovies);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
    originalLanguage: 'en',
  );

  group("Top Rated Movie Bloc", () {
    test("initial state should be TopRatedMovieInitial", () {
      expect(topRatedMovieBloc.state, equals(TopRatedMovieInitial()));
    });

    blocTest("shoudl emit loading and has data when response succesfully",
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => Right(<Movie>[tMovie]));
          return topRatedMovieBloc;
        },
        act: (bloc) => bloc.add(FetchTopRatedMovieFromBloc()),
        expect: () {
          return [
            TopRatedMovieLoading(),
            TopRatedMovieHasData(<Movie>[tMovie]),
          ];
        },
        verify: (bloc) {
          verify(mockGetTopRatedMovies.execute());
        });

    blocTest(
        "should emit [TopRatedMovieLoading, TopRatedMovieError] when data is response successfully",
        build: () {
          when(mockGetTopRatedMovies.execute()).thenAnswer(
              (_) async => const Left(ServerFailure("Server Failure")));
          return topRatedMovieBloc;
        },
        act: (bloc) => bloc.add(FetchTopRatedMovieFromBloc()),
        expect: () {
          return [
            TopRatedMovieLoading(),
            const TopRatedMovieError("Server Failure"),
          ];
        },
        verify: (bloc) {
          verify(mockGetTopRatedMovies.execute());
        });
  });
}
