import 'package:k31_watch_flutter/data/datasources/db/db_helper_movies.dart';
import 'package:k31_watch_flutter/data/datasources/db/db_helper_tv_series.dart';
import 'package:k31_watch_flutter/data/datasources/local_data_tv_series_source.dart';
import 'package:k31_watch_flutter/data/datasources/movie_local_data_source.dart';
import 'package:k31_watch_flutter/data/datasources/movie_remote_data_source.dart';
import 'package:k31_watch_flutter/data/datasources/tv_series_remote_data_source.dart';
import 'package:k31_watch_flutter/domain/repositories/movie_repositories.dart';
import 'package:k31_watch_flutter/domain/repositories/tv_series_repositories.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DbHelperMovies,

  DbHelperTvSeries,
  TvSeriesRepository,
  TvSeriesRemoteDataSource,
  LocalDataTvSeriesSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
