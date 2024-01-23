import 'package:flutter_test/flutter_test.dart';
import 'package:k31_watch_flutter/domain/entities/detail_tv_series.dart';

import 'package:dartz/dartz.dart';
import 'package:k31_watch_flutter/domain/use_case/get_detail_tv_series.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  final repository = MockTvSeriesRepository();
  final useCase = GetDetailTvSeries(repository);

  final detailTvSeries = DetailTvSeries(
    adult: false,
    backdropPath: 'backdropPath',
    episodeRunTime: const [1],
    inProduction: false,
    languages: const ['languages'],
    nextEpisodeToAir: null,
    originCountry: const ['originCountry'],
    tagline: 'tagline',
    type: 'type',
    firstAirDate: 'firstAirDate',
    genres: const [],
    homepage: 'homepage',
    id: 1,
    lastAirDate: 'lastAirDate',
    name: 'name',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    status: 'status',
    voteAverage: 1,
    voteCount: 1,
  );

  test('should get detail tv series from the repository', () async {
    // arrange
    when(repository.getDetailTvSeries(any))
        .thenAnswer((_) async => Right(detailTvSeries));
    // act
    final result = await useCase.execute(1);
    // assert
    expect(result, Right(detailTvSeries));
    verify(repository.getDetailTvSeries(1));
    verifyNoMoreInteractions(repository);
  });
}
