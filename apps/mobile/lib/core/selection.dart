import 'package:flutter_riverpod/legacy.dart';

/// selectedTagIdProvider holds the id of the tag the user is currently
/// browsing. Null means "no tag selected" — the list pane shows a
/// placeholder. Persisting selection across restarts is M5.B work.
final selectedTagIdProvider = StateProvider<String?>((ref) => null);

/// selectedPostIdProvider holds the id of the post the user has open in
/// the detail pane. Null means "no post selected" — the detail pane
/// shows a placeholder.
final selectedPostIdProvider = StateProvider<String?>((ref) => null);

/// selectedRoomIdProvider for chat. Null = no room selected.
final selectedRoomIdProvider = StateProvider<String?>((ref) => null);

class ReplyTarget {
  const ReplyTarget({
    required this.commentId,
    required this.authorDisplayName,
    this.body,
  });
  final String commentId;
  final String authorDisplayName;
  final String? body;
}

/// replyingToCommentProvider holds the comment the composer is currently
/// replying to. Null means the next submission is a top-level comment on
/// the open post.
final replyingToCommentProvider = StateProvider<ReplyTarget?>((ref) => null);
