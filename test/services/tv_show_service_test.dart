import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_nest_app/services/tv_show_service.dart';
import 'package:movie_nest_app/constants/media_type.dart';
import 'package:movie_nest_app/repositories/account_repository.dart';
import 'package:movie_nest_app/services/session_service.dart';

// Генерируем моки
@GenerateMocks([Dio, Box, AccountRepository, SessionService])
import 'tv_show_service_test.mocks.dart';

void main() {
  late TvShowService tvShowService;
  late MockDio mockDio;
  late MockAccountRepository mockAccountRepository;
  late MockSessionService mockSessionService;

  setUp(() async {
    await setUpTestHive(); // Используем тестовую БД Hive
    mockDio = MockDio();
    mockAccountRepository = MockAccountRepository();
    mockSessionService = MockSessionService();

    // Открываем тестовый бокс Hive
    await Hive.openBox('movienest_data');

    // Регистрируем зависимости в GetIt
    GetIt.I.registerSingleton<AccountRepository>(mockAccountRepository);
    GetIt.I.registerSingleton<SessionService>(mockSessionService);

    tvShowService = TvShowService(dio: mockDio);

    await dotenv.load();
  });

  tearDown(() async {
    await Hive.close();
    GetIt.I.reset();
  });

  test('getPopularTvShows должен вернуть популярные сериалы', () async {
    const fakePage = 1;
    final fakeResponse = {
      'results': [
        {'id': 1, 'name': 'Fake Show 1'},
        {'id': 2, 'name': 'Fake Show 2'},
      ]
    };

    when(mockDio.getUri(any)).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: fakeResponse,
        ));

    final result = await tvShowService.getPopularTvShows(fakePage);

    expect(result, fakeResponse);
    verify(mockDio.getUri(any)).called(1);
  });

  test('getTvShowDetails должен вернуть информацию о сериале', () async {
    const tvShowId = 123;
    final fakeResponse = {
      'id': tvShowId,
      'name': 'Fake TV Show',
      'credits': {},
      'videos': {},
    };

    when(mockDio.getUri(any)).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: fakeResponse,
        ));

    final result = await tvShowService.getTvShowDetails(tvShowId);

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

    final result = await tvShowService.markAsFavorite(
      mediaType: MediaType.tv,
      mediaId: mediaId,
      isFavorite: isFavorite,
    );

    expect(result, 1);
    verify(mockDio.postUri(any, data: anyNamed('data'), options: anyNamed('options'))).called(1);
  });
}

