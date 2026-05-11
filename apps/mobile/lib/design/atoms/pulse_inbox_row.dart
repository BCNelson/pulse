import 'package:flutter/material.dart';

import '../tokens.dart';
import '../typography.dart';

enum PulseInboxReason { urgent, mention, watch, dm, subscribed }

extension on PulseInboxReason {
  String get label {
    switch (this) {
      case PulseInboxReason.urgent:
        return '!';
      case PulseInboxReason.mention:
        return '@';
      case PulseInboxReason.watch:
        return '~';
      case PulseInboxReason.dm:
        return 'DM';
      case PulseInboxReason.subscribed:
        return '#';
    }
  }
}

/// Inbox notification row matching `.hf-inbox-row`. Left urgency bar +
/// reason square + 2-line body + right meta.
class PulseInboxRow extends StatelessWidget {
  const PulseInboxRow({
    super.key,
    required this.title,
    required this.reason,
    this.line1,
    this.preview,
    this.when,
    this.unread = true,
    this.urgent = false,
    this.cursor = false,
    this.onTap,
  });

  final PulseInboxReason reason;
  final String title;
  final String? line1;
  final String? preview;
  final String? when;
  final bool unread;
  final bool urgent;
  final bool cursor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;

    Color bar;
    if (urgent) {
      bar = t.amber;
    } else if (unread) {
      bar = t.ink;
    } else {
      bar = Colors.transparent;
    }

    Color reasonBg;
    Color reasonFg;
    Color reasonBorder;
    switch (reason) {
      case PulseInboxReason.urgent:
        reasonBg = t.amber;
        reasonFg = t.ink;
        reasonBorder = t.amber;
        break;
      case PulseInboxReason.mention:
        reasonBg = t.blueSoft;
        reasonFg = t.blueInk;
        reasonBorder = t.blue;
        break;
      case PulseInboxReason.watch:
        reasonBg = t.paper;
        reasonFg = t.ink2;
        reasonBorder = t.hair;
        break;
      case PulseInboxReason.dm:
        reasonBg = t.ink;
        reasonFg = t.paper;
        reasonBorder = t.ink;
        break;
      case PulseInboxReason.subscribed:
        reasonBg = t.paper2;
        reasonFg = t.ink2;
        reasonBorder = t.hair;
        break;
    }

    return Material(
      color: cursor ? t.paper2 : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.fromLTRB(14, 8, 22, 8),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: t.hair2)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 3,
                height: 24,
                margin: const EdgeInsets.only(right: 10, top: 1),
                decoration: BoxDecoration(
                  color: bar,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Container(
                width: 22,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: reasonBg,
                  border: Border.all(color: reasonBorder),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  reason.label,
                  style: TextStyle(
                    fontFamily: pulseMonoFamily,
                    fontSize: 10,
                    color: reasonFg,
                    letterSpacing: 0.02 * 10,
                    fontWeight: urgent ? FontWeight.w700 : FontWeight.w500,
                    height: 1.0,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (line1 != null)
                      Text(
                        line1!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: pulseMonoFamily,
                          fontSize: 11,
                          color: t.ink2,
                          height: 1.2,
                        ),
                      ),
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: unread ? t.ink : t.ink2,
                        fontWeight: unread ? FontWeight.w500 : FontWeight.w400,
                        letterSpacing: -0.003 * 13,
                        height: 1.3,
                      ),
                    ),
                    if (preview != null)
                      Text(
                        preview!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: t.ink2,
                          height: 1.3,
                        ),
                      ),
                  ],
                ),
              ),
              if (when != null) ...[
                const SizedBox(width: 8),
                Text(when!,
                    style: TextStyle(
                      fontFamily: pulseMonoFamily,
                      fontSize: 11,
                      color: t.ink2,
                      height: 1.2,
                    )),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
