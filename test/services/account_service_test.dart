import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:movie_nest_app/services/account_service.dart';
import 'package:movie_nest_app/services/session_service.dart';
import 'package:get_it/get_it.dart';

// Генерируем моки
@GenerateMocks([Dio, SessionService])
import 'account_service_test.mocks.dart';

void main() {
  late AccountService accountService;
  late MockDio mockDio;
  late MockSessionService mockSessionService;

  setUp(() async {
    mockDio = MockDio();
    mockSessionService = MockSessionService();
    GetIt.I.registerSingleton<SessionService>(mockSessionService);
    accountService = AccountService(dio: mockDio);
    await dotenv.load();
  });

  tearDown(() {
    GetIt.I.reset();
  });

  test('getAccountInfo должен вернуть данные аккаунта', () async {
    const fakeSessionId = 'fake_session_id';
    final fakeResponse = Response(
      requestOptions: RequestOptions(path: ''),
      statusCode: 200,
      data: {
        'id': 123,
        'username': 'test_user',
      },
    );

    // Подделываем ответ от SessionService
    when(mockSessionService.getSessionId()).thenAnswer((_) async => fakeSessionId);

    // Подделываем ответ от Dio
    when(mockDio.getUri(any)).thenAnswer((_) async => fakeResponse);

    // Вызываем тестируемый метод
    final result = await accountService.getAccountInfo();

    // Проверяем, что результат совпадает с ожидаемым
    expect(result, {'id': 123, 'username': 'test_user'});

    // Проверяем, что getSessionId был вызван
    verify(mockSessionService.getSessionId()).called(1);

    // Проверяем, что Dio сделал запрос
    verify(mockDio.getUri(any)).called(1);
  });
}
