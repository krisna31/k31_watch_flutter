import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:k31_watch_flutter/domain/use_case/remove_watch_list.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late RemoveWatchlist usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = RemoveWatchlist(mockMovieRepository);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(mockMovieRepository.removeWatchlist(testMovieDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testMovieDetail);
    // assert
    verify(mockMovieRepository.removeWatchlist(testMovieDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}
