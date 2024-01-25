import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:k31_watch_flutter/common/failure_child/server_failure.dart';
import 'package:k31_watch_flutter/domain/entities/movie.dart';
import 'package:k31_watch_flutter/domain/use_case/get_movie_recommendations.dart';
import 'package:k31_watch_flutter/presentation/bloc/movie_recommendations_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_recommendations_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MovieRecommendationsBloc bloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    bloc = MovieRecommendationsBloc(mockGetMovieRecommendations);
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
  final tMovies = <Movie>[tMovie];

  group('Get Movie Recommendation Bloc', () {
    test('initial state is Initial', () {
      expect(bloc.state, MovieRecommendationsInitial());
    });

    blocTest(
      'should emit [Loading, HasData] when data is rsponse successfully',
      build: () {
        when(mockGetMovieRecommendations.execute(1))
            .thenAnswer((_) async => Right(tMovies));
        return bloc;
      },
      act: (bloc) => bloc.add(const FetchMovieRecommendationsFromBloc(1)),
      expect: () => [
        MovieRecommendationsLoading(),
        MovieRecommendationsHasData(tMovies),
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(1));
      },
    );

    blocTest(
      'should emit [Loading, Error] when data is rsponse successfully',
      build: () {
        when(mockGetMovieRecommendations.execute(1))
            .thenAnswer((_) async => const Left(ServerFailure('error')));
        return bloc;
      },
      act: (bloc) => bloc.add(const FetchMovieRecommendationsFromBloc(1)),
      expect: () => [
        MovieRecommendationsLoading(),
        const MovieRecommendationsError('error'),
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(1));
      },
    );
  });
}
