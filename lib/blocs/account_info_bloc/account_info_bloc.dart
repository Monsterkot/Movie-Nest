import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_nest_app/repositories/account_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../models/account_info.dart';

part 'account_info_event.dart';
part 'account_info_state.dart';

class AccountInfoBloc extends Bloc<AccountInfoEvent, AccountInfoState> {
  AccountInfoBloc() : super(AccountInfoLoading()) {
    on<LoadAccountInfoEvent>((event, emit) async {
      try {
        emit(AccountInfoLoading());
        final accountInfo =
            await GetIt.I<AccountRepository>().fetchAccountInfo();
        emit(AccountInfoLoaded(accountInfo));
      } catch (e, st) {
        GetIt.I<Talker>().handle(e, st);
        emit(AccountInfoError('Something went wrong, try again later'));
      }
    });
  }
}