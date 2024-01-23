import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:k31_watch_flutter/common/constants.dart';
import 'package:k31_watch_flutter/data/models/movie_model.dart';
import 'package:k31_watch_flutter/common/server_exception.dart';
import 'package:k31_watch_flutter/data/models/movie_response.dart';
import 'package:k31_watch_flutter/data/models/movie_detail_model.dart';

class MovieRemoteDataSourceImplementation implements MovieRemoteDataSource {
  MovieRemoteDataSourceImplementation({required this.client});
  final http.Client client;

  @override
  Future<MovieDetailResponse> getMovieDetail(int id) async {
    final response =
        await client.get(Uri.parse('$baseApiUrl/movie/$id?$apiKey'));

// if response status code is not 200 throw ServerException
    if (response.statusCode != 200) {
      throw ServerException();
    }

// otherwise return MovieResponse.fromJson(response.body).movieList
    return MovieDetailResponse.fromJson(json.decode(response.body));
  }


  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response =
        await client.get(Uri.parse('$baseApiUrl/movie/popular?$apiKey'));

    // if response status code is not 200 throw ServerException
    if (response.statusCode != 200) {
      throw ServerException();
    } 

// otherwise return MovieResponse.fromJson(response.body).movieList
    return MovieResponse.fromJson(json.decode(response.body)).movieList;
  }

  
  @override
  Future<List<MovieModel>> getMovieRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$baseApiUrl/movie/$id/recommendations?$apiKey'));

// if response status code is not 200 throw ServerException
    if (response.statusCode != 200) {
      throw ServerException();
    }

    // otherwise return MovieResponse.fromJson(response.body).movieList
    return MovieResponse.fromJson(json.decode(response.body)).movieList;
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    final response =
        await client.get(Uri.parse('$baseApiUrl/movie/top_rated?$apiKey'));

    if (response.statusCode != 200) {
      throw ServerException();
    }

    // otherwise return MovieResponse.fromJson(response.body).movieList
    return MovieResponse.fromJson(json.decode(response.body)).movieList;
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    final response = await client
        .get(Uri.parse('$baseApiUrl/search/movie?$apiKey&query=$query'));

    if (response.statusCode != 200) {
      throw ServerException();
    }

    // otherwise return MovieResponse.fromJson(response.body).movieList
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
  }

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    // from client get response
    final response =
        await client.get(Uri.parse('$baseApiUrl/movie/now_playing?$apiKey'));

    // if response status code is not 200 throw ServerException
    if (response.statusCode != 200) {
      throw ServerException();
    }

    // otherwise return MovieResponse.fromJson(response.body).movieList

    return MovieResponse.fromJson(json.decode(response.body)).movieList;
  }
}

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getTopRatedMovies();
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> searchMovies(String query);
  Future<List<MovieModel>> getPopularMovies();
  Future<MovieDetailResponse> getMovieDetail(int id);
  Future<List<MovieModel>> getMovieRecommendations(int id);
}
