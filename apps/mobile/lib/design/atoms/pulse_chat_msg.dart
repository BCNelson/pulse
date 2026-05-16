import 'package:flutter/material.dart';

import '../../features/mention_preview/mention_hoverable.dart';
import '../tokens.dart';
import '../typography.dart';
import 'pulse_markdown_body.dart';
import 'pulse_avatar.dart';

/// Chat message matching `.hf-msg`.
class PulseChatMsg extends StatelessWidget {
  const PulseChatMsg({
    super.key,
    required this.who,
    required this.initials,
    required this.text,
    this.whoSlug,
    this.when,
    this.promoted = false,
    this.promotedNote,
  });

  final String who;
  final String initials;
  final String text;

  /// User-tag slug of the author; when set, the avatar + name group
  /// becomes hoverable (pops a [MentionHoverCard]).
  final String? whoSlug;
  final String? when;
  final bool promoted;
  final String? promotedNote;

  Widget _wrapAvatar(Widget child) {
    if (whoSlug == null || whoSlug!.isEmpty) return child;
    return MentionHoverable.user(slug: whoSlug!, child: child);
  }

  Widget _wrapName(Widget child) {
    if (whoSlug == null || whoSlug!.isEmpty) return child;
    return MentionHoverable.user(slug: whoSlug!, child: child);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _wrapAvatar(PulseAvatar(initials: initials)),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    _wrapName(
                      Text(who,
                          style: TextStyle(
                            fontFamily: pulseMonoFamily,
                            fontSize: 10.5,
                            color: t.ink,
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                          )),
                    ),
                    if (when != null) ...[
                      const SizedBox(width: 6),
                      Text(when!,
                          style: TextStyle(
                            fontFamily: pulseMonoFamily,
                            fontSize: 10.5,
                            color: t.ink3,
                            height: 1.2,
                          )),
                    ],
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 1),
                  padding: promoted
                      ? const EdgeInsets.fromLTRB(6, 4, 6, 4)
                      : EdgeInsets.zero,
                  decoration: promoted
                      ? BoxDecoration(
                          color: t.paper2,
                          border:
                              Border(left: BorderSide(color: t.ink, width: 2)),
                        )
                      : null,
                  child: PulseMarkdownBody(data: text, compact: true),
                ),
                if (promoted) ...[
                  const SizedBox(height: 2),
                  Text(
                    '↗ promoted to post${promotedNote != null ? ' · $promotedNote' : ''}',
                    style: TextStyle(
                      fontFamily: pulseMonoFamily,
                      fontSize: 10,
                      color: t.greenInk,
                      height: 1.2,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
