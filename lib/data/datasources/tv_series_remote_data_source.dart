import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:k31_watch_flutter/common/exception.dart';
import 'package:k31_watch_flutter/data/models/tv_series_model.dart';
import 'package:k31_watch_flutter/data/models/tv_series_model_detail.dart';
import 'package:k31_watch_flutter/data/models/tv_series_response.dart';

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeriesModel>> getNowPlayingTvSeries();
  Future<List<TvSeriesModel>> getPopularTvSeries();
  Future<List<TvSeriesModel>> getTopRatedTvSeries();
  Future<TvSeriesModelDetail> getDetailTvSeries(int id);
  // Future<MovieDetailResponse> getMovieDetail(int id);
  // Future<List<MovieModel>> getMovieRecommendations(int id);
  // Future<List<MovieModel>> searchMovies(String query);
}

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource {
  static const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const baseApiUrl = 'https://api.themoviedb.org/3';

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

  // @override
  // Future<MovieDetailResponse> getMovieDetail(int id) async {
  //   final response =
  //       await client.get(Uri.parse('$baseApiUrl/movie/$id?$apiKey'));

  //   if (response.statusCode == 200) {
  //     return MovieDetailResponse.fromJson(json.decode(response.body));
  //   } else {
  //     throw ServerException();
  //   }
  // }

  // @override
  // Future<List<MovieModel>> getMovieRecommendations(int id) async {
  //   final response = await client
  //       .get(Uri.parse('$baseApiUrl/movie/$id/recommendations?$apiKey'));

  //   if (response.statusCode == 200) {
  //     return MovieResponse.fromJson(json.decode(response.body)).movieList;
  //   } else {
  //     throw ServerException();
  //   }
  // }

  // @override
  // Future<List<MovieModel>> searchMovies(String query) async {
  //   final response = await client
  //       .get(Uri.parse('$baseApiUrl/search/movie?$apiKey&query=$query'));

  //   if (response.statusCode == 200) {
  //     return MovieResponse.fromJson(json.decode(response.body)).movieList;
  //   } else {
  //     throw ServerException();
  //   }
  // }
}
