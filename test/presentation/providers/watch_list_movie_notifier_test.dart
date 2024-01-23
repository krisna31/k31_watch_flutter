import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:k31_watch_flutter/common/failure_child/database_failure.dart';
import 'package:k31_watch_flutter/common/request_state.dart';
import 'package:k31_watch_flutter/domain/use_case/get_watch_list_movies.dart';
import 'package:k31_watch_flutter/presentation/providers/watch_list_movie_notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_object.dart';
import 'watch_list_movie_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late WatchlistMovieNotifier provider;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    provider = WatchlistMovieNotifier(
      getWatchlistMovies: mockGetWatchlistMovies,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetWatchlistMovies.execute())
        .thenAnswer((_) async => Right([testWatchlistMovie]));
    // act
    await provider.fetchWatchlistMovies();
    // assert
    expect(provider.watchlistState, RequestState.loaded);
    expect(provider.watchlistMovies, [testWatchlistMovie]);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetWatchlistMovies.execute())
        .thenAnswer((_) async => const Left(DatabaseFailure("Can't get data")));
    // act
    await provider.fetchWatchlistMovies();
    // assert
    expect(provider.watchlistState, RequestState.error);
    expect(provider.message, "Can't get data");
    expect(listenerCallCount, 2);
  });
}
