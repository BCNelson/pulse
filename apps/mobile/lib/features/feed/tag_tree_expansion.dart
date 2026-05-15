import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Tracks which tag paths in the sidebar tree are expanded. Lives outside
/// the widget tree so it survives `FeedScreen` remounts — navigation
/// between `/feed`, `/feed/t/<path>`, `/feed/p/<id>` pushes a fresh
/// `FeedScreen` page, which would otherwise reset per-node `bool _expanded`
/// state and visually collapse the SPACES section on every tag click.
class TagTreeExpansionNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => <String>{};

  void toggle(String path) {
    final next = {...state};
    if (!next.remove(path)) next.add(path);
    state = next;
  }

  /// Marks every ancestor (and the path itself) of [segments] as expanded.
  /// For `['programming', 'rust']` this adds both `'programming'` and
  /// `'programming/rust'`. Only the root level is expandable in the current
  /// tree UI, but emitting all prefixes keeps this forward-compatible.
  void expandAncestors(List<String> segments) {
    if (segments.isEmpty) return;
    final next = {...state};
    final buf = StringBuffer();
    for (var i = 0; i < segments.length; i++) {
      if (i > 0) buf.write('/');
      buf.write(segments[i]);
      next.add(buf.toString());
    }
    if (next.length != state.length) state = next;
  }
}

final expandedTagPathsProvider =
    NotifierProvider<TagTreeExpansionNotifier, Set<String>>(
  TagTreeExpansionNotifier.new,
);
