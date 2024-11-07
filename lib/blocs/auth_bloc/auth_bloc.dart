import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_nest_app/services/auth_service.dart';
import 'package:movie_nest_app/services/session_service.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _authService = GetIt.I<AuthService>();
  final _sessionService = GetIt.I<SessionService>();
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoading());
      if (event.username.isEmpty || event.password.isEmpty) {
        emit(AuthFailure(
            errorMessage: 'Username and password fields must be filled in'));
        return;
      }
      try {
        final String? sessionId = await _authService.auth(
            username: event.username, password: event.password);
        if (sessionId == null || sessionId == '') {
          emit(AuthFailure(errorMessage: 'Unknown error, try again later'));
          return;
        } else {
          await _sessionService.setSessionId(sessionId);
          emit(AuthSuccess(sessionId));
        }
      } catch (e, st) {
        GetIt.I<Talker>().handle(e, st);
        emit(AuthFailure(errorMessage: 'Invalid username or password'));
      }
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
