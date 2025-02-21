import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_nest_app/services/auth_service.dart';

// Генерируем мок для Dio
@GenerateMocks([Dio])
import 'auth_sevice_test.mocks.dart';

void main() {
  late AuthService authService;
  late MockDio mockDio;

  setUp(() async {
    mockDio = MockDio();
    authService = AuthService(dio: mockDio);
    await dotenv.load();
  });

  test('auth должен вернуть session_id', () async {
    const fakeUsername = 'test_user';
    const fakePassword = 'test_password';
    const fakeRequestToken = 'fake_request_token';
    const fakeValidToken = 'fake_valid_token';
    const fakeSessionId = 'fake_session_id';

    final requestTokenResponse = Response(
      requestOptions: RequestOptions(path: ''),
      statusCode: 200,
      data: {'request_token': fakeRequestToken},
    );

    final validateUserResponse = Response(
      requestOptions: RequestOptions(path: ''),
      statusCode: 200,
      data: {'request_token': fakeValidToken},
    );

    final sessionResponse = Response(
      requestOptions: RequestOptions(path: ''),
      statusCode: 200,
      data: {'session_id': fakeSessionId},
    );

    // Подменяем API-ответы
    when(mockDio.getUri(any)).thenAnswer((_) async => requestTokenResponse);
    when(mockDio.postUri(any, data: anyNamed('data'), options: anyNamed('options')))
        .thenAnswer((Invocation invocation) async {
      final url = invocation.positionalArguments[0].toString();
      if (url.contains('/authentication/token/validate_with_login')) {
        return validateUserResponse;
      } else if (url.contains('/authentication/session/new')) {
        return sessionResponse;
      }
      return Response(requestOptions: RequestOptions(path: ''), statusCode: 400);
    });

    // Запускаем тест
    final sessionId = await authService.auth(username: fakeUsername, password: fakePassword);

    // Проверяем, что полученный session_id корректен
    expect(sessionId, fakeSessionId);

    // Проверяем, что методы были вызваны
    verify(mockDio.getUri(any)).called(1); // Проверяем, что токен был запрошен
    verify(mockDio.postUri(any, data: anyNamed('data'), options: anyNamed('options')))
        .called(2); // Валидация + сессия
  });
}
