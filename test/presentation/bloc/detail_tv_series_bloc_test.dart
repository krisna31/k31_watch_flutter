import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:k31_watch_flutter/common/failure_child/server_failure.dart';
import 'package:k31_watch_flutter/domain/entities/detail_tv_series.dart';
import 'package:k31_watch_flutter/domain/entities/genre.dart';
import 'package:k31_watch_flutter/domain/use_case/get_detail_tv_series.dart';
import 'package:k31_watch_flutter/presentation/bloc/detail_tv_series_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'detail_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetDetailTvSeries])
void main() {
  late DetailTvSeriesBloc detailTvSeriesBloc;
  late MockGetDetailTvSeries mockGetDetailTvSeries;

  setUp(() {
    mockGetDetailTvSeries = MockGetDetailTvSeries();
    detailTvSeriesBloc = DetailTvSeriesBloc(mockGetDetailTvSeries);
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

  group("Detail Tv Series Bloc", () {
    test('initial state should be initial state', () {
      expect(detailTvSeriesBloc.state, DetailTvSeriesInitial());
    });

    blocTest<DetailTvSeriesBloc, DetailTvSeriesState>(
      'Should emit [Loading, HasData] when data is rsponse successfully',
      build: () {
        when(mockGetDetailTvSeries.execute(tId))
            .thenAnswer((_) async => Right(tDetailTvSeries));
        return detailTvSeriesBloc;
      },
      act: (bloc) => bloc.add(const FetchDetailTvSeriesEvent(id: tId)),
      expect: () => [
        DetailTvSeriesLoading(),
        DetailTvSeriesLoaded(tvSeries: tDetailTvSeries),
      ],
      verify: (bloc) {
        verify(mockGetDetailTvSeries.execute(tId));
      },
    );

    blocTest<DetailTvSeriesBloc, DetailTvSeriesState>(
        "Should emit Loading and Error when get search tv is failed",
        build: () {
          when(mockGetDetailTvSeries.execute(tId)).thenAnswer(
            (_) async => const Left(
              ServerFailure("500 Internal Error"),
            ),
          );
          return detailTvSeriesBloc;
        },
        act: (bloc) => bloc.add(const FetchDetailTvSeriesEvent(id: tId)),
        expect: () {
          return [
            DetailTvSeriesLoading(),
            const DetailTvSeriesError(message: "500 Internal Error"),
          ];
        },
        verify: (bloc) {
          verify(mockGetDetailTvSeries.execute(tId));
        });
  });
}
