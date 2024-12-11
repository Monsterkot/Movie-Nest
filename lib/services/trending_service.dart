import 'package:dio/dio.dart';

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

  Future<Map<String, dynamic>> getAllTrending(String timeWindow) async {
    final uri = _makeUri('/trending/all/$timeWindow', {'api_key': apiKey});
    final response = await _dio.getUri(uri);
    final data = response.data;
    return data;
  }
}
