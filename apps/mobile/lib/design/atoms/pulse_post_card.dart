import 'package:flutter/material.dart';

import '../tokens.dart';
import '../typography.dart';
import 'pulse_avatar.dart';
import 'pulse_tag_chip.dart';

enum PulsePostKind { post, task, promoted, note, comment }

enum PulsePostDecision { none, decided, answered, due }

/// Post / task / comment card matching `.hf-post` and `PostCard`.
class PulsePostCard extends StatelessWidget {
  const PulsePostCard({
    super.key,
    required this.title,
    this.body,
    this.kind = PulsePostKind.post,
    this.decision = PulsePostDecision.none,
    this.dueLabel,
    this.statusLabel,
    this.authorInitials = '··',
    this.authorName,
    this.whenLabel,
    this.tags = const [],
    this.comments,
    this.reactions,
    this.participants,
    this.cursor = false,
    this.onTap,
  });

  final PulsePostKind kind;
  final PulsePostDecision decision;
  final String? dueLabel;
  final String? statusLabel;
  final String title;
  final String? body;
  final String authorInitials;
  final String? authorName;
  final String? whenLabel;
  final List<String> tags;
  final int? comments;
  final String? reactions;
  final List<String>? participants;
  final bool cursor;
  final VoidCallback? onTap;

  String get _kindLabel {
    switch (kind) {
      case PulsePostKind.post:
        return 'POST';
      case PulsePostKind.task:
        return 'TASK';
      case PulsePostKind.promoted:
        return 'POST · FROM CHAT';
      case PulsePostKind.note:
        return 'NOTE';
      case PulsePostKind.comment:
        return 'COMMENT';
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;

    Color kindBg;
    Color kindFg;
    Border kindBorder;
    switch (kind) {
      case PulsePostKind.post:
        kindBg = t.ink;
        kindFg = t.paper;
        kindBorder = Border.all(color: t.ink);
        break;
      case PulsePostKind.task:
        kindBg = t.paper;
        kindFg = t.ink;
        kindBorder = Border.all(color: t.ink);
        break;
      case PulsePostKind.promoted:
        kindBg = t.paper;
        kindFg = t.ink;
        kindBorder = Border.all(color: t.ink, style: BorderStyle.solid);
        // (Flutter has no dashed border; we approximate with a solid line.)
        break;
      case PulsePostKind.note:
        kindBg = t.paper2;
        kindFg = t.ink2;
        kindBorder = Border.all(color: t.hair);
        break;
      case PulsePostKind.comment:
        kindBg = t.paper;
        kindFg = t.ink2;
        kindBorder = Border.all(color: t.hair);
        break;
    }

    final decisionBadge = switch (decision) {
      PulsePostDecision.decided =>
        _Badge(label: 'DECIDED', bg: t.greenSoft, fg: t.greenInk),
      PulsePostDecision.answered =>
        _Badge(label: 'ANSWERED', bg: t.blueSoft, fg: t.blueInk),
      PulsePostDecision.due => _Badge(
          label: 'DUE${dueLabel != null ? ' $dueLabel' : ''}',
          bg: t.amberSoft,
          fg: t.amberInk),
      PulsePostDecision.none => null,
    };

    final card = DecoratedBox(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: t.hair2)),
      ),
      child: Stack(
        children: [
          if (cursor)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(width: 2, color: t.ink),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 10, 22, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // row1: kind tag + decision + author + when
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                        color: kindBg,
                        border: kindBorder,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        _kindLabel,
                        style: TextStyle(
                          fontFamily: pulseMonoFamily,
                          fontSize: 9.5,
                          color: kindFg,
                          letterSpacing: 0.10 * 9.5,
                          height: 1.0,
                        ),
                      ),
                    ),
                    if (decisionBadge != null) decisionBadge,
                    if (statusLabel != null)
                      Text('· ${statusLabel!.toUpperCase()}',
                          style: pulseMono(context,
                              size: 11, color: t.ink2, letterSpacing: 0.04)),
                    PulseAvatar(
                        initials: authorInitials, size: PulseAvatarSize.sm),
                    if (authorName != null)
                      Text(authorName!,
                          style: TextStyle(
                            fontFamily: pulseMonoFamily,
                            fontSize: 11,
                            color: t.ink,
                            height: 1.2,
                          )),
                    if (whenLabel != null)
                      Text('· $whenLabel',
                          style: TextStyle(
                            fontFamily: pulseMonoFamily,
                            fontSize: 11,
                            color: t.ink3,
                            height: 1.2,
                          )),
                  ],
                ),
                const SizedBox(height: 4),
                if (title.isNotEmpty) ...[
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 2),
                ],
                if (body != null && body!.isNotEmpty)
                  Text(
                    body!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                if (tags.isNotEmpty ||
                    comments != null ||
                    reactions != null ||
                    participants != null) ...[
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      for (final tag in tags) PulseTagChip(path: tag),
                      if (participants != null && participants!.isNotEmpty)
                        PulseAvatarStack(initials: participants!),
                      if (comments != null)
                        Text('$comments comments',
                            style: TextStyle(
                              fontFamily: pulseMonoFamily,
                              fontSize: 11,
                              color: t.ink2,
                              height: 1.2,
                            )),
                      if (reactions != null)
                        Text(reactions!,
                            style: TextStyle(
                              fontFamily: pulseMonoFamily,
                              fontSize: 11,
                              color: t.ink2,
                              height: 1.2,
                            )),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
    if (onTap == null) return card;
    return InkWell(onTap: onTap, child: card);
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.bg, required this.fg});

  final String label;
  final Color bg;
  final Color fg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: pulseMonoFamily,
          fontSize: 9.5,
          color: fg,
          letterSpacing: 0.08 * 9.5,
          height: 1.0,
        ),
      ),
    );
  }
}
