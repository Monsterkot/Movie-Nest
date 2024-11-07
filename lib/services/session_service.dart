import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionService {
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;
  final _secureStorage = const FlutterSecureStorage();
  Future<void> setSessionId(String sessionId) async {
    await _secureStorage.write(key: 'session_id', value: sessionId);
    _isAuthenticated = true;
  }

  Future<String?> getSessionId() async {
    return await _secureStorage.read(key: 'session_id');
  }

  Future<void> clearSessionId() async {
    await _secureStorage.delete(key: 'session_id');
    _isAuthenticated = false;
  }

  Future<bool> checkSession() async {
    String? sessionId = await getSessionId();
    if (sessionId != null) {
      _isAuthenticated = true;
      return true;
    } else {
      _isAuthenticated = false;
      return false;
    }
  }
}
