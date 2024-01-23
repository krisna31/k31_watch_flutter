import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:k31_watch_flutter/domain/entities/detail_tv_series.dart';
import 'package:k31_watch_flutter/domain/entities/genre.dart';
import 'package:k31_watch_flutter/domain/use_case/save_watch_list_tv.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  final repository = MockTvSeriesRepository();
  final useCase = SaveWatchlistTv(repository);
  final detailTvSeries = DetailTvSeries(
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

  test('should get detail tv series after called execute', () async {
    // arrange
    when(repository.saveWatchlistTv(detailTvSeries))
        .thenAnswer((_) async => const Right("Added To Tv Series Watchlist"));
    // act
    final result = await useCase.execute(detailTvSeries);
    // assert
    expect(result, const Right("Added To Tv Series Watchlist"));
    verify(repository.saveWatchlistTv(detailTvSeries));
    verifyNoMoreInteractions(repository);
  });
}
