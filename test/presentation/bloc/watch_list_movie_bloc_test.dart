import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:k31_watch_flutter/common/failure_child/database_failure.dart';
import 'package:k31_watch_flutter/domain/entities/movie.dart';
import 'package:k31_watch_flutter/domain/use_case/get_watch_list_movies.dart';
import 'package:k31_watch_flutter/presentation/bloc/watch_list_movie_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watch_list_movie_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late WatchListMovieBloc watchListMovieBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

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

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchListMovieBloc = WatchListMovieBloc(mockGetWatchlistMovies);
  });

  group("Watch List Movie Bloc", () {
    test('initial state should be initial state', () {
      expect(watchListMovieBloc.state, WatchListMovieInitial());
    });

    blocTest(
      'Should emit [Loading, HasData] when data is rsponse successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right(<Movie>[tMovie]));
        return watchListMovieBloc;
      },
      act: (bloc) => bloc.add(FetchWatchListMovieEvent()),
      expect: () => [
        WatchListMovieLoading(),
        WatchListMovieHasData(<Movie>[tMovie]),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );

    blocTest(
      'Should emit [Loading, Error] when data is rsponse successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => const Left(DatabaseFailure("Error")));
        return watchListMovieBloc;
      },
      act: (bloc) => bloc.add(FetchWatchListMovieEvent()),
      expect: () => [
        WatchListMovieLoading(),
        const WatchListMovieError("Error"),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );
  });
}
