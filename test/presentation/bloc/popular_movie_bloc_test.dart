import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:k31_watch_flutter/common/failure_child/server_failure.dart';
import 'package:k31_watch_flutter/domain/entities/movie.dart';
import 'package:k31_watch_flutter/domain/use_case/get_popular_movies.dart';
import 'package:k31_watch_flutter/presentation/bloc/popular_movie_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_movie_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMovieBloc popularMovieBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMovieBloc = PopularMovieBloc(mockGetPopularMovies);
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

  group("Popular Movie Bloc", () {
    test('initial state should be initial state', () {
      expect(popularMovieBloc.state, PopularMovieInitial());
    });

    blocTest<PopularMovieBloc, PopularMovieState>(
      'Should emit [Loading, HasData] when data is rsponse successfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(<Movie>[tMovie]));
        return popularMovieBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovieFromBloc()),
      expect: () => [
        PopularMovieLoading(),
        PopularMovieHasData(<Movie>[tMovie]),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest("Should emit Loading and Error when get popular movie is failed",
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => const Left(ServerFailure("error")));
          return popularMovieBloc;
        },
        act: (bloc) => bloc.add(FetchPopularMovieFromBloc()),
        expect: () => [
              PopularMovieLoading(),
              const PopularMovieError("error"),
            ],
        verify: (bloc) {
          verify(mockGetPopularMovies.execute());
        });
  });
}
