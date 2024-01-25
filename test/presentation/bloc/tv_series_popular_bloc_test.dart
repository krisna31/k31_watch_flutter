import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:k31_watch_flutter/common/failure_child/server_failure.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/get_popular_tv_series.dart';
import 'package:k31_watch_flutter/presentation/bloc/tv_series_popular_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late TvSeriesPopularBloc tvSeriesPopularBloc;
  late MockGetPopularTvSeries mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularTvSeries();
    tvSeriesPopularBloc = TvSeriesPopularBloc(mockGetPopularMovies);
  });

  final tTvSeriesList = <TvSeries>[
    TvSeries(
      adult: false,
      backdropPath: '/path.jpg',
      genreIds: const [1, 2, 3],
      firstAirDate: '2020-05-05',
      originCountry: const ['US'],
      originalLanguage: 'en',
      originalName: 'Original Name',
      popularity: 1,
      voteCount: 1,
      id: 1,
      name: 'Breaking Bad',
      overview: 'overview',
      posterPath: '/path.jpg',
      voteAverage: 1,
    ),
  ];

  group("Popular Tv Series Bloc", () {
    test('initial state should be initial state', () {
      expect(tvSeriesPopularBloc.state, TvSeriesPopularInitial());
    });

    blocTest<TvSeriesPopularBloc, TvSeriesPopularState>(
      'Should emit [Loading, HasData] when data is rsponse successfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return tvSeriesPopularBloc;
      },
      act: (bloc) => bloc.add(FetchTvSeriesPopularEvent()),
      expect: () => [
        TvSeriesPopularLoading(),
        TvSeriesPopularHasData(tTvSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest("Should emit Loading and Error when get popular movie is failed",
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => const Left(ServerFailure("error")));
          return tvSeriesPopularBloc;
        },
        act: (bloc) => bloc.add(FetchTvSeriesPopularEvent()),
        expect: () => [
              TvSeriesPopularLoading(),
              const TvSeriesPopularError("error"),
            ],
        verify: (bloc) {
          verify(mockGetPopularMovies.execute());
        });
  });
}
