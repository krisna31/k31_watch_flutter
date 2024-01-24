import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:k31_watch_flutter/common/failure_child/server_failure.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/get_recommendations_tv_series.dart';
import 'package:k31_watch_flutter/presentation/bloc/tv_recommendations_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_recommendations_bloc_test.mocks.dart';

@GenerateMocks([GetRecommendationsTvSeries])
void main() {
  late TvRecommendationsBloc tvRecommendationsBloc;
  late MockGetRecommendationsTvSeries mockGetRecommendationsTvSeries;

  setUp(() {
    mockGetRecommendationsTvSeries = MockGetRecommendationsTvSeries();
    tvRecommendationsBloc =
        TvRecommendationsBloc(mockGetRecommendationsTvSeries);
  });

  const tId = 1;
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

  group("Tv Recomendation Bloc", () {
    test('initial state should be initial state', () {
      expect(tvRecommendationsBloc.state, TvRecommendationsInitial());
    });

    blocTest<TvRecommendationsBloc, TvRecommendationsState>(
      'Should emit [Loading, HasData] when data is rsponse successfully',
      build: () {
        when(mockGetRecommendationsTvSeries.execute(tId))
            .thenAnswer((_) async => Right(tTvSeriesList));
        return tvRecommendationsBloc;
      },
      act: (bloc) => bloc.add(const FetchTvRecommendationsEvent(id: tId)),
      expect: () => [
        TvRecommendationsLoading(),
        TvRecommendationsHasData(tvSeries: tTvSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetRecommendationsTvSeries.execute(tId));
      },
    );

    blocTest<TvRecommendationsBloc, TvRecommendationsState>(
        "Should emit Loading and Error when get search tv is failed",
        build: () {
          when(mockGetRecommendationsTvSeries.execute(tId)).thenAnswer(
            (_) async => const Left(
              ServerFailure("500 Internal Error"),
            ),
          );
          return tvRecommendationsBloc;
        },
        act: (bloc) => bloc.add(const FetchTvRecommendationsEvent(id: tId)),
        expect: () {
          return [
            TvRecommendationsLoading(),
            const TvRecommendationsError(message: "500 Internal Error"),
          ];
        },
        verify: (bloc) {
          verify(mockGetRecommendationsTvSeries.execute(tId));
        });
  });
}
