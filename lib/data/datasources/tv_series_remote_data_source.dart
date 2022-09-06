import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tv_series_detail_response.dart';
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:http/io_client.dart';

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeriesModel>> getTvSeriesAiringToday();
  Future<List<TvSeriesModel>> getTvSeriesPopular();
  Future<List<TvSeriesModel>> getTvSeriesTopRated();
  Future<TvSeriesDetailResponse> getTvSeriesDetail(int id);
  Future<List<TvSeriesModel>> getTvSeriesRecommendation(int id);
  Future<List<TvSeriesModel>> searchTvSeries(String query);
}

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://www.google.com/';

  final IOClient _client;

  TvSeriesRemoteDataSourceImpl(this._client);

  @override
  Future<List<TvSeriesModel>> getTvSeriesAiringToday() async {
    final response = await _client.get(
      Uri.parse(
        '$BASE_URL/tv/airing_today?$API_KEY',
      ),
    );
    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTvSeriesPopular() async {
    final response = await _client.get(
      Uri.parse(
        '$BASE_URL/tv/popular?$API_KEY',
      ),
    );

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTvSeriesTopRated() async {
    final response = await _client.get(
      Uri.parse(
        '$BASE_URL/tv/top_rated?$API_KEY',
      ),
    );

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvSeriesDetailResponse> getTvSeriesDetail(int id) async {
    final response = await _client.get(
      Uri.parse(
        '$BASE_URL/tv/$id?$API_KEY',
      ),
    );

    if (response.statusCode == 200) {
      return TvSeriesDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTvSeriesRecommendation(int id) async {
    final response = await _client.get(
      Uri.parse(
        '$BASE_URL/tv/$id/recommendations?$API_KEY',
      ),
    );

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> searchTvSeries(String query) async {
    final response = await _client.get(
      Uri.parse(
        '$BASE_URL/search/tv?$API_KEY&query=$query',
      ),
    );

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }
}
