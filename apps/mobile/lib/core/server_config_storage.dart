import 'package:shared_preferences/shared_preferences.dart';

import 'instance_id.dart';

/// Persists the normalized server base URL so first-run users only have
/// to enter it once. Mirrors the SharedPreferences pattern used by the
/// theme controller.
class ServerConfigStorage {
  ServerConfigStorage([SharedPreferences? prefs]) : _prefs = prefs;

  static final _baseUrlKey = namespacedKey('pulse.server.baseUrl');

  SharedPreferences? _prefs;

  Future<SharedPreferences> _ensure() async =>
      _prefs ??= await SharedPreferences.getInstance();

  Future<String?> read() async {
    final prefs = await _ensure();
    return prefs.getString(_baseUrlKey);
  }

  Future<void> save(String baseUrl) async {
    final prefs = await _ensure();
    await prefs.setString(_baseUrlKey, baseUrl);
  }

  Future<void> clear() async {
    final prefs = await _ensure();
    await prefs.remove(_baseUrlKey);
  }
}
