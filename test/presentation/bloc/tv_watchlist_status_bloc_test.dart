import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:k31_watch_flutter/common/failure_child/database_failure.dart';
import 'package:k31_watch_flutter/domain/entities/detail_tv_series.dart';
import 'package:k31_watch_flutter/domain/entities/genre.dart';
import 'package:k31_watch_flutter/domain/use_case/get_watch_list_status_tv.dart';
import 'package:k31_watch_flutter/domain/use_case/remove_watch_list_tv.dart';
import 'package:k31_watch_flutter/domain/use_case/save_watch_list_tv.dart';
import 'package:k31_watch_flutter/presentation/bloc/tv_watchlist_status_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_watchlist_status_bloc_test.mocks.dart';

@GenerateMocks([GetWatchListStatusTv, SaveWatchlistTv, RemoveWatchlistTv])
void main() {
  late TvWatchlistStatusBloc tvWatchlistStatusBloc;
  late MockGetWatchListStatusTv mockGetWatchListStatusTv;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;

  setUp(() {
    mockGetWatchListStatusTv = MockGetWatchListStatusTv();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    tvWatchlistStatusBloc = TvWatchlistStatusBloc(
      getWatchListStatus: mockGetWatchListStatusTv,
      saveWatchlistTv: mockSaveWatchlistTv,
      removeWatchlistTv: mockRemoveWatchlistTv,
    );
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

  group("Tv WatchList Bloc", () {
    test('initial state should be initial state', () {
      expect(tvWatchlistStatusBloc.state, TvWatchlistStatusInitial());
    });

    blocTest<TvWatchlistStatusBloc, TvWatchlistStatusState>(
      'Should emit [Loading, StatusLoaded] no db error',
      build: () {
        when(mockGetWatchListStatusTv.execute(tId))
            .thenAnswer((_) async => true);
        return tvWatchlistStatusBloc;
      },
      act: (bloc) => bloc.add(const FetchTvWatchlistStatusEvent(id: tId)),
      expect: () => [
        TvWatchlistStatusLoading(),
        const TvWatchlistStatusLoaded(isAdded: true, message: ''),
      ],
      verify: (bloc) {
        verify(mockGetWatchListStatusTv.execute(tId));
      },
    );

    blocTest<TvWatchlistStatusBloc, TvWatchlistStatusState>(
      'Should emit [TvWatchlistStatusLoading, TvWatchlistStatusLoaded] no db error',
      build: () {
        when(mockSaveWatchlistTv.execute(tDetailTvSeries))
            .thenAnswer((_) async => const Right("Success"));
        return tvWatchlistStatusBloc;
      },
      act: (bloc) => bloc.add(AddTvWatchlistEvent(tvSeries: tDetailTvSeries)),
      expect: () => [
        TvWatchlistStatusLoading(),
        const TvWatchlistStatusLoaded(isAdded: true, message: 'Success'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistTv.execute(tDetailTvSeries));
      },
    );

    blocTest<TvWatchlistStatusBloc, TvWatchlistStatusState>(
      'Should emit [Loading, Error] no db error',
      build: () {
        when(mockSaveWatchlistTv.execute(tDetailTvSeries))
            .thenAnswer((_) async => const Left(DatabaseFailure('Error')));
        return tvWatchlistStatusBloc;
      },
      act: (bloc) => bloc.add(AddTvWatchlistEvent(tvSeries: tDetailTvSeries)),
      expect: () => [
        TvWatchlistStatusLoading(),
        const TvWatchlistStatusLoaded(isAdded: false, message: 'Error'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistTv.execute(tDetailTvSeries));
      },
    );

    blocTest<TvWatchlistStatusBloc, TvWatchlistStatusState>(
      'Should emit [TvWatchlistStatusLoading, TvWatchlistStatusLoaded] no db error',
      build: () {
        when(mockRemoveWatchlistTv.execute(tDetailTvSeries))
            .thenAnswer((_) async => const Right("Success"));
        return tvWatchlistStatusBloc;
      },
      act: (bloc) =>
          bloc.add(RemoveTvWatchlistEvent(tvSeries: tDetailTvSeries)),
      expect: () => [
        TvWatchlistStatusLoading(),
        const TvWatchlistStatusLoaded(isAdded: false, message: 'Success'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistTv.execute(tDetailTvSeries));
      },
    );

    blocTest<TvWatchlistStatusBloc, TvWatchlistStatusState>(
      'Should emit [Loading, Error] no db error',
      build: () {
        when(mockRemoveWatchlistTv.execute(tDetailTvSeries))
            .thenAnswer((_) async => const Left(DatabaseFailure('Error')));
        return tvWatchlistStatusBloc;
      },
      act: (bloc) =>
          bloc.add(RemoveTvWatchlistEvent(tvSeries: tDetailTvSeries)),
      expect: () => [
        TvWatchlistStatusLoading(),
        const TvWatchlistStatusLoaded(isAdded: true, message: 'Error'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistTv.execute(tDetailTvSeries));
      },
    );
  });
}
