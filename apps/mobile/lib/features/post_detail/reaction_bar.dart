import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ferry_client.dart';
import '../../design/tokens.dart';
import '../../design/typography.dart';
import '../../graphql/operations/__generated__/posts.req.gql.dart';

typedef ReactionInfo = ({String emoji, int count, bool byViewer});

class ReactionBar extends ConsumerWidget {
  const ReactionBar({super.key, required this.postId, required this.reactions});

  final String postId;
  final List<ReactionInfo> reactions;

  static const _quickEmoji = ['👍', '❤️', '🎉', '🚀', '👀'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final client = ref.watch(ferryClientProvider);
    final shown = {for (final r in reactions) r.emoji: r};
    final allEmoji = <String>{...shown.keys, ..._quickEmoji};
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        for (final emoji in allEmoji)
          _ReactionChip(
            emoji: emoji,
            info: shown[emoji],
            onTap: () {
              if (shown[emoji]?.byViewer == true) {
                client.requestController.add(
                  GUnreactToPostReq(
                    (b) => b
                      ..vars.postId = postId
                      ..vars.emoji = emoji,
                  ),
                );
              } else {
                client.requestController.add(
                  GReactToPostReq(
                    (b) => b
                      ..vars.postId = postId
                      ..vars.emoji = emoji,
                  ),
                );
              }
            },
          ),
      ],
    );
  }
}

class _ReactionChip extends StatelessWidget {
  const _ReactionChip({
    required this.emoji,
    required this.info,
    required this.onTap,
  });

  final String emoji;
  final ReactionInfo? info;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final count = info?.count ?? 0;
    final byViewer = info?.byViewer ?? false;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: byViewer ? t.paper2 : t.paper,
          border: Border.all(
            color: byViewer ? t.ink : t.hair,
            width: byViewer ? 1.2 : 1.0,
          ),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 13, height: 1.0)),
            if (count > 0) ...[
              const SizedBox(width: 4),
              Text(
                '$count',
                style: TextStyle(
                  fontFamily: pulseMonoFamily,
                  fontSize: 10.5,
                  color: t.ink2,
                  height: 1.0,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
