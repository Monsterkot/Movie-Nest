import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import '../constants/app_constants.dart';

class TrendingService {
  TrendingService({required dio}) : _dio = dio;

  final Dio _dio;

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('$apiHost$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  Future<void> cacheTrendingData(String timeWindow, Map<String, dynamic> data) async {
    final box = Hive.box('movienest_data');
    box.delete(timeWindow);
    await box.put(timeWindow, data);
  }

  Future<Map<String, dynamic>?> getCachedTrendingData(String timeWindow) async {
    final box = Hive.box('movienest_data');
    final cachedData = box.get(timeWindow);
    if (cachedData != null) {
      return Map<String, dynamic>.from(cachedData);
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>> getAllTrending(String timeWindow) async {
    final uri = _makeUri('/trending/all/$timeWindow', {'api_key': apiKey});
    try {
      final response = await _dio.getUri(uri);
      final data = response.data;
      await cacheTrendingData(timeWindow, data);
      return data;
    } catch (e) {
      final cachedData = await getCachedTrendingData(timeWindow);
      if (cachedData != null) {
        return cachedData;
      } else {
        throw Exception("No data in cache.");
      }
    }
  }
}
