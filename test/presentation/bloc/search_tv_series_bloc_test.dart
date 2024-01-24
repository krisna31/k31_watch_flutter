import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:k31_watch_flutter/common/failure_child/server_failure.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/search_tv.dart';
import 'package:k31_watch_flutter/presentation/bloc/search_tv_series_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_tv_series_bloc_test.mocks.dart';

@GenerateMocks([SearchTv])
void main() {
  late SearchTvSeriesBloc searchTvSeriesBloc;
  late MockSearchTv mockSearchTv;

  setUp(() {
    mockSearchTv = MockSearchTv();
    searchTvSeriesBloc = SearchTvSeriesBloc(mockSearchTv);
  });

  test('initial state should be empty', () {
    expect(searchTvSeriesBloc.state, SearchTvEmpty());
  });

  final tTvSeriesList = <TvSeries>[
    TvSeries(
      adult: false,
      backdropPath: '/path.jpg',
      genreIds: const [1, 2, 3],
      firstAirDate: '2020-05-05',
      originCountry: const ['US'],
      originalLanguage: 'en',
      originalName: 'Original Name',
      popularity: 1,
      voteCount: 1,
      id: 1,
      name: 'Breaking Bad',
      overview: 'overview',
      posterPath: '/path.jpg',
      voteAverage: 1,
    ),
  ];
  const String tQuery = 'open';

  blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
    'Should emit [Loading, HasData] when data is rsponse successfully',
    build: () {
      when(mockSearchTv.execute(tQuery))
          .thenAnswer((_) async => Right(tTvSeriesList));
      return searchTvSeriesBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 555),
    expect: () => [
      SearchTvLoading(),
      SearchTvHasData(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockSearchTv.execute(tQuery));
    },
  );

  blocTest("Should emit Loading and Error when get search tv is failed",
      build: () {
        when(mockSearchTv.execute(tQuery)).thenAnswer(
          (_) async => const Left(
            ServerFailure("500 Internal Error"),
          ),
        );
        return searchTvSeriesBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 555),
      expect: () {
        return [
          SearchTvLoading(),
          const SearchTvError("500 Internal Error"),
        ];
      },
      verify: (bloc) {
        verify(mockSearchTv.execute(tQuery));
      });
}
