import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_test/hive_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:movie_nest_app/repositories/account_repository.dart';
import 'package:movie_nest_app/services/movie_service.dart';
import 'package:movie_nest_app/constants/media_type.dart';
import 'package:movie_nest_app/services/session_service.dart';


@GenerateMocks([Dio, Box, AccountRepository, SessionService])
import 'movie_service_test.mocks.dart';

void main() {
  late MovieService movieService;
  late MockDio mockDio;
  late Box testBox;
  late MockAccountRepository mockAccountRepository;
  late MockSessionService mockSessionService;

  setUpAll(() async {
    await dotenv.load();
    await setUpTestHive();
    testBox = await Hive.openBox('movienest_data');
    mockAccountRepository = MockAccountRepository();
    mockSessionService = MockSessionService();

    GetIt.I.registerSingleton<AccountRepository>(mockAccountRepository);
    GetIt.I.registerSingleton<SessionService>(mockSessionService);
  });

  setUp(() {
    mockDio = MockDio();
    movieService = MovieService(dio: mockDio);
  });

  tearDown(() async {
    await testBox.clear(); // Очищаем кэш между тестами
  });

  tearDownAll(() async {
    await Hive.close(); // Закрываем Hive после всех тестов
  });

  test('getPopularMovies должен вернуть данные популярных фильмов', () async {
    const fakePage = 1;
    final fakeResponse = {
      'results': [
        {'id': 1, 'title': 'Fake Movie 1'},
        {'id': 2, 'title': 'Fake Movie 2'},
      ]
    };

    when(mockDio.getUri(any)).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: fakeResponse,
        ));

    final result = await movieService.getPopularMovies(fakePage);

    expect(result, fakeResponse);

    verify(mockDio.getUri(any)).called(1);
  });

  test('getMovieDetails должен вернуть данные фильма', () async {
    const movieId = 123;
    final fakeResponse = {
      'id': movieId,
      'title': 'Fake Movie Title',
      'credits': {},
      'videos': {},
    };

    when(mockDio.getUri(any)).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: fakeResponse,
        ));

    final result = await movieService.getMovieDetails(movieId);

    expect(result, fakeResponse);

    verify(mockDio.getUri(any)).called(1);
  });

  test('markAsFavorite должен отправить запрос и вернуть 1 при успехе', () async {
  const mediaId = 123;
  const isFavorite = true;
  final fakeResponse = {'status_code': 1};

  when(mockAccountRepository.getAccountId()).thenAnswer((_) async => 'fake_account_id');
  when(mockSessionService.getSessionId()).thenAnswer((_) async => 'fake_session_id');

  when(mockDio.postUri(any, data: anyNamed('data'), options: anyNamed('options')))
      .thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 201,
            data: fakeResponse,
          ));

  final result = await movieService.markAsFavorite(
    mediaType: MediaType.movie,
    mediaId: mediaId,
    isFavorite: isFavorite,
  );

  // Ожидаем 1
  expect(result, 1);

  // Проверяем вызовы
  verify(mockAccountRepository.getAccountId()).called(1);
  verify(mockSessionService.getSessionId()).called(1);
  verify(mockDio.postUri(any, data: anyNamed('data'), options: anyNamed('options'))).called(1);
});

}

