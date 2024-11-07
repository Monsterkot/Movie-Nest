import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_nest_app/constants/app_constants.dart';
import 'package:movie_nest_app/services/session_service.dart';

class AccountService {
  AccountService({required Dio dio}) : _dio = dio;

  final Dio _dio;

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('$apiHost$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  Future<Map<String, dynamic>> getAccountInfo() async {
    final uri = _makeUri('/account', {
      'api_key': apiKey,
      'session_id': await GetIt.I<SessionService>().getSessionId(),
    });
    final response = await _dio.getUri(uri);
    Map<String, dynamic> data = response.data;
    return data;
  }
}
