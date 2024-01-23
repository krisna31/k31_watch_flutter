import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:k31_watch_flutter/common/failure_child/server_failure.dart';
import 'package:k31_watch_flutter/common/request_state.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/search_tv.dart';
import 'package:k31_watch_flutter/presentation/providers/search_tv_notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_tv_notifier_test.mocks.dart';

@GenerateMocks([SearchTv])
void main() {
  late SearchTvNotifier notifier;
  late MockSearchTv mockSearchTv;
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
    mockSearchTv = MockSearchTv();
    notifier = SearchTvNotifier(searchTv: mockSearchTv)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  group('Search TV', () {
    test('should get data from the use case', () async {
      // arrange
      const tQuery = 'Breaking Bad';
      when(mockSearchTv.execute(tQuery))
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      await notifier.fetchTvSearchFromNotifier(tQuery);
      // assert
      verify(mockSearchTv.execute(tQuery));
    });

    test('should change state to loading when use case is called', () {
      // arrange
      const tQuery = 'Breaking Bad';
      when(mockSearchTv.execute(tQuery))
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      notifier.fetchTvSearchFromNotifier(tQuery);
      // assert
      expect(notifier.state, RequestState.loading);
      expect(listenerCallCount, 1);
    });

    test('should change search result when data is fetched successfully',
        () async {
      // arrange
      const tQuery = 'Breaking Bad';
      when(mockSearchTv.execute(tQuery))
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      await notifier.fetchTvSearchFromNotifier(tQuery);
      // assert
      expect(notifier.state, RequestState.loaded);
      expect(notifier.searchResult, tTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should update error message when data fetching is unsuccessful',
        () async {
      // arrange
      const tQuery = 'Breaking Bad';
      when(mockSearchTv.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Failed')));
      // act
      await notifier.fetchTvSearchFromNotifier(tQuery);
      // assert
      expect(notifier.state, RequestState.error);
      expect(notifier.message, 'Failed');
      expect(listenerCallCount, 2);
    });
  });
}
