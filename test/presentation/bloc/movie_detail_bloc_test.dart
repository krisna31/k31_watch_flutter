import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:k31_watch_flutter/common/failure_child/server_failure.dart';
import 'package:k31_watch_flutter/domain/use_case/get_movie_detail.dart';
import 'package:k31_watch_flutter/presentation/bloc/movie_detail_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_object.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MovieDetailBloc bloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    bloc = MovieDetailBloc(mockGetMovieDetail);
  });

  group('MovieDetailBloc', () {
    test('initial state is MovieDetailInitial', () {
      expect(bloc.state, MovieDetailInitial());
    });

    blocTest(
        "should emit [MovieDetailLoading, MovieDetailHasData] when success",
        build: () {
          when(mockGetMovieDetail.execute(1))
              .thenAnswer((_) async => const Right(testMovieDetail));
          return bloc;
        },
        act: (bloc) => bloc.add(const FetchMovieDetailFromBloc(1)),
        expect: () => [
              MovieDetailLoading(),
              const MovieDetailHasData(testMovieDetail),
            ],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(1));
        });

    blocTest("should emit [MovieDetailLoading, MovieDetailError] when failure",
        build: () {
          when(mockGetMovieDetail.execute(1))
              .thenAnswer((_) async => const Left(ServerFailure('error')));
          return bloc;
        },
        act: (bloc) => bloc.add(const FetchMovieDetailFromBloc(1)),
        expect: () => [
              MovieDetailLoading(),
              const MovieDetailError('error'),
            ],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(1));
        });
  });
}
