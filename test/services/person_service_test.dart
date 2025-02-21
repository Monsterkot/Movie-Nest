import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:movie_nest_app/services/person_service.dart';

// Генерируем моки
@GenerateMocks([Dio])
import 'person_service_test.mocks.dart';

void main() {
  late PersonService personService;
  late MockDio mockDio;

  setUpAll(() async {
    await dotenv.load();
  });

  setUp(() {
    mockDio = MockDio();
    personService = PersonService(dio: mockDio);
  });

  test('getPersonDetails должен вернуть данные о человеке', () async {
    const personId = 123;
    final fakeResponse = {
      'id': personId,
      'name': 'Fake Actor',
      'combined_credits': {'cast': [], 'crew': []},
    };

    // Подменяем ответ от Dio
    when(mockDio.getUri(any)).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: fakeResponse,
        ));

    // Вызываем метод
    final result = await personService.getPersonDetails(personId);

    // Проверяем, что результат совпадает с ожидаемым
    expect(result, fakeResponse);

    // Проверяем, что Dio был вызван один раз
    verify(mockDio.getUri(any)).called(1);
  });
}
