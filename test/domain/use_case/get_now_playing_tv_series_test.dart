import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/get_now_playing_tv_series.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  final repository = MockTvSeriesRepository();
  final useCase = GetNowPlayingTvSeries(repository);

  test('should get now playing tv series from the repository', () async {
    // arrange
    when(repository.getNowPlayingTvSeries())
        .thenAnswer((_) async => const Right(<TvSeries>[]));
    // act
    final result = await useCase.execute();
    // assert
    expect(result, const Right(<TvSeries>[]));
    verify(repository.getNowPlayingTvSeries());
    verifyNoMoreInteractions(repository);
  });
}
