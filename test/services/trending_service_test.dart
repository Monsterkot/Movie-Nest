import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_test/hive_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:movie_nest_app/services/trending_service.dart';

// Генерируем моки
@GenerateMocks([Dio])
import 'trending_service_test.mocks.dart';

void main() {
  late TrendingService trendingService;
  late MockDio mockDio;
  late Box testBox;

  setUpAll(() async {
    await dotenv.load();
    await setUpTestHive();
    testBox = await Hive.openBox('movienest_data'); // Используем реальный тестовый Hive
  });

  setUp(() {
    mockDio = MockDio();
    trendingService = TrendingService(dio: mockDio);
  });

  tearDownAll(() async {
    await Hive.close();
  });

  test('getAllTrending должен вернуть тренды и сохранить их в кэш', () async {
    const timeWindow = 'day';
    final fakeResponse = {
      'results': [
        {'id': 1, 'title': 'Trending Movie 1'},
        {'id': 2, 'title': 'Trending Movie 2'},
      ]
    };

    // Мокаем Dio
    when(mockDio.getUri(any)).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: fakeResponse,
        ));

    // Вызываем метод
    final result = await trendingService.getAllTrending(timeWindow);

    // Проверяем, что результат совпадает с фейковыми данными
    expect(result, fakeResponse);

    // Проверяем, что Dio сделал запрос
    verify(mockDio.getUri(any)).called(1);

    // Проверяем, что данные сохранились в кэше
    final cachedData = testBox.get(timeWindow);
    expect(cachedData, fakeResponse);
  });

  test('getAllTrending должен брать данные из кэша при ошибке сети', () async {
    const timeWindow = 'week';
    final cachedData = {
      'results': [
        {'id': 3, 'title': 'Cached Movie 1'},
        {'id': 4, 'title': 'Cached Movie 2'},
      ]
    };

    // Записываем в реальный тестовый Hive
    await testBox.put(timeWindow, cachedData);

    // Мокаем ошибку сети
    when(mockDio.getUri(any)).thenThrow(DioException(
      requestOptions: RequestOptions(path: ''),
      type: DioExceptionType.connectionError,
    ));

    // Вызываем метод
    final result = await trendingService.getAllTrending(timeWindow);

    // Ожидаем, что вернутся данные из кэша
    expect(result, cachedData);

    // Проверяем, что Dio пытался сделать запрос
    verify(mockDio.getUri(any)).called(1);
  });

  test('getAllTrending должен выбрасывать исключение, если данных нет в кэше', () async {
    const timeWindow = 'week';

    // Очищаем кэш перед тестом
    await testBox.delete(timeWindow);

    // Мокаем ошибку сети
    when(mockDio.getUri(any)).thenThrow(DioException(
      requestOptions: RequestOptions(path: ''),
      type: DioExceptionType.connectionError,
    ));

    // Вызываем метод и ожидаем исключение
    expect(() => trendingService.getAllTrending(timeWindow), throwsException);

    // Проверяем, что Dio пытался сделать запрос
    verify(mockDio.getUri(any)).called(1);
  });
}
