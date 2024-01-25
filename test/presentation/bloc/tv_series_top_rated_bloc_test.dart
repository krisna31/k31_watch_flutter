import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:k31_watch_flutter/common/failure_child/server_failure.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/get_top_rated_tv_series.dart';
import 'package:k31_watch_flutter/presentation/bloc/tv_series_top_rated_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late TvSeriesTopRatedBloc tvSeriesTopRatedBloc;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    tvSeriesTopRatedBloc = TvSeriesTopRatedBloc(mockGetTopRatedTvSeries);
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

  group("Top Ratd Tv Series Bloc", () {
    test('initial state should be initial state', () {
      expect(tvSeriesTopRatedBloc.state, TvSeriesTopRatedInitial());
    });

    blocTest<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
      'Should emit [Loading, HasData] when data is rsponse successfully',
      build: () {
        when(mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return tvSeriesTopRatedBloc;
      },
      act: (bloc) => bloc.add(FetchTvSeriesTopRatedEvent()),
      expect: () => [
        TvSeriesTopRatedLoading(),
        TvSeriesTopRatedHasData(tTvSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTvSeries.execute());
      },
    );

    blocTest("Should emit Loading and Error when get popular movie is failed",
        build: () {
          when(mockGetTopRatedTvSeries.execute())
              .thenAnswer((_) async => const Left(ServerFailure("error")));
          return tvSeriesTopRatedBloc;
        },
        act: (bloc) => bloc.add(FetchTvSeriesTopRatedEvent()),
        expect: () => [
              TvSeriesTopRatedLoading(),
              const TvSeriesTopRatedError("error"),
            ],
        verify: (bloc) {
          verify(mockGetTopRatedTvSeries.execute());
        });
  });
}
