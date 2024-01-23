import 'package:flutter_test/flutter_test.dart';
import 'package:k31_watch_flutter/common/database_exception.dart';
import 'package:k31_watch_flutter/data/datasources/local_data_tv_series_source.dart';
import 'package:k31_watch_flutter/data/models/table_tv_series.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

const tableTestTv = TableTvSeries(
  id: 1,
  name: 'Test Series',
  overview: 'Test Overview',
  posterPath: 'Test Poster Path',
);

const tableTestTvMap = {
  "id": 1,
  "name": "Test Series",
  "overview": "Test Overview",
  "posterPath": "Test Poster Path",
};

void main() {
  late LocalDataTvSourceImplementation localDataSource;
  late MockDbHelperTvSeries mockDbHelper;

  setUp(() {
    mockDbHelper = MockDbHelperTvSeries();
    localDataSource = LocalDataTvSourceImplementation(dbHelper: mockDbHelper);
  });

  group('insertWatchlist', () {
    test('should insert TV series into watchlist and return success message',
        () async {
      // Arrange
      when(mockDbHelper.insertTvSeriesToWatchlist(tableTestTv))
          .thenAnswer((_) async => 1);

      // Act
      final result = await localDataSource.insertWatchlist(tableTestTv);

      // Assert
      expect(result, 'Added to Tv Series Watchlist');
      verify(mockDbHelper.insertTvSeriesToWatchlist(tableTestTv));
    });

    test('should throw DatabaseException when an error occurs', () async {
      // Arrange
      when(mockDbHelper.insertTvSeriesToWatchlist(tableTestTv))
          .thenThrow(Exception('Some error'));

      // Act & Assert
      expect(() async => await localDataSource.insertWatchlist(tableTestTv),
          throwsA(isA<DatabaseException>()));
    });
  });

  group('removeWatchlist', () {
    test('should remove TV series from watchlist and return success message',
        () async {
      // Arrange
      when(mockDbHelper.removeTvSeriesFromWatchlist(tableTestTv))
          .thenAnswer((_) async => 1);

      // Act
      final result = await localDataSource.removeWatchlist(tableTestTv);

      // Assert
      expect(result, 'Removed from Tv Series Watchlist');
      verify(mockDbHelper.removeTvSeriesFromWatchlist(tableTestTv));
    });

    test('should throw DatabaseException when an error occurs', () async {
      // Arrange
      when(mockDbHelper.removeTvSeriesFromWatchlist(tableTestTv))
          .thenThrow(Exception('Some error'));

      // Act & Assert
      expect(() async => await localDataSource.removeWatchlist(tableTestTv),
          throwsA(isA<DatabaseException>()));
    });
  });

  group('getWatchlistTv', () {
    test('should return a list of TableTvSeries from the watchlist', () async {
      // Arrange
      final mockTvSeriesList = [
        {'id': 1, 'name': 'Test Series 1'},
        {'id': 2, 'name': 'Test Series 2'},
      ];
      when(mockDbHelper.getWatchlistTvSeries())
          .thenAnswer((_) async => mockTvSeriesList);

      // Act
      final result = await localDataSource.getWatchlistTv();

      // Assert
      final expectedList =
          mockTvSeriesList.map((data) => TableTvSeries.fromMap(data)).toList();
      expect(result, expectedList);
      verify(mockDbHelper.getWatchlistTvSeries());
    });
  });

  group('getTvById', () {
    test('should return TableTvSeries by ID from the database', () async {
      // Arrange
      when(mockDbHelper.getTvSeriesById(1))
          .thenAnswer((_) async => tableTestTvMap);

      // Act
      final result = await localDataSource.getTvById(1);

      // Assert
      expect(result, tableTestTv);
      verify(mockDbHelper.getTvSeriesById(1));
    });

    test('should return null if TV series with given ID is not found',
        () async {
      // Arrange
      when(mockDbHelper.getTvSeriesById(1))
          .thenAnswer((_) => Future.value(null));

      // Act
      final result = await localDataSource.getTvById(1);

      // Assert
      expect(result, null);
      verify(mockDbHelper.getTvSeriesById(1));
    });
  });
}
