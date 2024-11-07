import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_nest_app/router/router.gr.dart';
import 'package:movie_nest_app/services/session_service.dart';

class AuthGuard extends AutoRouteGuard {

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (GetIt.I<SessionService>().isAuthenticated) {
      resolver.redirect(const HomeRoute());
    } else {
      resolver.next(true);
    }
  }
}