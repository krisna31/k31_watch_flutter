import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:k31_watch_flutter/common/failure_child/server_failure.dart';
import 'package:k31_watch_flutter/domain/entities/movie.dart';
import 'package:k31_watch_flutter/domain/use_case/get_now_playing_movies.dart';
import 'package:k31_watch_flutter/presentation/bloc/now_playing_movie_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'now_playing_movie_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late NowPlayingMovieBloc nowPlayingMovieBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMovieBloc = NowPlayingMovieBloc(mockGetNowPlayingMovies);
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

  group("Now Playing Movie Bloc", () {
    test('initial state should be initial state', () {
      expect(nowPlayingMovieBloc.state, NowPlayingMovieInitial());
    });

    blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
      'Should emit [Loading, HasData] when data is rsponse successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(<Movie>[tMovie]));
        return nowPlayingMovieBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMovieFromBloc()),
      expect: () => [
        NowPlayingMovieLoading(),
        NowPlayingMovieHasData(<Movie>[tMovie]),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
      'Should emit [Loading, Error] when data is rsponse successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => const Left(ServerFailure("error")));
        return nowPlayingMovieBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMovieFromBloc()),
      expect: () => [
        NowPlayingMovieLoading(),
        const NowPlayingMovieError("error"),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });
}
