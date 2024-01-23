import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:k31_watch_flutter/common/server_exception.dart';
import 'package:k31_watch_flutter/data/datasources/tv_series_remote_data_source.dart';
import 'package:k31_watch_flutter/data/models/tv_series_model_detail.dart';
import 'package:k31_watch_flutter/data/models/tv_series_response.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const baseUrl = 'https://api.themoviedb.org/3';

  late TvSeriesRemoteDataSourceImpl repository;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    repository = TvSeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Now Playing Tv Series', () {
    final tvList = TvSeriesResponse.fromJson(
      json.decode(
        readJson('dummy_data/now_play_tv.json'),
      ),
    ).tvSeriesList;

    test('should return list of Tv List when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/airing_today?$apiKey')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/now_play_tv.json'), 200, headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
              }));

      // act
      final result = await repository.getNowPlayingTvSeries();

      // assert
      expect(result, equals(tvList));
    });

    test('should throw ServerException when the response code is not 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/airing_today?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404, headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
              }));

      // act
      final call = repository.getNowPlayingTvSeries;

      // assert
      expect(() => call(), throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Tv Series', () {
    final tvList = TvSeriesResponse.fromJson(
      json.decode(
        readJson('dummy_data/popular_tv.json'),
      ),
    ).tvSeriesList;

    test('should return list of Tv List when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/popular_tv.json'), 200, headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
              }));

      // act
      final result = await repository.getPopularTvSeries();

      // assert
      expect(result, equals(tvList));
    });

    test('should throw ServerException when the response code is not 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404, headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
              }));

      // act
      final call = repository.getPopularTvSeries;

      // assert
      expect(() => call(), throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Tv Series', () {
    final tvList = TvSeriesResponse.fromJson(
      json.decode(
        readJson('dummy_data/top_rated_tv.json'),
      ),
    ).tvSeriesList;

    test('should return list of Tv List when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/top_rated_tv.json'), 200, headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
              }));

      // act
      final result = await repository.getTopRatedTvSeries();

      // assert
      expect(result, equals(tvList));
    });

    test('should throw ServerException when the response code is not 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404, headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
              }));

      // act
      final call = repository.getTopRatedTvSeries;

      // assert
      expect(() => call(), throwsA(isA<ServerException>()));
    });
  });

  group('get Detail Tv Series', () {
    final tvDetail = TvSeriesModelDetail.fromJson(
      json.decode(
        readJson('dummy_data/tv_detail.json'),
      ),
    );

    test('should return Tv Series Detail when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/1?$apiKey'))).thenAnswer(
          (_) async => http.Response(
                  readJson('dummy_data/tv_detail.json'), 200, headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
              }));

      // act
      final result = await repository.getDetailTvSeries(1);

      // assert
      expect(result, equals(tvDetail));
    });

    test('should throw ServerException when the response code is not 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/1?$apiKey'))).thenAnswer(
          (_) async => http.Response('Not Found', 404, headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
              }));

      // act
      call() => repository.getDetailTvSeries(1);

      // assert
      expect(call, throwsA(isA<ServerException>()));
    });
  });

  group('get Recommendations Tv Series', () {
    final tvList = TvSeriesResponse.fromJson(
      json.decode(
        readJson('dummy_data/tv_recommendations.json'),
      ),
    ).tvSeriesList;

    test('should return list of Tv List when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/1/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_recommendations.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8'
                  }));

      // act
      final result = await repository.getRecommendationsTvSeries(1);

      // assert
      expect(result, equals(tvList));
    });

    test('should throw ServerException when the response code is not 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/1/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404, headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
              }));

      // act
      call() => repository.getRecommendationsTvSeries(1);

      // assert
      expect(call, throwsA(isA<ServerException>()));
    });
  });

  group('search Tv Series', () {
    final tvList = TvSeriesResponse.fromJson(
      json.decode(
        readJson('dummy_data/search_tv.json'),
      ),
    ).tvSeriesList;

    test('should return list of Tv List when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(
              Uri.parse('$baseUrl/search/tv?$apiKey&query=breaking%20bad')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/search_tv.json'), 200, headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
              }));

      // act
      final result = await repository.searchTvSeries('breaking bad');

      // assert
      expect(result, equals(tvList));
    });

    test('should throw ServerException when the response code is not 200',
        () async {
      // arrange
      when(mockHttpClient.get(
              Uri.parse('$baseUrl/search/tv?$apiKey&query=breaking%20bad')))
          .thenAnswer((_) async => http.Response('Not Found', 404, headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
              }));

      // act
      call() => repository.searchTvSeries('breaking bad');

      // assert
      expect(call, throwsA(isA<ServerException>()));
    });
  });
}
