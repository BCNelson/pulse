import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

import '../tokens.dart';
import '../typography.dart';

class PulseMarkdownBody extends StatelessWidget {
  const PulseMarkdownBody({
    super.key,
    required this.data,
    this.compact = false,
  });

  final String data;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final theme = Theme.of(context);
    final body =
        (compact ? theme.textTheme.bodySmall : theme.textTheme.bodyMedium)
                ?.copyWith(
              color: t.ink,
              height: compact ? 1.35 : 1.45,
            ) ??
            TextStyle(fontSize: compact ? 12.5 : 13, color: t.ink);

    return MarkdownBody(
      data: data,
      selectable: true,
      softLineBreak: true,
      styleSheet: MarkdownStyleSheet(
        p: body,
        strong: body.copyWith(fontWeight: FontWeight.w700),
        em: body.copyWith(fontStyle: FontStyle.italic),
        code: TextStyle(
          fontFamily: pulseMonoFamily,
          fontSize: compact ? 11.5 : 12,
          color: t.ink,
          backgroundColor: t.paper2,
          height: 1.3,
        ),
        codeblockDecoration: BoxDecoration(
          color: t.paper2,
          border: Border.all(color: t.hair),
          borderRadius: BorderRadius.circular(t.radius),
        ),
        codeblockPadding: const EdgeInsets.all(8),
        h1: body.copyWith(
            fontSize: compact ? 15 : 18, fontWeight: FontWeight.w700),
        h2: body.copyWith(
            fontSize: compact ? 14 : 16, fontWeight: FontWeight.w700),
        h3: body.copyWith(
            fontSize: compact ? 13 : 14, fontWeight: FontWeight.w700),
        blockquote: body.copyWith(color: t.ink2),
        blockquoteDecoration: BoxDecoration(
          border: Border(left: BorderSide(color: t.ink, width: 2)),
        ),
        blockquotePadding: const EdgeInsets.fromLTRB(8, 2, 0, 2),
        blockquoteAlign: WrapAlignment.start,
        listBullet: body.copyWith(color: t.ink2),
        a: body.copyWith(
          color: t.blueInk,
          decoration: TextDecoration.underline,
          decorationColor: t.blueInk,
        ),
        horizontalRuleDecoration: BoxDecoration(
          border: Border(top: BorderSide(color: t.hair2)),
        ),
      ),
    );
  }
}
