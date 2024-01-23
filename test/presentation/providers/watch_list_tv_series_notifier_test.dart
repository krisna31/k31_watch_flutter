import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:k31_watch_flutter/common/failure_child/server_failure.dart';
import 'package:k31_watch_flutter/common/request_state.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/get_watch_list_tv.dart';
import 'package:k31_watch_flutter/presentation/providers/watch_list_tv_series_notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watch_list_tv_series_notifier_test.mocks.dart';

@GenerateMocks([
  GetWatchlistTv,
])
void main() {
  late WatchlistTvSeriesNotifier notifier;
  late MockGetWatchlistTv mockGetWatchlistTv;
  late int listenerCallCount;
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

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistTv = MockGetWatchlistTv();
    notifier = WatchlistTvSeriesNotifier(
      getWatchlistTv: mockGetWatchlistTv,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  group('Watchlist TV Series', () {
    test('should get data from the use case', () async {
      // arrange
      when(mockGetWatchlistTv.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      await notifier.fetchWatchlistTvSeriess();
      // assert
      verify(mockGetWatchlistTv.execute());
    });

    test('should change state to loading when use case is called', () {
      // arrange
      when(mockGetWatchlistTv.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      notifier.fetchWatchlistTvSeriess();
      // assert
      expect(notifier.watchlistState, RequestState.loading);
      expect(listenerCallCount, 1);
    });

    test('should change watchlist TV series when data is fetched successfully',
        () async {
      // arrange
      when(mockGetWatchlistTv.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      await notifier.fetchWatchlistTvSeriess();
      // assert
      expect(notifier.watchlistState, RequestState.loaded);
      expect(notifier.watchlistTvSeriess, tTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should update error message when data fetching is unsuccessful',
        () async {
      // arrange
      when(mockGetWatchlistTv.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Failed')));
      // act
      await notifier.fetchWatchlistTvSeriess();
      // assert
      expect(notifier.watchlistState, RequestState.error);
      expect(notifier.message, 'Failed');
      expect(listenerCallCount, 2);
    });
  });
}
