import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:k31_watch_flutter/domain/entities/movie.dart';
import 'package:k31_watch_flutter/domain/use_case/get_top_rated_movies.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late GetTopRatedMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetTopRatedMovies(mockMovieRepository);
  });

  final tMovies = <Movie>[];

  test('should get list of movies from repository', () async {
    // arrange
    when(mockMovieRepository.getTopRatedMovies())
        .thenAnswer((_) async => Right(tMovies));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tMovies));
  });
}
