import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:movie_nest_app/constants/media_type.dart';
import 'package:movie_nest_app/repositories/account_repository.dart';
import 'package:movie_nest_app/services/session_service.dart';
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

  Future<void> cacheMovies(String key, Map<String, dynamic> data) async {
    final box = Hive.box('movienest_data');
    box.delete(key);
    await box.put(key, data);
  }

  Future<void> cacheMovieList(String key, Map<String, dynamic> data) async {
    final box = Hive.box('movienest_data');
    box.delete(key);
    await box.put(key, data);
  }

  Future<Map<String, dynamic>?> getCachedMovies(String key) async {
    final box = Hive.box('movienest_data');
    final cachedData = box.get(key);
    if (cachedData != null) {
      return Map<String, dynamic>.from(cachedData);
    } else {
      return null;
    }
  }

  String getCurrentLocale() {
    String locale = Intl.getCurrentLocale();
    return locale.replaceAll('_', '-');
  }

  Future<Map<String, dynamic>> getPopularMovies(int page) async {
    final uri = _makeUri('/movie/popular', {
      'api_key': apiKey,
      'page': page.toString(),
      'language': getCurrentLocale(),
    });
    try {
      final response = await _dio.getUri(uri);
      Map<String, dynamic> data = response.data;
      await cacheMovieList('popular_movies', data);
      return data;
    } catch (e) {
      final cachedData = await getCachedMovies('popular_movies');
      if (cachedData != null) {
        return cachedData;
      } else {
        throw Exception("Empty cache.");
      }
    }
  }

  Future<Map<String, dynamic>> getTopRatedMovies() async {
    final uri = _makeUri('/movie/top_rated', {
      'api_key': apiKey,
      'page': 1.toString(),
      'language': getCurrentLocale(),
    });
    try {
      final response = await _dio.getUri(uri);
      Map<String, dynamic> data = response.data;
      await cacheMovies('top_rated_movies', data);
      return data;
    } catch (e) {
      final cachedData = await getCachedMovies('top_rated_movies');
      if (cachedData != null) {
        return cachedData;
      } else {
        throw Exception("Empty cache.");
      }
    }
  }

  Future<Map<String, dynamic>> getUpcomingMovies() async {
    final uri = _makeUri('/movie/upcoming', {
      'api_key': apiKey,
      'page': 1.toString(),
      'language': getCurrentLocale(),
    });
    try {
      final response = await _dio.getUri(uri);
      Map<String, dynamic> data = response.data;
      await cacheMovies('upcoming_movies', data);
      return data;
    } catch (e) {
      final cachedData = await getCachedMovies('upcoming_movies');
      if (cachedData != null) {
        return cachedData;
      } else {
        throw Exception('Empty cache.');
      }
    }
  }

  Future<Map<String, dynamic>> getNowPlayingMovies() async {
    final uri = _makeUri('/movie/now_playing', {
      'api_key': apiKey,
      'page': 1.toString(),
      'language': getCurrentLocale(),
    });
    try {
      final response = await _dio.getUri(uri);
      Map<String, dynamic> data = response.data;
      await cacheMovies('now_playing_movies', data);
      return data;
    } catch (e) {
      final cachedData = await getCachedMovies('now_playing_movies');
      if (cachedData != null) {
        return cachedData;
      } else {
        throw Exception('Empty cache.');
      }
    }
  }

  Future<Map<String, dynamic>> getMovieDetails(int movieId) async {
    final uri = _makeUri('/movie/$movieId', {
      'append_to_response': 'credits,videos',
      'api_key': apiKey,
      'language': getCurrentLocale(),
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
      'language': getCurrentLocale(),
    });
    final response = await _dio.getUri(uri);
    final data = response.data;
    return data;
  }

  Future<Map<String, dynamic>> isFavorite(int movieId) async {
    final sessionId = await GetIt.I<FlutterSecureStorage>().read(key: 'session_id');
    final uri = _makeUri('/movie/$movieId/account_states', {
      'api_key': apiKey,
      'session_id': sessionId,
    });
    final response = await _dio.getUri(uri);
    Map<String, dynamic> data = response.data;
    return data;
  }

  Future<int> markAsFavorite(
      {required MediaType mediaType, required int mediaId, required bool isFavorite}) async {
    final accountId = await GetIt.I<AccountRepository>().getAccountId();
    final sessionId = await GetIt.I<SessionService>().getSessionId();
    final uri = _makeUri('/account/$accountId/favorite', {
      'api_key': apiKey,
      'session_id': sessionId,
    });
    final parameters = {
      'media_type': mediaType.asString(),
      'media_id': mediaId,
      'favorite': isFavorite,
    };
    final response = await _dio.postUri(uri,
        data: jsonEncode(parameters),
        options: Options(headers: {
          Headers.contentTypeHeader: Headers.jsonContentType,
        }));
    if (response.statusCode == 201) {
      return 1;
    }
    return 0;
  }

  Future<Map<String, dynamic>> getFavoriteMovies(int page) async {
    final accountId = await GetIt.I<AccountRepository>().getAccountId();
    final sessionId = await GetIt.I<SessionService>().getSessionId();
    final uri = _makeUri('/account/$accountId/favorite/movies', {
      'language': getCurrentLocale(),
      'page': page.toString(),
      'session_id': sessionId,
      'sort_by': 'created_at.desc',
      'api_key': apiKey,
    });
    try {
      final response = await _dio.getUri(uri);
      final data = response.data;
      await cacheMovies('favorite_movies', data);
      return data;
    } catch (e) {
      final cachedData = await getCachedMovies('favorite_movies');
      if (cachedData != null) {
        return cachedData;
      } else {
        throw Exception('Empty cache.');
      }
    }
  }
}
