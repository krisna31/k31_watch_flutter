import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:k31_watch_flutter/common/failure_child/database_failure.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/get_watch_list_tv.dart';
import 'package:k31_watch_flutter/presentation/bloc/watch_list_tv_series_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watch_list_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTv])
void main() {
  late WatchListTvSeriesBloc watchListTvSeriesBloc;
  late MockGetWatchlistTv mockGetWatchlistTv;

  setUp(() {
    mockGetWatchlistTv = MockGetWatchlistTv();
    watchListTvSeriesBloc = WatchListTvSeriesBloc(mockGetWatchlistTv);
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

  group("Watch List TV SEries Bloc", () {
    test('initial state should be initial state', () {
      expect(watchListTvSeriesBloc.state, WatchListTvSeriesInitial());
    });

    blocTest(
      'Should emit [Loading, HasData] when data is rsponse successfully',
      build: () {
        when(mockGetWatchlistTv.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return watchListTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchWatchListTvSeriesEvent()),
      expect: () => [
        WatchListTvSeriesLoading(),
        WatchListTvSeriesHasData(tTvSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTv.execute());
      },
    );

    blocTest(
      'Should emit [Loading, Error] when data is rsponse successfully',
      build: () {
        when(mockGetWatchlistTv.execute())
            .thenAnswer((_) async => const Left(DatabaseFailure("Error")));
        return watchListTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchWatchListTvSeriesEvent()),
      expect: () => [
        WatchListTvSeriesLoading(),
        const WatchListTvSeriesError("Error"),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTv.execute());
      },
    );
  });
}
