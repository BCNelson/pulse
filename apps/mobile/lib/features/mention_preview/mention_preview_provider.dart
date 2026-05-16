import 'package:flutter_riverpod/flutter_riverpod.dart';

/// What the preview panel is currently showing. `null` means the panel
/// is closed. The two variants carry the canonical slug / slug-path
/// extracted from the mention link's URL scheme.
sealed class MentionPreviewTarget {
  const MentionPreviewTarget();
}

class MentionPreviewUserTarget extends MentionPreviewTarget {
  const MentionPreviewUserTarget(this.slug);
  final String slug;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MentionPreviewUserTarget && other.slug == slug);

  @override
  int get hashCode => Object.hash('user', slug);
}

class MentionPreviewTagTarget extends MentionPreviewTarget {
  const MentionPreviewTagTarget(this.path);

  /// Full slug path from the canonical `pulse-tag:` URL, e.g. `org/engineering`.
  final String path;

  List<String> get segments =>
      path.split('/').where((s) => s.isNotEmpty).toList(growable: false);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MentionPreviewTagTarget && other.path == path);

  @override
  int get hashCode => Object.hash('tag', path);
}

class MentionPreviewController extends Notifier<MentionPreviewTarget?> {
  @override
  MentionPreviewTarget? build() => null;

  void showUser(String slug) {
    state = MentionPreviewUserTarget(slug);
  }

  void showTag(String path) {
    state = MentionPreviewTagTarget(path);
  }

  void close() {
    state = null;
  }
}

final mentionPreviewProvider =
    NotifierProvider<MentionPreviewController, MentionPreviewTarget?>(
  MentionPreviewController.new,
);
