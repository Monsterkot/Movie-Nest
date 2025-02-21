import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_nest_app/services/session_service.dart';

// Генерируем моки
@GenerateMocks([FlutterSecureStorage])
import 'session_service_test.mocks.dart';

void main() {
  late SessionService sessionService;
  late MockFlutterSecureStorage mockStorage;

  setUpAll(() async {
    await dotenv.load();
  });

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    GetIt.I.registerSingleton<FlutterSecureStorage>(mockStorage);
    sessionService = SessionService();
  });

  tearDown(() {
    GetIt.I.reset();
  });

  test('setSessionId должен сохранить session_id и установить _isAuthenticated в true', () async {
    const sessionId = 'test_session_id';

    // Подменяем поведение write
    when(mockStorage.write(key: anyNamed('key'), value: anyNamed('value')))
        .thenAnswer((_) async {});

    await sessionService.setSessionId(sessionId);

    // Проверяем, что значение записалось
    verify(mockStorage.write(key: 'session_id', value: sessionId)).called(1);

    // Проверяем, что флаг _isAuthenticated обновился
    expect(sessionService.isAuthenticated, true);
  });

  test('getSessionId должен вернуть session_id из хранилища', () async {
    const sessionId = 'test_session_id';

    // Подменяем поведение read
    when(mockStorage.read(key: 'session_id')).thenAnswer((_) async => sessionId);

    final result = await sessionService.getSessionId();

    expect(result, sessionId);
  });

  test('clearSessionId должен удалить session_id и установить _isAuthenticated в false', () async {
    when(mockStorage.delete(key: anyNamed('key'))).thenAnswer((_) async {});

    await sessionService.clearSessionId();

    verify(mockStorage.delete(key: 'session_id')).called(1);
    expect(sessionService.isAuthenticated, false);
  });

  test('checkSession должен вернуть true, если session_id есть', () async {
    when(mockStorage.read(key: 'session_id')).thenAnswer((_) async => 'valid_session');

    final result = await sessionService.checkSession();

    expect(result, true);
    expect(sessionService.isAuthenticated, true);
  });

  test('checkSession должен вернуть false, если session_id нет', () async {
    when(mockStorage.read(key: 'session_id')).thenAnswer((_) async => null);

    final result = await sessionService.checkSession();

    expect(result, false);
    expect(sessionService.isAuthenticated, false);
  });
}
