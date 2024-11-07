import 'package:auto_route/auto_route.dart';
import 'package:movie_nest_app/router/auth_guard.dart';
import 'package:movie_nest_app/router/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: AuthRoute.page,
          path: '/auth',
          initial: true,
          guards: [AuthGuard()],
        ),
        AutoRoute(page: HomeRoute.page, path: '/home'),
        AutoRoute(page: MovieDetailsRoute.page, path: '/home/movie_details'),
        AutoRoute(page: ActorInfoRoute.page, path: '/movie_details/actor_info'),
        AutoRoute(page: TvShowDetailsRoute.page, path: '/home/tv_show_details'),
        AutoRoute(page: AccountRoute.page, path: '/user_account'),
        RedirectRoute(path: '*', redirectTo: '/error'),
        AutoRoute(page: ErrorRoute.page, path: '/error'),
      ];


  

}
