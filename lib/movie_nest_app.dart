import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_nest_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:movie_nest_app/blocs/url_launcher_bloc/url_launcher_bloc.dart';
import 'package:movie_nest_app/router/router.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'generated/l10n.dart';
import 'theme/theme.dart';

class MovieNestApp extends StatelessWidget {
  MovieNestApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => UrlLauncherBloc(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        title: 'MovieNest',
        theme: lightTheme,
        routerConfig: _appRouter.config(
          navigatorObservers: () => [
            TalkerRouteObserver(GetIt.I<Talker>()),
          ],
        ),
      ),
    );
  }
}
