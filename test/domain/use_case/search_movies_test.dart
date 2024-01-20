import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:k31_watch_flutter/domain/entities/movie.dart';
import 'package:k31_watch_flutter/domain/use_case/search_movies.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late SearchMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SearchMovies(mockMovieRepository);
  });

  final tMovies = <Movie>[];
  const tQuery = 'Spiderman';

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockMovieRepository.searchMovies(tQuery))
        .thenAnswer((_) async => Right(tMovies));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tMovies));
  });
}
