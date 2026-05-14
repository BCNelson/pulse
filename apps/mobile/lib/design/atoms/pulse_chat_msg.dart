import 'package:flutter/material.dart';

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
    this.when,
    this.promoted = false,
    this.promotedNote,
  });

  final String who;
  final String initials;
  final String text;
  final String? when;
  final bool promoted;
  final String? promotedNote;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PulseAvatar(initials: initials),
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
                    Text(who,
                        style: TextStyle(
                          fontFamily: pulseMonoFamily,
                          fontSize: 10.5,
                          color: t.ink,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        )),
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
