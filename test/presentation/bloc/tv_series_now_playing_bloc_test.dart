import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:k31_watch_flutter/common/failure_child/server_failure.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/get_now_playing_tv_series.dart';
import 'package:k31_watch_flutter/presentation/bloc/tv_series_now_playing_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvSeries])
void main() {
  late TvSeriesNowPlayingBloc tvSeriesNowPlayingBloc;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;

  setUp(() {
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    tvSeriesNowPlayingBloc = TvSeriesNowPlayingBloc(mockGetNowPlayingTvSeries);
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

  group("Now Playing Tv Bloc", () {
    test('initial state should be initial state', () {
      expect(tvSeriesNowPlayingBloc.state, TvSeriesNowPlayingInitial());
    });

    blocTest<TvSeriesNowPlayingBloc, TvSeriesNowPlayingState>(
      'Should emit [Loading, HasData] when data is rsponse successfully',
      build: () {
        when(mockGetNowPlayingTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return tvSeriesNowPlayingBloc;
      },
      act: (bloc) => bloc.add(FetchTvSeriesNowPlayingEvent()),
      expect: () => [
        TvSeriesNowPlayingLoading(),
        TvSeriesNowPlayingHasData(tTvSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingTvSeries.execute());
      },
    );

    blocTest<TvSeriesNowPlayingBloc, TvSeriesNowPlayingState>(
      'Should emit [Loading, Error] when data is rsponse successfully',
      build: () {
        when(mockGetNowPlayingTvSeries.execute())
            .thenAnswer((_) async => const Left(ServerFailure("error")));
        return tvSeriesNowPlayingBloc;
      },
      act: (bloc) => bloc.add(FetchTvSeriesNowPlayingEvent()),
      expect: () => [
        TvSeriesNowPlayingLoading(),
        const TvSeriesNowPlayingError("error"),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingTvSeries.execute());
      },
    );
  });
}
