import 'package:dio/dio.dart';

import '../constants/app_constants.dart';

class MovieService {
  MovieService({required Dio dio}) : _dio = dio;

  final Dio _dio;

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('$apiHost$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  Future<Map<String, dynamic>> getPopularMovies(int page) async {
    final uri = _makeUri('/movie/popular', {
      'api_key': apiKey,
      'page': page.toString(),
      'language': 'en-US',
    });
    final response = await _dio.getUri(uri);
    Map<String, dynamic> data = response.data;
    return data;
  }

  Future<Map<String, dynamic>> getTopRatedMovies() async {
    final uri = _makeUri('/movie/top_rated', {
      'api_key': apiKey,
      'page': 1.toString(),
      'language': 'en-US',
    });
    final response = await _dio.getUri(uri);
    Map<String, dynamic> data = response.data;
    return data;
  }

  Future<Map<String, dynamic>> getUpcomingMovies() async {
    final uri = _makeUri('/movie/upcoming', {
      'api_key': apiKey,
      'page': 1.toString(),
      'language': 'en-US',
    });
    final response = await _dio.getUri(uri);
    Map<String, dynamic> data = response.data;
    return data;
  }

  Future<Map<String, dynamic>> getNowPlayingMovies() async {
    final uri = _makeUri('/movie/now_playing', {
      'api_key': apiKey,
      'page': 1.toString(),
      'language': 'en-US',
    });
    final response = await _dio.getUri(uri);
    Map<String, dynamic> data = response.data;
    return data;
  }

  Future<Map<String, dynamic>> getMovieDetails(int movieId) async {
    final uri = _makeUri('/movie/$movieId', {
      'append_to_response': 'credits,videos',
      'api_key': apiKey,
    });
    final response = await _dio.getUri(uri);
    final data = response.data;
    return data;
  }

  Future<Map<String, dynamic>> getMoviesByQuery(String query, int page) async {
    final uri = _makeUri('/search/movie', {
      'query': query,
      'page': page.toString(),
      'api_key': apiKey,
      'language': 'en-US',
    });
    final response = await _dio.getUri(uri);
    final data = response.data;
    return data;
  }
}
