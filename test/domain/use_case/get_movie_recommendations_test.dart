import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:k31_watch_flutter/domain/entities/movie.dart';
import 'package:k31_watch_flutter/domain/use_case/get_movie_recommendations.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late GetMovieRecommendations usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetMovieRecommendations(mockMovieRepository);
  });

  const tId = 1;
  final tMovies = <Movie>[];

  test('should get list of movie recommendations from the repository',
      () async {
    // arrange
    when(mockMovieRepository.getMovieRecommendations(tId))
        .thenAnswer((_) async => Right(tMovies));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tMovies));
  });
}
