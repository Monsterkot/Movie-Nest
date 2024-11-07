part of 'account_info_bloc.dart';

abstract class AccountInfoState {}

class AccountInfoLoading extends AccountInfoState {}

class AccountInfoLoaded extends AccountInfoState {
  final AccountInfo accountInfo;

  AccountInfoLoaded(this.accountInfo);
}

class AccountInfoError extends AccountInfoState {
  final String message;

  AccountInfoError(this.message);
}