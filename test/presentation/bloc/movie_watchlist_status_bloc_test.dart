import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:k31_watch_flutter/common/failure_child/database_failure.dart';
import 'package:k31_watch_flutter/domain/use_case/get_watch_list_status.dart';
import 'package:k31_watch_flutter/domain/use_case/remove_watch_list.dart';
import 'package:k31_watch_flutter/domain/use_case/save_watch_list.dart';
import 'package:k31_watch_flutter/presentation/bloc/movie_watchlist_status_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_object.dart';
import 'movie_watchlist_status_bloc_test.mocks.dart';

@GenerateMocks([GetWatchListStatus, SaveWatchlist, RemoveWatchlist])
void main() {
  late MovieWatchlistStatusBloc movieWatchlistStatusBloc;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();

    movieWatchlistStatusBloc = MovieWatchlistStatusBloc(
      mockGetWatchListStatus,
      mockSaveWatchlist,
      mockRemoveWatchlist,
    );
  });

  const tId = 1;

  group("Movie WatchList Bloc", () {
    test('initial state should be initial state', () {
      expect(movieWatchlistStatusBloc.state, MovieWatchlistStatusInitial());
    });

    blocTest<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
      'Should emit [Loading, StatusLoaded] no db error',
      build: () {
        when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
        return movieWatchlistStatusBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieWatchlistStatusFromBloc(tId)),
      expect: () => [
        MovieWatchlistStatusLoading(),
        const MovieWatchlistStatusHasData(true, null),
      ],
      verify: (bloc) {
        verify(mockGetWatchListStatus.execute(tId));
      },
    );

    blocTest<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
      'Should emit [loading and hasdata] no db error',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right("Success"));
        return movieWatchlistStatusBloc;
      },
      act: (bloc) =>
          bloc.add(const AddMovieToWatchlistFromBloc(testMovieDetail)),
      expect: () => [
        MovieWatchlistStatusLoading(),
        const MovieWatchlistStatusHasData(true, 'Success'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
      'Should emit [Loading, Error] when db error',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Error')));
        return movieWatchlistStatusBloc;
      },
      act: (bloc) =>
          bloc.add(const AddMovieToWatchlistFromBloc(testMovieDetail)),
      expect: () => [
        MovieWatchlistStatusLoading(),
        const MovieWatchlistStatusHasData(false, 'Error'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
      'Should emit [loading and has data] no db error',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right("Success"));
        return movieWatchlistStatusBloc;
      },
      act: (bloc) =>
          bloc.add(const RemoveMovieFromWatchlistFromBloc(testMovieDetail)),
      expect: () => [
        MovieWatchlistStatusLoading(),
        const MovieWatchlistStatusHasData(false, 'Success'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
      'Should emit [Loading, Error] no db error',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Error')));
        return movieWatchlistStatusBloc;
      },
      act: (bloc) =>
          bloc.add(const RemoveMovieFromWatchlistFromBloc(testMovieDetail)),
      expect: () => [
        MovieWatchlistStatusLoading(),
        const MovieWatchlistStatusHasData(true, 'Error'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
      },
    );
  });
}
