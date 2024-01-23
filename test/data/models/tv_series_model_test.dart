import 'package:flutter_test/flutter_test.dart';
import 'package:k31_watch_flutter/data/models/tv_series_model.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';

void main() {
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

  test('should be testTvSEries after call toEntity', () async {
    expect(testTvModel.toEntity(), testTvSeries);
  });
}
