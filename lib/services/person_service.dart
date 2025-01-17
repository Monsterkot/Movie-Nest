import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import '../constants/app_constants.dart';

class PersonService {
  PersonService({required Dio dio}) : _dio = dio;

  final Dio _dio;

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('$apiHost$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  String getCurrentLocale() {
    String locale = Intl.getCurrentLocale();
    return locale.replaceAll('_', '-');
  }

  Future<Map<String,dynamic>> getPersonDetails(int id) async {
    final uri = _makeUri('/person/$id', {
      'append_to_response' : 'combined_credits',
      'api_key': apiKey,
      'language': getCurrentLocale(),
    });
    final response = await _dio.getUri(uri);
    Map<String, dynamic> data = response.data;
    return data;
  }

}
