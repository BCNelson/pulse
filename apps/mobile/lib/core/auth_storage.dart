import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Stores the session token in OS-keychain-equivalent secure storage so
/// it survives app restarts. v1 keeps it simple: one token per device.
class AuthStorage {
  AuthStorage([FlutterSecureStorage? storage])
      : _storage = storage ?? const FlutterSecureStorage();

  static const _tokenKey = 'pulse.session.token';
  static const _emailKey = 'pulse.session.email';

  final FlutterSecureStorage _storage;

  Future<void> save({required String token, required String email}) async {
    await _storage.write(key: _tokenKey, value: token);
    await _storage.write(key: _emailKey, value: email);
  }

  Future<String?> readToken() => _storage.read(key: _tokenKey);
  Future<String?> readEmail() => _storage.read(key: _emailKey);

  Future<void> clear() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _emailKey);
  }
}
