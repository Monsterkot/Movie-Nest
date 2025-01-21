import 'dart:async';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_nest_app/firebase_options.dart';
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
  _initializeDependencies();
  
  
  runZonedGuarded(
    () async {
      _initializeFlutterBindings();
      await _initializeFirebase();
      await _initializeHive();
      await _checkSession();
      runApp(MovieNestApp());
    },
    (e, st) => GetIt.I<Talker>().handle(e, st),
  );
}

void _initializeDependencies() {
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

  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      printStateFullData: false,
      printEventFullData: false,
    ),
  );

  FlutterError.onError = (details) => GetIt.I<Talker>().handle(details.exception, details.stack);

  GetIt.I.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());

  // Регистрация сервисов
  _registerServices(dio);
  _registerRepositories();
}

void _registerServices(Dio dio) {
  GetIt.I.registerLazySingleton<AuthService>(() => AuthService(dio: dio));
  GetIt.I.registerLazySingleton<SessionService>(() => SessionService());
  GetIt.I.registerLazySingleton<AccountService>(() => AccountService(dio: dio));
  GetIt.I.registerLazySingleton<MovieService>(() => MovieService(dio: dio));
  GetIt.I.registerLazySingleton<TvShowService>(() => TvShowService(dio: dio));
  GetIt.I.registerLazySingleton<TrendingService>(() => TrendingService(dio: dio));
  GetIt.I.registerLazySingleton<PersonService>(() => PersonService(dio: dio));
}

void _registerRepositories() {
  GetIt.I.registerLazySingleton<MovieRepository>(() => MovieRepository());
  GetIt.I.registerLazySingleton<AccountRepository>(() => AccountRepository());
  GetIt.I.registerLazySingleton<TvShowRepository>(() => TvShowRepository());
  GetIt.I.registerLazySingleton<TrendingRepository>(() => TrendingRepository());
  GetIt.I.registerLazySingleton<PersonRepository>(() => PersonRepository());
}

void _initializeFlutterBindings() {
  WidgetsFlutterBinding.ensureInitialized();
}

Future<void> _initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    final notification = message.notification;
    final android = message.notification?.android;

    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: 'launcher_icon',
          ),
        ),
      );
    }
  });

  messaging.getToken().then((token) => log(token ?? 'No token'));
}

Future<void> _initializeHive() async {
  await Hive.initFlutter();
  await Hive.openBox('movienest_data');
}

Future<void> _checkSession() async {
  await GetIt.I<SessionService>().checkSession();
  GetIt.I<Talker>().info(await GetIt.I<SessionService>().getSessionId());
  await dotenv.load(fileName: '.env');
}
