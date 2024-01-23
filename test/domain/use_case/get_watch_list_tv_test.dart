import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/get_watch_list_tv.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  final repository = MockTvSeriesRepository();
  final useCase = GetWatchlistTv(repository);

  test('should get list   of tv sereis after called execute', () async {
    // arrange
    when(repository.getWatchlistTvSeries())
        .thenAnswer((_) async => const Right(<TvSeries>[]));
    // act
    final result = await useCase.execute();
    // assert
    expect(result, const Right(<TvSeries>[]));
    verify(repository.getWatchlistTvSeries());
    verifyNoMoreInteractions(repository);
  });
}
