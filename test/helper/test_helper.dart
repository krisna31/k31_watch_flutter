import 'package:k31_watch_flutter/data/datasources/db/db_helper.dart';
import 'package:k31_watch_flutter/data/datasources/movie_local_data_source.dart';
import 'package:k31_watch_flutter/data/datasources/movie_remote_data_source.dart';
import 'package:k31_watch_flutter/domain/repositories/movie_repositories.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DbHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
