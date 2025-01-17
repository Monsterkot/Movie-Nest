import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../constants/app_constants.dart';
import '../constants/media_type.dart';
import '../repositories/account_repository.dart';
import 'session_service.dart';

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

  Future<void> cacheTvShows(String key, Map<String, dynamic> data) async {
    final box = Hive.box('movienest_data');
    box.delete(key);
    await box.put(key, data);
  }

  Future<Map<String, dynamic>?> getCachedTvShows(String key) async {
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

  Future<Map<String, dynamic>> getPopularTvShows(int page) async {
    final uri = _makeUri('/tv/popular', {
      'api_key': apiKey,
      'page': page.toString(),
      'language': getCurrentLocale(),
    });
    try {
      final response = await _dio.getUri(uri);
      Map<String, dynamic> data = response.data;
      await cacheTvShows('popular_tv_shows', data);
      return data;
    } catch (e) {
      final cachedData = await getCachedTvShows('popular_tv_shows');
      if (cachedData != null) {
        return cachedData;
      } else {
        throw Exception('Empty cache.');
      }
    }
  }

  Future<Map<String, dynamic>> getAiringTodayTvShows() async {
    final uri = _makeUri('/tv/airing_today', {
      'api_key': apiKey,
      'page': 1.toString(),
      'language': getCurrentLocale(),
    });
    try {
      final response = await _dio.getUri(uri);
      Map<String, dynamic> data = response.data;
      await cacheTvShows('airing_today_tv_shows', data);
      return data;
    } catch (e) {
      final cachedData = await getCachedTvShows('airing_today_tv_shows');
      if (cachedData != null) {
        return cachedData;
      } else {
        throw Exception('Empty cache.');
      }
    }
  }

  Future<Map<String, dynamic>> getOnTheAirTvShows() async {
    final uri = _makeUri('/tv/on_the_air', {
      'api_key': apiKey,
      'page': 1.toString(),
      'language': getCurrentLocale(),
    });
    try {
      final response = await _dio.getUri(uri);
      Map<String, dynamic> data = response.data;
      await cacheTvShows('on_the_air_tv_shows', data);
      return data;
    } catch (e) {
      final cachedData = await getCachedTvShows('on_the_air_tv_shows');
      if (cachedData != null) {
        return cachedData;
      } else {
        throw Exception('Empty cache.');
      }
    }
  }

  Future<Map<String, dynamic>> getTopRatedTvShows() async {
    final uri = _makeUri('/tv/top_rated', {
      'api_key': apiKey,
      'page': 1.toString(),
      'language': getCurrentLocale(),
    });
    try {
      final response = await _dio.getUri(uri);
      Map<String, dynamic> data = response.data;
      await cacheTvShows('top_rated_tv_shows', data);
      return data;
    } catch (e) {
      final cachedData = await getCachedTvShows('top_rated_tv_shows');
      if (cachedData != null) {
        return cachedData;
      } else {
        throw Exception('Empty cache.');
      }
    }
  }

  Future<Map<String, dynamic>> getTvShowDetails(int tvShowId) async {
    final uri = _makeUri('/tv/$tvShowId', {
      'append_to_response': 'credits,videos',
      'api_key': apiKey,
      'language': getCurrentLocale(),
    });
    final response = await _dio.getUri(uri);
    final data = response.data;
    return data;
  }

  Future<Map<String, dynamic>> getTvShowsByQuery(String query, int page) async {
    final uri = _makeUri('/search/tv', {
      'query': query,
      'page': page.toString(),
      'api_key': apiKey,
      'language': getCurrentLocale(),
    });
    final response = await _dio.getUri(uri);
    final data = response.data;
    return data;
  }

  Future<Map<String, dynamic>> isFavorite(int tvShowId) async {
    final sessionId = await GetIt.I<SessionService>().getSessionId();
    final uri = _makeUri('/tv/$tvShowId/account_states', {
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

  Future<Map<String, dynamic>> getFavoriteTvShows(int page) async {
    final accountId = await GetIt.I<AccountRepository>().getAccountId();
    final sessionId = await GetIt.I<SessionService>().getSessionId();
    final uri = _makeUri('/account/$accountId/favorite/tv', {
      'language': getCurrentLocale(),
      'page': page.toString(),
      'session_id': sessionId,
      'sort_by': 'created_at.desc',
      'api_key': apiKey,
    });
    try {
      final response = await _dio.getUri(uri);
      final data = response.data;
      await cacheTvShows('favorite_tv_shows', data);
      return data;
    } catch (e) {
      final cachedData = await getCachedTvShows('favorite_tv_shows');
      if (cachedData != null) {
        return cachedData;
      } else {
        throw Exception('Empty cache.');
      }
    }
  }
}
