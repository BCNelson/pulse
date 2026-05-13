import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/features/post_detail/comment_tree.dart';

CommentSummary _c(
  String id, {
  String? parent,
  int depth = 0,
  bool optimistic = false,
}) =>
    CommentSummary(
      id: id,
      parentId: parent,
      depth: depth,
      isOptimistic: optimistic,
      body: 'body $id',
      authorDisplayName: 'author $id',
      createdAtIso: '2026-01-01T00:00:00Z',
    );

/// Helper: collapse a row to a compact tuple for easy assertions.
({String id, int depth, List<bool> isLast, bool hasOwn, bool isCollapsed})
    _summary(RowState r) {
  return switch (r) {
    CommentRowState() => (
      id: r.comment.id,
      depth: r.depth,
      isLast: r.isLastSibling,
      hasOwn: r.hasOwnTrunk,
      isCollapsed: r.isCollapsed,
    ),
    StubRowState() => (
      id: '<stub:${r.parentId}>',
      depth: r.depth,
      isLast: r.isLastSibling,
      hasOwn: false,
      isCollapsed: false,
    ),
  };
}

void main() {
  group('buildCommentRows', () {
    test('empty input', () {
      expect(buildCommentRows(flat: [], collapsedSubtrees: {}), isEmpty);
    });

    test('single root', () {
      final rows = buildCommentRows(flat: [_c('a')], collapsedSubtrees: {});
      expect(rows, hasLength(1));
      final r = rows.single as CommentRowState;
      expect(r.depth, 0);
      expect(r.isLastSibling, isEmpty);
      expect(r.hasOwnTrunk, isFalse);
      expect(r.isCollapsed, isFalse);
    });

    test('linear chain — isLastSibling all true after first step', () {
      // a → b → c → d. b/c/d are each the only child of their parent.
      final rows = buildCommentRows(
        flat: [
          _c('a'),
          _c('b', parent: 'a', depth: 1),
          _c('c', parent: 'b', depth: 2),
          _c('d', parent: 'c', depth: 3),
        ],
        collapsedSubtrees: {},
      );
      final summaries = rows.map(_summary).toList();
      expect(summaries[0].id, 'a');
      expect(summaries[0].isLast, isEmpty);
      expect(summaries[0].hasOwn, isTrue);

      expect(summaries[1].id, 'b');
      expect(summaries[1].isLast, [true]); // only child of a
      expect(summaries[1].hasOwn, isTrue);

      expect(summaries[2].id, 'c');
      expect(summaries[2].isLast, [true, true]);
      expect(summaries[2].hasOwn, isTrue);

      expect(summaries[3].id, 'd');
      expect(summaries[3].isLast, [true, true, true]);
      expect(summaries[3].hasOwn, isFalse);
    });

    test('Y-shape: two siblings, second has subtree', () {
      // a → b (first, leaf), a → c (last) → c1 (leaf)
      final rows = buildCommentRows(
        flat: [
          _c('a'),
          _c('b', parent: 'a', depth: 1),
          _c('c', parent: 'a', depth: 1),
          _c('c1', parent: 'c', depth: 2),
        ],
        collapsedSubtrees: {},
      );
      final byId = {
        for (final r in rows.whereType<CommentRowState>())
          r.comment.id: r,
      };
      expect(byId['b']!.isLastSibling, [false]); // not last child of a
      expect(byId['b']!.hasOwnTrunk, isFalse);
      expect(byId['c']!.isLastSibling, [true]); // last child of a
      expect(byId['c']!.hasOwnTrunk, isTrue);
      expect(byId['c1']!.isLastSibling, [true, true]);
      expect(byId['c1']!.hasOwnTrunk, isFalse);
    });

    test('V3 shape: mixed last-sibling chain', () {
      // Mirrors seed: A → A1 → A2 → A3 → A4 → A5 → V3,
      // where A1 not last (S1 after), A2 only, A3 not last (U1 after),
      // A4 only, A5 only, V3 last.
      final rows = buildCommentRows(
        flat: [
          _c('A'),
          _c('A1', parent: 'A', depth: 1),
          _c('A2', parent: 'A1', depth: 2),
          _c('A3', parent: 'A2', depth: 3),
          _c('A4', parent: 'A3', depth: 4),
          _c('A5', parent: 'A4', depth: 5),
          _c('V3', parent: 'A5', depth: 6),
          _c('U1', parent: 'A2', depth: 3),
          _c('S1', parent: 'A', depth: 1),
        ],
        collapsedSubtrees: {},
      );
      final v3 = rows.whereType<CommentRowState>()
          .firstWhere((r) => r.comment.id == 'V3');
      expect(v3.depth, 6);
      expect(v3.isLastSibling, [false, true, false, true, true, true]);
      expect(v3.hasOwnTrunk, isFalse);
    });

    test('collapsed subtree emits a stub with the right isLastSibling', () {
      final rows = buildCommentRows(
        flat: [
          _c('a'),
          _c('b', parent: 'a', depth: 1),
          _c('c', parent: 'b', depth: 2),
          _c('d', parent: 'c', depth: 3),
        ],
        collapsedSubtrees: {'b'},
      );
      // a, b(collapsed), stub(b)
      expect(rows, hasLength(3));
      final b = rows[1] as CommentRowState;
      expect(b.comment.id, 'b');
      expect(b.isCollapsed, isTrue);
      expect(b.hasOwnTrunk, isTrue);
      final stub = rows[2] as StubRowState;
      expect(stub.parentId, 'b');
      expect(stub.depth, 2);
      // b's isLastSibling = [true]; stub's = [true, true]
      expect(stub.isLastSibling, [true, true]);
      expect(stub.hiddenCount, 2); // c + d
    });

    test('collapsing a leaf is a no-op', () {
      final rows = buildCommentRows(
        flat: [_c('a'), _c('b', parent: 'a', depth: 1)],
        collapsedSubtrees: {'b'},
      );
      expect(rows.whereType<StubRowState>(), isEmpty);
      final b = rows.whereType<CommentRowState>()
          .firstWhere((r) => r.comment.id == 'b');
      expect(b.isCollapsed, isFalse);
      expect(b.hasOwnTrunk, isFalse);
    });

    test('optimistic descendant force-opens its ancestor', () {
      final rows = buildCommentRows(
        flat: [
          _c('a'),
          _c('b', parent: 'a', depth: 1),
          _c('c', parent: 'b', depth: 2),
          _c('opt-x', parent: 'c', depth: 3, optimistic: true),
        ],
        collapsedSubtrees: {'b'},
      );
      // b's collapse is overridden; all rows render normally.
      expect(rows.whereType<StubRowState>(), isEmpty);
      expect(
        rows.whereType<CommentRowState>().map((r) => r.comment.id).toList(),
        ['a', 'b', 'c', 'opt-x'],
      );
    });

    test('multiple roots — each isLastSibling is empty (depth 0)', () {
      final rows = buildCommentRows(
        flat: [
          _c('a'),
          _c('x'),
          _c('x1', parent: 'x', depth: 1),
        ],
        collapsedSubtrees: {},
      );
      final roots = rows
          .whereType<CommentRowState>()
          .where((r) => r.depth == 0)
          .toList();
      expect(roots, hasLength(2));
      expect(roots.every((r) => r.isLastSibling.isEmpty), isTrue);
    });

    test('null collapsedSubtrees == empty set', () {
      final rows = buildCommentRows(
        flat: [_c('a'), _c('b', parent: 'a', depth: 1)],
        collapsedSubtrees: null,
      );
      expect(rows.whereType<StubRowState>(), isEmpty);
      expect(rows, hasLength(2));
    });
  });
}
