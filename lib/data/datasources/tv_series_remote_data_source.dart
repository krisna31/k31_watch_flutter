import 'package:k31_watch_flutter/common/constants.dart';
import 'package:k31_watch_flutter/common/server_exception.dart';
import 'package:k31_watch_flutter/data/models/tv_series_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:k31_watch_flutter/data/models/tv_series_model_detail.dart';

import 'package:k31_watch_flutter/data/models/tv_series_response.dart';

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource {
  final http.Client client;
  TvSeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvSeriesModel>> getNowPlayingTvSeries() async {
    final response =
        await client.get(Uri.parse('$baseApiUrl/tv/airing_today?$apiKey'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getPopularTvSeries() async {
    final response =
        await client.get(Uri.parse('$baseApiUrl/tv/popular?$apiKey'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTopRatedTvSeries() async {
    final response =
        await client.get(Uri.parse('$baseApiUrl/tv/top_rated?$apiKey'));

    if (!(response.statusCode == 200)) {
      throw ServerException();
    }

    return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
  }

  @override
  Future<TvSeriesModelDetail> getDetailTvSeries(int id) async {
    final response = await client.get(Uri.parse('$baseApiUrl/tv/$id?$apiKey'));

    if (!(response.statusCode == 200)) {
      throw ServerException();
    }

    return TvSeriesModelDetail.fromJson(json.decode(response.body));
  }
  
  @override
  Future<List<TvSeriesModel>> getRecommendationsTvSeries(int id) async {
    final response = await client
        .get(Uri.parse('$baseApiUrl/tv/$id/recommendations?$apiKey'));

    if (!(response.statusCode == 200)) {
      throw ServerException();
    }

    return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
  }
  
  @override
  Future<List<TvSeriesModel>> searchTvSeries(String query) async {
    final response = await client.get(
      Uri.parse(
        '$baseApiUrl/search/tv?$apiKey&query=$query',
      ),
    );

    if (!(response.statusCode == 200)) {
      throw ServerException();
    }

    return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
  }
}

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeriesModel>> getTopRatedTvSeries();
  Future<TvSeriesModelDetail> getDetailTvSeries(int id);
  Future<List<TvSeriesModel>> getNowPlayingTvSeries();
  Future<List<TvSeriesModel>> getPopularTvSeries();
  Future<List<TvSeriesModel>> searchTvSeries(String query);
  Future<List<TvSeriesModel>> getRecommendationsTvSeries(int id);
}
