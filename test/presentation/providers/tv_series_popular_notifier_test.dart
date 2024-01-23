import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:k31_watch_flutter/common/failure_child/server_failure.dart';
import 'package:k31_watch_flutter/common/request_state.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/get_popular_tv_series.dart';
import 'package:k31_watch_flutter/presentation/providers/tv_series_popular_notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_popular_notifier_test.mocks.dart';

@GenerateMocks([
  GetPopularTvSeries,
])
void main() {
  late TvSeriesPopularNotifier notifier;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
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
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    notifier =
        TvSeriesPopularNotifier(getPopularTvSeries: mockGetPopularTvSeries)
          ..addListener(() {
            listenerCallCount += 1;
          });
  });

  group('Popular TV Series', () {
    test('should get data from the use case', () async {
      // arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      await notifier.fetchPopularTvSeriesFromNotifier();
      // assert
      verify(mockGetPopularTvSeries.execute());
    });

    test('should change state to loading when use case is called', () {
      // arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      notifier.fetchPopularTvSeriesFromNotifier();
      // assert
      expect(notifier.popularTvSeriesState, RequestState.loading);
      expect(listenerCallCount, 1);
    });

    test('should change popular TV series when data is fetched successfully',
        () async {
      // arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      await notifier.fetchPopularTvSeriesFromNotifier();
      // assert
      expect(notifier.popularTvSeriesState, RequestState.loaded);
      expect(notifier.popularTvSeries, tTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should update error message when data fetching is unsuccessful',
        () async {
      // arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Failed')));
      // act
      await notifier.fetchPopularTvSeriesFromNotifier();
      // assert
      expect(notifier.popularTvSeriesState, RequestState.error);
      expect(notifier.message, 'Failed');
      expect(listenerCallCount, 2);
    });
  });
}
