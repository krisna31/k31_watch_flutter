import 'package:flutter_test/flutter_test.dart';
import 'package:k31_watch_flutter/domain/use_case/get_watch_list_status_tv.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  final repository = MockTvSeriesRepository();
  final useCase = GetWatchListStatusTv(repository);
  const id = 1;

  test('should get true after called execute', () async {
    // arrange
    when(repository.isAddedToWatchlistTv(id)).thenAnswer((_) async => true);
    // act
    final result = await useCase.execute(id);
    // assert
    expect(result, true);
    verify(repository.isAddedToWatchlistTv(id));
    verifyNoMoreInteractions(repository);
  });
}
