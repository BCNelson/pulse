import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'prefs_provider.dart';
import 'router.dart';
import 'ui_state_storage.dart';

class ReplyTarget {
  const ReplyTarget({
    required this.commentId,
    required this.authorDisplayName,
    this.body,
  });

  final String commentId;
  final String authorDisplayName;
  final String? body;

  Map<String, dynamic> toJson() => {
        'commentId': commentId,
        'authorDisplayName': authorDisplayName,
        if (body != null) 'body': body,
      };

  static ReplyTarget? tryFromJson(Object? raw) {
    if (raw is! Map) return null;
    final commentId = raw['commentId'];
    final author = raw['authorDisplayName'];
    if (commentId is! String || author is! String) return null;
    final body = raw['body'];
    return ReplyTarget(
      commentId: commentId,
      authorDisplayName: author,
      body: body is String ? body : null,
    );
  }
}

/// Holds the comment the composer is currently replying to. Null means
/// the next submission is a top-level comment on the open post.
///
/// Persisted per-post (keyed by [currentPostIdProvider]) so reply state
/// attaches to the post rather than the global session — moving between
/// posts doesn't carry the reply target along.
class _ReplyingToCommentNotifier extends Notifier<ReplyTarget?> {
  @override
  ReplyTarget? build() {
    final postId = ref.watch(currentPostIdProvider);
    if (postId == null) return null;
    final raw = ref
        .read(uiStateStorageProvider)
        .readString(UiStateStorage.replyTargetKey(postId));
    if (raw == null) return null;
    try {
      return ReplyTarget.tryFromJson(jsonDecode(raw));
    } catch (_) {
      return null;
    }
  }

  void set(ReplyTarget? value) {
    state = value;
    final postId = ref.read(currentPostIdProvider);
    if (postId == null) return;
    final storage = ref.read(uiStateStorageProvider);
    storage.writeString(
      UiStateStorage.replyTargetKey(postId),
      value == null ? null : jsonEncode(value.toJson()),
    );
  }
}

final replyingToCommentProvider =
    NotifierProvider<_ReplyingToCommentNotifier, ReplyTarget?>(
  _ReplyingToCommentNotifier.new,
);
