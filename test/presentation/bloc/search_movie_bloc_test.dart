import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:k31_watch_flutter/common/failure_child/server_failure.dart';
import 'package:k31_watch_flutter/domain/entities/movie.dart';
import 'package:k31_watch_flutter/domain/use_case/search_movies.dart';
import 'package:k31_watch_flutter/presentation/bloc/search_movie_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_movie_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late SearchMovieBloc searchMovieBloc;
  late MockSearchMovies mockSearchMovie;

  setUp(() {
    mockSearchMovie = MockSearchMovies();
    searchMovieBloc = SearchMovieBloc(mockSearchMovie);
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
  final tMovieList = <Movie>[tMovie];
  const String tQuery = 'open';

  group("Search Movie Bloc", () {
    test('initial state should be initial state', () {
      expect(searchMovieBloc.state, SearchMovieInitial());
    });

    blocTest<SearchMovieBloc, SearchMovieState>(
      'Should emit [Loading, HasData] when data is rsponse successfully',
      build: () {
        when(mockSearchMovie.execute(tQuery))
            .thenAnswer((_) async => Right(tMovieList));
        return searchMovieBloc;
      },
      act: (bloc) => bloc.add(const QuerySearchMovieFromBloc(tQuery)),
      wait: const Duration(milliseconds: 555),
      expect: () => [
        SearchMovieLoading(),
        SearchMovieHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockSearchMovie.execute(tQuery));
      },
    );

    blocTest("Should emit Loading and Error when get search tv is failed",
        build: () {
          when(mockSearchMovie.execute(tQuery)).thenAnswer(
            (_) async => const Left(
              ServerFailure("500 Internal Error"),
            ),
          );
          return searchMovieBloc;
        },
        act: (bloc) => bloc.add(const QuerySearchMovieFromBloc(tQuery)),
        wait: const Duration(milliseconds: 555),
        expect: () {
          return [
            SearchMovieLoading(),
            const SearchMovieError("500 Internal Error"),
          ];
        },
        verify: (bloc) {
          verify(mockSearchMovie.execute(tQuery));
        });
  });
}
