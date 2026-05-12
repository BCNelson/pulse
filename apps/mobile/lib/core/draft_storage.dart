import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'prefs_provider.dart';
import 'ui_state_storage.dart';

/// Read/write composer drafts. Drafts are scoped to a post and an
/// optional reply target, so a root-level draft and a draft replying
/// to comment X on the same post are stored separately.
class DraftStorage {
  DraftStorage(this._storage);

  final UiStateStorage _storage;

  String? read(String postId, String? replyTargetCommentId) =>
      _storage.readString(UiStateStorage.draftKey(postId, replyTargetCommentId));

  Future<void> write(
    String postId,
    String? replyTargetCommentId,
    String text,
  ) =>
      _storage.writeString(
        UiStateStorage.draftKey(postId, replyTargetCommentId),
        text.isEmpty ? null : text,
      );

  Future<void> clear(String postId, String? replyTargetCommentId) =>
      _storage.writeString(
        UiStateStorage.draftKey(postId, replyTargetCommentId),
        null,
      );
}

final draftStorageProvider = Provider<DraftStorage>((ref) {
  return DraftStorage(ref.watch(uiStateStorageProvider));
});
