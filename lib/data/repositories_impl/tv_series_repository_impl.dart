import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:k31_watch_flutter/common/exception.dart';
import 'package:k31_watch_flutter/common/failure.dart';
import 'package:k31_watch_flutter/common/failure_child.dart';
import 'package:k31_watch_flutter/data/datasources/tv_series_remote_data_source.dart';
import 'package:k31_watch_flutter/domain/entities/detail_tv_series.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:k31_watch_flutter/domain/repositories/tv_series_repositories.dart';

class TvSeriesRepositoryImpl implements TvSeriesRepository {
  final TvSeriesRemoteDataSource remoteDataSource;
  // final MovieLocalDataSource localDataSource;

  TvSeriesRepositoryImpl({
    required this.remoteDataSource,
    // required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<TvSeries>>> getNowPlayingTvSeries() async {
    try {
      final result = await remoteDataSource.getNowPlayingTvSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return returnErrorOnServerExceptionTvSeries();
    } on SocketException {
      return returnErrorOnSocketExceptionTvSeries();
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries() async {
    try {
      final result = await remoteDataSource.getPopularTvSeries();

      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {

      return returnErrorOnServerExceptionTvSeries();

    } on SocketException {

      return returnErrorOnSocketExceptionTvSeries();

    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries() async {
    try {
      final result = await remoteDataSource.getTopRatedTvSeries();

      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {

      return returnErrorOnServerExceptionTvSeries();
    } on SocketException {

      return returnErrorOnSocketExceptionTvSeries();


    }
  }

  @override
  Future<Either<Failure, DetailTvSeries>> getDetailTvSeries(int id) async {
    try {
      final result = await remoteDataSource.getDetailTvSeries(id);

      return Right(result.toEntity());
    } on ServerException {
      return returnErrorOnServerExceptionDetailTvSeries();
    } on SocketException {
      return returnErrorOnSocketExceptionDetailTvSeries();
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getRecommendationsTvSeries(
      int id) async {
    try {
      final result = await remoteDataSource.getRecommendationsTvSeries(id);

      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return returnErrorOnServerExceptionTvSeries();
    } on SocketException {
      return returnErrorOnSocketExceptionTvSeries();
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query) async {
    try {
      final result = await remoteDataSource.searchTvSeries(query);

      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return returnErrorOnServerExceptionTvSeries();
    } on SocketException {
      return returnErrorOnSocketExceptionTvSeries();
    }
  }

    // @override
    // Future<Either<Failure, List<Movie>>> searchMovies(String query) async {
    //   try {
    //     final result = await remoteDataSource.searchMovies(query);
    //     return Right(result.map((model) => model.toEntity()).toList());
    //   } on ServerException {
    //     return const Left(ServerFailure(''));
    //   } on SocketException {
    //     return const Left(ConnectionFailure('Failed to connect to the network'));
    //   }
    // }

    // @override
    // Future<Either<Failure, String>> saveWatchlist(MovieDetail movie) async {
    //   try {
    //     final result =
    //         await localDataSource.insertWatchlist(MovieTable.fromEntity(movie));
    //     return Right(result);
    //   } on DatabaseException catch (e) {
    //     return Left(DatabaseFailure(e.message));
    //   } catch (e) {
    //     rethrow;
    //   }
    // }

    // @override
    // Future<Either<Failure, String>> removeWatchlist(MovieDetail movie) async {
    //   try {
    //     final result =
    //         await localDataSource.removeWatchlist(MovieTable.fromEntity(movie));
    //     return Right(result);
    //   } on DatabaseException catch (e) {
    //     return Left(DatabaseFailure(e.message));
    //   }
    // }

    // @override
    // Future<bool> isAddedToWatchlist(int id) async {
    //   final result = await localDataSource.getMovieById(id);
    //   return result != null;
    // }

    // @override
    // Future<Either<Failure, List<Movie>>> getWatchlistMovies() async {
    //   final result = await localDataSource.getWatchlistMovies();
    //   return Right(result.map((data) => data.toEntity()).toList());
  // }

  Left<Failure, List<TvSeries>> returnErrorOnSocketExceptionTvSeries() {
    return const Left(ConnectionFailure('Failed to connect to the network'));
  }

  Left<Failure, List<TvSeries>> returnErrorOnServerExceptionTvSeries() {
    return const Left(ServerFailure('ServerFailure 500'));
  }

  Left<Failure, DetailTvSeries> returnErrorOnServerExceptionDetailTvSeries() {
    return const Left(ServerFailure('ServerFailure 500'));
  }

  Left<Failure, DetailTvSeries> returnErrorOnSocketExceptionDetailTvSeries() {
    return const Left(ConnectionFailure('Failed to connect to the network'));
  }
  
 
  
}
