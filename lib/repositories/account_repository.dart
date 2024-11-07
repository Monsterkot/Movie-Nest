import 'package:get_it/get_it.dart';
import 'package:movie_nest_app/models/account_info.dart';
import 'package:movie_nest_app/services/account_service.dart';

class AccountRepository {
  final _accountService = GetIt.I<AccountService>();

  Future<AccountInfo> fetchAccountInfo() async {
    final accountData = await _accountService.getAccountInfo();

    return AccountInfo(
      id: accountData['id'],
      name: accountData['name'] ?? 'Unknown',
      username: accountData['username'],
      avatarPath: accountData['avatar']['tmdb']['avatar_path'] ?? '',
    );
  }
}
