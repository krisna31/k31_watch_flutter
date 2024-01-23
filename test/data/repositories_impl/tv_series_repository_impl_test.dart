import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:k31_watch_flutter/common/failure_child/connection_failure.dart';
import 'package:k31_watch_flutter/common/failure_child/database_failure.dart';
import 'package:k31_watch_flutter/common/failure_child/server_failure.dart';
import 'package:k31_watch_flutter/common/server_exception.dart';
import 'package:k31_watch_flutter/common/database_exception.dart';
import 'package:k31_watch_flutter/data/models/genre_model.dart';
import 'package:k31_watch_flutter/data/models/table_tv_series.dart';
import 'package:k31_watch_flutter/data/models/tv_series_model.dart';
import 'package:k31_watch_flutter/data/models/tv_series_model_detail.dart';
import 'package:k31_watch_flutter/data/repositories_impl/tv_series_repository_impl.dart';
import 'package:k31_watch_flutter/domain/entities/detail_tv_series.dart';
import 'package:k31_watch_flutter/domain/entities/genre.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesRemoteDataSource mockTvSeriesRemoteDataSource;
  late MockLocalDataTvSeriesSource mockLocalDataTvSeriesSource;

  setUp(() {
    mockTvSeriesRemoteDataSource = MockTvSeriesRemoteDataSource();
    mockLocalDataTvSeriesSource = MockLocalDataTvSeriesSource();
    repository = TvSeriesRepositoryImpl(
      remoteDataSource: mockTvSeriesRemoteDataSource,
      localDataSource: mockLocalDataTvSeriesSource,
    );
  });

  const testTvModel = TvSeriesModel(
    adult: false,
    backdropPath: '/path.jpg',
    firstAirDate: '2020-05-05',
    genreIds: [1, 2, 3, 4],
    id: 1,
    name: 'Name',
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'Original Name',
    overview: 'Overview',
    popularity: 1.0,
    posterPath: '/path.jpg',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final testTvSeries = TvSeries(
    adult: false,
    backdropPath: '/path.jpg',
    firstAirDate: '2020-05-05',
    genreIds: const [1, 2, 3, 4],
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
  );

  final testTvModelList = <TvSeriesModel>[testTvModel];
  final testTVList = <TvSeries>[testTvSeries];

  group('Now Playing Tv Series', () {
    test(
        'should return remote data when the call to remote data source is success',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.getNowPlayingTvSeries())
          .thenAnswer((_) async => testTvModelList);

      // act
      final result = await repository.getNowPlayingTvSeries();

      // assert
      verify(mockTvSeriesRemoteDataSource.getNowPlayingTvSeries());
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTVList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.getNowPlayingTvSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getNowPlayingTvSeries();
      // assert
      verify(mockTvSeriesRemoteDataSource.getNowPlayingTvSeries());
      expect(result, equals(const Left(ServerFailure('ServerFailure 500'))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.getNowPlayingTvSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getNowPlayingTvSeries();
      // assert
      verify(mockTvSeriesRemoteDataSource.getNowPlayingTvSeries());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular Tv Series', () {
    test('should return tv  series list when call to data source is success',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.getPopularTvSeries())
          .thenAnswer((_) async => testTvModelList);
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTVList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.getPopularTvSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      expect(result, const Left(ServerFailure('ServerFailure 500')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.getPopularTvSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated Tv Series', () {
    test('should return tv  series list when call to data source is successful',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.getTopRatedTvSeries())
          .thenAnswer((_) async => testTvModelList);
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTVList);
    });

    test(
        'should return ServerFailure wServerFailure 500hen call to data source is unsuccessful',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      expect(result, const Left(ServerFailure('ServerFailure 500')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Tv Series Detail', () {
    const testIdTvSeries = 1;
    const testTvDetail = TvSeriesModelDetail(
      adult: false,
      backdropPath: '/path.jpg',
      episodeRunTime: [1, 2, 3],
      firstAirDate: '2020-05-05',
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: 'https://google.com',
      id: 1,
      inProduction: false,
      languages: ['en'],
      lastAirDate: '2020-05-05',
      name: 'Name',
      nextEpisodeToAir: null,
      numberOfEpisodes: 1,
      numberOfSeasons: 1,
      originCountry: ['US'],
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

    test(
        'should return Tv Series data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.getDetailTvSeries(testIdTvSeries))
          .thenAnswer((_) async => testTvDetail);
      // act
      final result = await repository.getDetailTvSeries(testIdTvSeries);
      // assert
      verify(mockTvSeriesRemoteDataSource.getDetailTvSeries(testIdTvSeries));
      expect(
        result,
        equals(
          Right(
            DetailTvSeries(
              adult: false,
              backdropPath: '/path.jpg',
              episodeRunTime: const [1, 2, 3],
              firstAirDate: '2020-05-05',
              genres: const [Genre(id: 1, name: 'Action')],
              homepage: 'https://google.com',
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
            ),
          ),
        ),
      );
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.getDetailTvSeries(testIdTvSeries))
          .thenThrow(ServerException());
      // act
      final result = await repository.getDetailTvSeries(testIdTvSeries);
      // assert
      verify(mockTvSeriesRemoteDataSource.getDetailTvSeries(testIdTvSeries));
      expect(result, equals(const Left(ServerFailure('ServerFailure 500'))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.getDetailTvSeries(testIdTvSeries))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getDetailTvSeries(testIdTvSeries);
      // assert
      verify(mockTvSeriesRemoteDataSource.getDetailTvSeries(testIdTvSeries));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Tv Series Recommendations', () {
    final testTvSeriesList =
        <TvSeriesModel>[]; // Adjust the type based on your implementation
    const tId = 1;

    test('should return data (tv series list) when the call is successful',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.getRecommendationsTvSeries(tId))
          .thenAnswer((_) async => testTvSeriesList);
      // act
      final result = await repository.getRecommendationsTvSeries(tId);
      // assert
      verify(mockTvSeriesRemoteDataSource.getRecommendationsTvSeries(tId));
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(testTvSeriesList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.getRecommendationsTvSeries(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getRecommendationsTvSeries(tId);
      // assertbuild runner
      verify(mockTvSeriesRemoteDataSource.getRecommendationsTvSeries(tId));
      expect(result, equals(const Left(ServerFailure('ServerFailure 500'))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.getRecommendationsTvSeries(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getRecommendationsTvSeries(tId);
      // assert
      verify(mockTvSeriesRemoteDataSource.getRecommendationsTvSeries(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach Tv Series', () {
    const tQuery = 'spiderman';

    test('should return tv  series list when call to data source is successful',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.searchTvSeries(tQuery))
          .thenAnswer((_) async => testTvModelList);
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTVList);
    });

    test(
        'should return ServerFailure wServerFailure 500hen call to data source is unsuccessful',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.searchTvSeries(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      expect(result, const Left(ServerFailure('ServerFailure 500')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.searchTvSeries(tQuery))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    const testTvSeriesTable = TableTvSeries(
      id: 1,
      name: 'Name',
      overview: 'Overview',
      posterPath: '/path.jpg',
    );

    final testTvDetail = DetailTvSeries(
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

    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataTvSeriesSource.insertWatchlist(testTvSeriesTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlistTv(testTvDetail);
      // assert
      expect(result, const Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataTvSeriesSource.insertWatchlist(testTvSeriesTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlistTv(testTvDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    const testTvSeriesTable = TableTvSeries(
      id: 1,
      name: 'Name',
      overview: 'Overview',
      posterPath: '/path.jpg',
    );

    final testTvDetail = DetailTvSeries(
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
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataTvSeriesSource.removeWatchlist(testTvSeriesTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlistTv(testTvDetail);
      // assert
      expect(result, const Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataTvSeriesSource.removeWatchlist(testTvSeriesTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlistTv(testTvDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      const tId = 1;
      when(mockLocalDataTvSeriesSource.getTvById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlistTv(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist tv  seriess', () {
    const testTvSeriesTable = TableTvSeries(
      id: 1,
      name: 'Name',
      overview: 'Overview',
      posterPath: '/path.jpg',
    );

    final testWatchlisTvSeries = TvSeries.watchlist(
      id: 1,
      name: 'Name',
      overview: 'Overview',
      posterPath: '/path.jpg',
    );
    test('should return list of Tv Series', () async {
      // arrange
      when(mockLocalDataTvSeriesSource.getWatchlistTv())
          .thenAnswer((_) async => [testTvSeriesTable]);
      // act
      final result = await repository.getWatchlistTvSeries();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlisTvSeries]);
    });
  });
}
