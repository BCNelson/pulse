import 'package:shared_preferences/shared_preferences.dart';

import 'instance_id.dart';

/// Backing store for small bits of UI state we want to survive process
/// death: which shell tab was active, which post was open, composer
/// drafts, etc. Mirrors the SharedPreferences pattern used by
/// [ServerConfigStorage] and the theme controller.
class UiStateStorage {
  UiStateStorage(this._prefs);

  final SharedPreferences _prefs;

  static String lastRouteKey = namespacedKey('pulse.ui.lastRoute');
  static String cacheMaxBytesKey = namespacedKey('pulse.cache.maxBytes');
  static String feedListWidthKey = namespacedKey('pulse.ui.feedListWidth');

  /// Per-post reply target JSON. Keyed by post so reply state attaches
  /// to the post the user was on, not to the global session.
  static String replyTargetKey(String postId) =>
      namespacedKey('pulse.ui.replyTarget.$postId');

  /// Composer draft text. [replyTargetCommentId] is null for top-level
  /// drafts on a post.
  static String draftKey(String postId, String? replyTargetCommentId) =>
      namespacedKey(
        'pulse.ui.draft.$postId.${replyTargetCommentId ?? 'root'}',
      );

  /// Default on-device budget for the persistent posts/chats cache.
  /// User-configurable from the cache settings screen; the evictor
  /// reads this value (or the user's override) on every write.
  static const int defaultCacheMaxBytes = 100 * 1024 * 1024;

  /// Hard floor/ceiling for the user-facing slider. Values outside this
  /// range are clamped on write.
  static const int minCacheMaxBytes = 20 * 1024 * 1024;
  static const int maxCacheMaxBytes = 500 * 1024 * 1024;

  String? readString(String key) => _prefs.getString(key);

  Future<void> writeString(String key, String? value) async {
    if (value == null) {
      await _prefs.remove(key);
      return;
    }
    await _prefs.setString(key, value);
  }

  double? readDouble(String key) => _prefs.getDouble(key);

  Future<void> writeDouble(String key, double? value) async {
    if (value == null) {
      await _prefs.remove(key);
      return;
    }
    await _prefs.setDouble(key, value);
  }

  /// Returns the user-selected cache budget in bytes, or the default
  /// if unset. Clamped to [minCacheMaxBytes]..[maxCacheMaxBytes].
  int readCacheMaxBytes() {
    final v = _prefs.getInt(cacheMaxBytesKey);
    if (v == null) return defaultCacheMaxBytes;
    if (v < minCacheMaxBytes) return minCacheMaxBytes;
    if (v > maxCacheMaxBytes) return maxCacheMaxBytes;
    return v;
  }

  Future<void> writeCacheMaxBytes(int bytes) async {
    final clamped = bytes < minCacheMaxBytes
        ? minCacheMaxBytes
        : (bytes > maxCacheMaxBytes ? maxCacheMaxBytes : bytes);
    await _prefs.setInt(cacheMaxBytesKey, clamped);
  }
}
