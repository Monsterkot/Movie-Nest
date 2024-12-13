import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:movie_nest_app/repositories/account_repository.dart';
import 'package:movie_nest_app/repositories/person_repository.dart';
import 'package:movie_nest_app/repositories/trending_repository.dart';
import 'package:movie_nest_app/repositories/tv_show_repository.dart';
import 'package:movie_nest_app/services/account_service.dart';
import 'package:movie_nest_app/services/auth_service.dart';
import 'package:movie_nest_app/services/movie_service.dart';
import 'package:movie_nest_app/services/person_service.dart';
import 'package:movie_nest_app/services/session_service.dart';
import 'package:movie_nest_app/services/trending_service.dart';
import 'package:movie_nest_app/services/tv_show_service.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:movie_nest_app/movie_nest_app.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'repositories/movie_repository.dart';

void main() {
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton(talker);

  final dio = Dio();
  dio.interceptors.add(
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printResponseData: false,
      ),
    ),
  );
  
  GetIt.I.registerLazySingleton<AuthService>(() => AuthService(dio: dio));
  GetIt.I.registerLazySingleton<SessionService>(() => SessionService());
  GetIt.I.registerLazySingleton<AccountService>(() => AccountService(dio: dio));
  GetIt.I.registerLazySingleton<MovieService>(() => MovieService(dio: dio));
  GetIt.I.registerLazySingleton<TvShowService>(() => TvShowService(dio: dio));
  GetIt.I.registerLazySingleton<TrendingService>(() => TrendingService(dio: dio));
  GetIt.I.registerLazySingleton<PersonService>(() => PersonService(dio: dio));

  GetIt.I.registerLazySingleton<MovieRepository>(() => MovieRepository());
  GetIt.I.registerLazySingleton<AccountRepository>(() => AccountRepository());
  GetIt.I.registerLazySingleton<TvShowRepository>(() => TvShowRepository());
  GetIt.I.registerLazySingleton<TrendingRepository>(() => TrendingRepository());
  GetIt.I.registerLazySingleton<PersonRepository>(() => PersonRepository());

  Bloc.observer = TalkerBlocObserver(
      talker: talker,
      settings: const TalkerBlocLoggerSettings(
        printStateFullData: false,
        printEventFullData: false,
      ));

  FlutterError.onError = (details) => GetIt.I<Talker>().handle(details.exception, details.stack);

  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await GetIt.I<SessionService>().checkSession();
      // GetIt.I<Talker>()
      //     .info(await GetIt.I<SessionService>().getSessionId());
      await dotenv.load(fileName: '.env');
      runApp(MovieNestApp());
    },
    (e, st) => GetIt.I<Talker>().handle(e, st),
  );
}
