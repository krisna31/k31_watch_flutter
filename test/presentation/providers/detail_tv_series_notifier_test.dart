import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:k31_watch_flutter/common/failure_child/server_failure.dart';
import 'package:k31_watch_flutter/common/request_state.dart';
import 'package:k31_watch_flutter/domain/entities/detail_tv_series.dart';
import 'package:k31_watch_flutter/domain/entities/genre.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/get_detail_tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/get_recommendations_tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/get_watch_list_status_tv.dart';
import 'package:k31_watch_flutter/domain/use_case/remove_watch_list_tv.dart';
import 'package:k31_watch_flutter/domain/use_case/save_watch_list_tv.dart';
import 'package:k31_watch_flutter/presentation/providers/detail_tv_series_notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'detail_tv_series_notifier_test.mocks.dart';

@GenerateMocks([
  GetDetailTvSeries,
  GetRecommendationsTvSeries,
  GetWatchListStatusTv,
  SaveWatchlistTv,
  RemoveWatchlistTv,
])
void main() {
  late DetailTvSeriesNotifier provider;
  late MockGetDetailTvSeries mockGetDetailTvSeries;
  late MockGetRecommendationsTvSeries mockGetRecommendationsTvSeries;
  late MockGetWatchListStatusTv mockGetWatchListStatusTv;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetDetailTvSeries = MockGetDetailTvSeries();
    mockGetRecommendationsTvSeries = MockGetRecommendationsTvSeries();
    mockGetWatchListStatusTv = MockGetWatchListStatusTv();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    provider = DetailTvSeriesNotifier(
      removeWatchlistTv: mockRemoveWatchlistTv,
      getRecommendationsTvSeries: mockGetRecommendationsTvSeries,
      getWatchListStatusTv: mockGetWatchListStatusTv,
      saveWatchlistTv: mockSaveWatchlistTv,
      getDetailTvSeries: mockGetDetailTvSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  const tId = 1;

  final tDetailTvSeries = DetailTvSeries(
    adult: false,
    backdropPath: '/path.jpg',
    episodeRunTime: const [1, 2, 3],
    firstAirDate: '2020-05-05',
    genres: const [Genre(id: 1, name: 'Action')],
    homepage: 'https://k31.my.id',
    id: 1,
    inProduction: false,
    languages: const ['en'],
    lastAirDate: '2020-05-05',
    name: 'Name',
    nextEpisodeToAir: null,
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originCountry: const ['US'],
    originalLanguage: 'en',
    originalName: 'Original Name',
    overview: 'Overview',
    popularity: 1.0,
    posterPath: '/path.jpg',
    status: 'Status',
    tagline: 'Tagline',
    type: 'Type',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final List<TvSeries> tTvSeriesList = <TvSeries>[
    TvSeries(
      adult: false,
      backdropPath: '/path.jpg',
      firstAirDate: '2020-05-05',
      genreIds: const [1],
      id: 1,
      name: 'Name',
      originCountry: const ['US'],
      originalLanguage: 'en',
      originalName: 'Original Name',
      overview: 'Overview',
      popularity: 1.0,
      posterPath: '/path.jpg',
      voteAverage: 1.0,
      voteCount: 1,
    )
  ];

  void mockUseCase() {
    when(mockGetDetailTvSeries.execute(tId))
        .thenAnswer((_) async => Right(tDetailTvSeries));
    when(mockGetRecommendationsTvSeries.execute(tId))
        .thenAnswer((_) async => Right(tTvSeriesList));
  }

  group('Get TV Series Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      mockUseCase();
      // act
      await provider.fetchDetailTvSeries(tId);
      // assert
      verify(mockGetDetailTvSeries.execute(tId));
      verify(mockGetRecommendationsTvSeries.execute(tId));
    });

    test('should change state to loading when usecase is called', () {
      // arrange
      mockUseCase();
      // act
      provider.fetchDetailTvSeries(tId);
      // assert
      expect(provider.tvSeriesState, RequestState.loading);
      expect(listenerCallCount, 1);
    });

    test('should change TV Series detail when data is fetched successfully',
        () async {
      // arrange
      mockUseCase();
      // act
      await provider.fetchDetailTvSeries(tId);
      // assert
      expect(provider.tvSeriesState, RequestState.loaded);
      expect(provider.tvSeries, tDetailTvSeries);
      expect(listenerCallCount, 3);
    });

    test(
        'should change recommendation TV Series when data is fetched successfully',
        () async {
      // arrange
      mockUseCase();
      // act
      await provider.fetchDetailTvSeries(tId);
      // assert
      expect(provider.tvSeriesState, RequestState.loaded);
      expect(provider.recommendationState, RequestState.loaded);
      expect(provider.recommendationsTvSEries, tTvSeriesList);
    });
  });

  group('Get TV Series Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      mockUseCase();
      // act
      await provider.fetchDetailTvSeries(tId);
      // assert
      verify(mockGetRecommendationsTvSeries.execute(tId));
      expect(provider.recommendationsTvSEries, tTvSeriesList);
    });

    test('should update recommendation state when data is fetched successfully',
        () async {
      // arrange
      mockUseCase();
      // act
      await provider.fetchDetailTvSeries(tId);
      // assert
      expect(provider.recommendationState, RequestState.loaded);
      expect(provider.recommendationsTvSEries, tTvSeriesList);
    });

    test('should update error message when request is unsuccessful', () async {
      // arrange
      when(mockGetDetailTvSeries.execute(tId))
          .thenAnswer((_) async => Right(tDetailTvSeries));
      when(mockGetRecommendationsTvSeries.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Failed')));
      // act
      await provider.fetchDetailTvSeries(tId);
      // assert
      expect(provider.recommendationState, RequestState.error);
      expect(provider.message, 'Failed');
    });
  });
}
