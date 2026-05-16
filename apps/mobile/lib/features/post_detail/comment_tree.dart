/// Pure rendering model for the comment view.
///
/// Emits a flat list of `RowState`s — one per visible row (comments and
/// collapse stubs). Each row carries an `isLastSibling` chain describing
/// its DFS path; the renderer applies a single invariant — draw the line
/// at column `k` iff `!isLastSibling[k]` — to produce the trunk pieces.
library;

class CommentSummary {
  const CommentSummary({
    required this.id,
    required this.parentId,
    required this.depth,
    required this.isOptimistic,
    required this.body,
    required this.authorDisplayName,
    this.authorSlug,
    required this.createdAtIso,
  });

  final String id;
  final String? parentId;
  final int depth;
  final bool isOptimistic;
  final String body;
  final String authorDisplayName;

  /// User-tag slug of the comment author, when available. Drives the
  /// hover-card affordance on the author byline.
  final String? authorSlug;
  final String createdAtIso;
}

sealed class RowState {
  const RowState();

  int get depth;

  /// Length == [depth]. `isLastSibling[i]` is true iff the node at depth
  /// `i+1` in this row's ancestor path is the last child of the node at
  /// depth `i`.
  List<bool> get isLastSibling;
}

class CommentRowState extends RowState {
  const CommentRowState({
    required this.comment,
    required this.depth,
    required this.isLastSibling,
    required this.hasOwnTrunk,
    required this.isCollapsed,
  });

  final CommentSummary comment;
  @override
  final int depth;
  @override
  final List<bool> isLastSibling;

  /// True iff this comment has rendered content below it (expanded
  /// children OR a collapse stub).
  final bool hasOwnTrunk;

  /// True iff the user has collapsed this subtree (a [StubRowState]
  /// follows in the row list).
  final bool isCollapsed;
}

class StubRowState extends RowState {
  const StubRowState({
    required this.collapsedCommentId,
    required this.depth,
    required this.isLastSibling,
    required this.hiddenCount,
  });

  final String collapsedCommentId;
  @override
  final int depth;
  @override
  final List<bool> isLastSibling;
  final int hiddenCount;
}

/// Builds the flat row list from a flat, DFS-ordered comment list.
///
/// Any optimistic descendant force-opens all of its ancestors so a
/// freshly sent reply never lands behind a collapse stub.
List<RowState> buildCommentRows({
  required List<CommentSummary> flat,
  Set<String>? collapsedSubtrees,
}) {
  if (flat.isEmpty) return const [];

  final childrenOf = <String?, List<CommentSummary>>{};
  for (final c in flat) {
    childrenOf.putIfAbsent(c.parentId, () => <CommentSummary>[]).add(c);
  }

  final effectiveCollapsed = <String>{};
  if (collapsedSubtrees != null) effectiveCollapsed.addAll(collapsedSubtrees);
  effectiveCollapsed.removeAll(_ancestorsOfOptimistic(flat));

  final out = <RowState>[];
  final stack = <bool>[];
  for (final root in childrenOf[null] ?? const <CommentSummary>[]) {
    _walk(root, childrenOf, effectiveCollapsed, stack, out);
  }
  return out;
}

void _walk(
  CommentSummary node,
  Map<String?, List<CommentSummary>> childrenOf,
  Set<String> collapsed,
  List<bool> stack,
  List<RowState> out,
) {
  final kids = childrenOf[node.id] ?? const <CommentSummary>[];
  final hasChildren = kids.isNotEmpty;
  final isCollapsed = hasChildren && collapsed.contains(node.id);
  final isLastSibling = List<bool>.unmodifiable(stack);

  if (isCollapsed) {
    out.add(StubRowState(
      collapsedCommentId: node.id,
      depth: stack.length,
      isLastSibling: isLastSibling,
      hiddenCount: _subtreeSize(node, childrenOf),
    ));
    return;
  }

  out.add(CommentRowState(
    comment: node,
    depth: stack.length,
    isLastSibling: isLastSibling,
    hasOwnTrunk: hasChildren,
    isCollapsed: false,
  ));

  if (!hasChildren) return;

  for (var i = 0; i < kids.length; i++) {
    final isLast = i == kids.length - 1;
    stack.add(isLast);
    _walk(kids[i], childrenOf, collapsed, stack, out);
    stack.removeLast();
  }
}

int _subtreeSize(
  CommentSummary node,
  Map<String?, List<CommentSummary>> childrenOf,
) {
  var total = 1;
  for (final c in childrenOf[node.id] ?? const <CommentSummary>[]) {
    total += _subtreeSize(c, childrenOf);
  }
  return total;
}

/// Returns the set of comment ids that are ancestors of any optimistic
/// comment (excluding the optimistic comments themselves).
Set<String> _ancestorsOfOptimistic(List<CommentSummary> flat) {
  final byId = <String, CommentSummary>{for (final c in flat) c.id: c};
  final result = <String>{};
  for (final c in flat) {
    if (!c.isOptimistic) continue;
    var cursorId = c.parentId;
    while (cursorId != null) {
      if (!result.add(cursorId)) break;
      cursorId = byId[cursorId]?.parentId;
    }
  }
  return result;
}
