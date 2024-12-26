import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_nest_app/models/account_info/account_info.dart';
import 'package:movie_nest_app/services/account_service.dart';

class AccountRepository {
  final _accountService = GetIt.I<AccountService>();

  Future<AccountInfo> getAccountInfo() async {
    final accountData = await _accountService.getAccountInfo();

    return AccountInfo(
      id: accountData['id'],
      name: accountData['name'] ?? 'Unknown',
      username: accountData['username'],
      avatarPath: accountData['avatar']['tmdb']['avatar_path'] ?? '',
    );
  }

  Future<String> getAccountId() async {
    String? accountId = await GetIt.I<FlutterSecureStorage>().read(key: 'account_id');
    if (accountId == null) {
      final accountInfo = await getAccountInfo();
      accountId = accountInfo.id.toString();
     GetIt.I<FlutterSecureStorage>().write(key: 'account_id', value: accountId);
    }
    return accountId;
  }
}
