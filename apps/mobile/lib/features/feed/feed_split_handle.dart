import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../design/tokens.dart';
import 'feed_split_width.dart';

/// Draggable hair-line divider between the post-list pane and the
/// post-detail pane. Renders a 1px line centered inside a wider
/// transparent hit area so it's comfortable to grab with a mouse.
class FeedSplitHandle extends ConsumerWidget {
  const FeedSplitHandle({super.key, required this.availableWidth});

  /// Width of the Row that hosts list + handle + detail. Used to clamp
  /// the post-list width so the detail pane keeps at least
  /// [feedDetailMinWidth] of space.
  final double availableWidth;

  static const double _hitWidth = 13;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    return MouseRegion(
      cursor: SystemMouseCursors.resizeColumn,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        dragStartBehavior: DragStartBehavior.down,
        onHorizontalDragUpdate: (details) {
          final maxList = availableWidth - feedDetailMinWidth - _hitWidth;
          final upper = maxList < feedListMinWidth ? feedListMinWidth : maxList;
          final current = ref.read(feedListWidthProvider);
          final next = (current + details.delta.dx).clamp(feedListMinWidth, upper);
          ref.read(feedListWidthProvider.notifier).set(next);
        },
        child: SizedBox(
          width: _hitWidth,
          child: Center(
            child: Container(width: 1, color: t.hair),
          ),
        ),
      ),
    );
  }
}
