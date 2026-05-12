import 'package:shared_preferences/shared_preferences.dart';

import 'instance_id.dart';

/// Backing store for small bits of UI state we want to survive process
/// death: which shell tab was active, which post was open, composer
/// drafts, etc. Mirrors the SharedPreferences pattern used by
/// [ServerConfigStorage] and the theme controller.
class UiStateStorage {
  UiStateStorage(this._prefs);

  final SharedPreferences _prefs;

  static String shellTabKey = namespacedKey('pulse.ui.shellTab');
  static String selectedTagIdKey = namespacedKey('pulse.ui.selectedTagId');
  static String selectedPostIdKey = namespacedKey('pulse.ui.selectedPostId');
  static String selectedRoomIdKey = namespacedKey('pulse.ui.selectedRoomId');

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

  String? readString(String key) => _prefs.getString(key);

  Future<void> writeString(String key, String? value) async {
    if (value == null) {
      await _prefs.remove(key);
      return;
    }
    await _prefs.setString(key, value);
  }
}
