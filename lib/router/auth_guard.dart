import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_nest_app/router/router.gr.dart';
import 'package:movie_nest_app/services/session_service.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (GetIt.I<SessionService>().isAuthenticated) {
      //setAccountId();
      resolver.redirect(const MainHomeRoute());
    } else {
      resolver.next(true);
    }
  }

  // Future<void> setAccountId() async {
  //   final accountId = await GetIt.I<AccountRepository>().getAccountId();
  //   GetIt.I<FlutterSecureStorage>().write(key: 'account_id', value: accountId.toString());
  // }
}
