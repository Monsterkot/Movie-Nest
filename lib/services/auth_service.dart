import 'package:dio/dio.dart';
import '../constants/app_constants.dart';

class AuthService {
  AuthService({required Dio dio}) : _dio = dio;
  final Dio _dio;

  Future<String?> auth({
    required String username,
    required String password,
  }) async {
    final requestToken = await _makeToken();
    final validToken = await _validateUser(
      username: username,
      password: password,
      requestToken: requestToken,
    );
    final sessionId = await _makeSession(validToken: validToken);
    return sessionId;
  }

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('$apiHost$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  Future<String> _makeToken() async {
    final url = _makeUri(
      '/authentication/token/new',
      {'api_key': apiKey},
    );
    final response = await _dio.getUri(url);
    Map<String, dynamic> data = response.data;
    return data['request_token'] as String;
  }

  Future<String> _validateUser({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    final url = _makeUri(
      '/authentication/token/validate_with_login',
      {'api_key': apiKey},
    );
    final parameters = <String, dynamic>{
      'username': username,
      'password': password,
      'request_token': requestToken,
    };
    final response = await _dio.postUri(url,
        data: parameters,
        options: Options(headers: {
          Headers.contentTypeHeader:
              Headers.jsonContentType, //говорим что в теле метода передаем json
        }));
    Map<String, dynamic> data = response.data;
    return data['request_token'] as String;
  }

  Future<String> _makeSession({
    required String validToken,
  }) async {
    final url = _makeUri(
      '/authentication/session/new',
      {'api_key': apiKey},
    );
    final parameters = <String, dynamic>{
      'request_token': validToken,
    };
    final response = await _dio.postUri(url,
        data: parameters,
        options: Options(headers: {
          Headers.contentTypeHeader: Headers.jsonContentType,
        }));
    Map<String, dynamic> data = response.data;
    return data['session_id'] as String;
  }
}
