part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String sessionId;

  AuthSuccess(this.sessionId);
}

class AuthFailure extends AuthState {
  AuthFailure({required this.errorMessage});
  
  final String errorMessage;
}
