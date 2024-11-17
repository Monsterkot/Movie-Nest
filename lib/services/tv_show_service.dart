import 'package:dio/dio.dart';

import '../constants/app_constants.dart';

class TvShowService {
  TvShowService({required Dio dio}) : _dio = dio;

  final Dio _dio;

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('$apiHost$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  Future<Map<String, dynamic>> getPopularTvShows(int page) async {
    final uri = _makeUri('/tv/popular', {
      'api_key': apiKey,
      'page': page.toString(),
      'language': 'en-US',
    });
    final response = await _dio.getUri(uri);
    Map<String, dynamic> data = response.data;
    return data;
  }

  Future<Map<String, dynamic>> getTvShowDetails(int tvShowId) async {
    final uri = _makeUri('/tv/$tvShowId', {
      'api_key': apiKey,
    });
    final response = await _dio.getUri(uri);
    final data = response.data;
    return data;
  }

  Future<Map<String, dynamic>> getTvShowsByQuery(String query, int page) async {
    final uri = _makeUri('/search/tv', {
      'query': query,
      'page' : page.toString(),
      'api_key': apiKey,
      'language': 'en-US',
    });
    final response = await _dio.getUri(uri);
    final data = response.data;
    return data;
  }
}
