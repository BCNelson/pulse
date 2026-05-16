import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markdown/markdown.dart' as md;

import '../../features/mention_preview/mention_hoverable.dart';
import '../../features/mention_preview/mention_preview_provider.dart';
import '../tokens.dart';
import '../typography.dart';

/// Canonical URL schemes the composer emits for mentions and tag refs.
/// Kept in sync with `services/api/internal/mentions/mentions.go`.
const String _userScheme = 'pulse-user:';
const String _tagScheme = 'pulse-tag:';

class PulseMarkdownBody extends ConsumerWidget {
  const PulseMarkdownBody({
    super.key,
    required this.data,
    this.compact = false,
  });

  final String data;
  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      onTapLink: (text, href, title) => _handleTapLink(ref, href),
      builders: {
        'a': _PulseLinkBuilder(
          baseStyle: body,
          chipColor: t.blueInk,
          onTap: (href) => _handleTapLink(ref, href),
        ),
      },
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

  void _handleTapLink(WidgetRef ref, String? href) {
    if (href == null || href.isEmpty) return;
    if (href.startsWith(_userScheme)) {
      final slug = href.substring(_userScheme.length);
      if (slug.isNotEmpty) {
        ref.read(mentionPreviewProvider.notifier).showUser(slug);
      }
      return;
    }
    if (href.startsWith(_tagScheme)) {
      final path = href.substring(_tagScheme.length);
      if (path.isNotEmpty) {
        ref.read(mentionPreviewProvider.notifier).showTag(path);
      }
      return;
    }
    // External link handling is intentionally a no-op for v1; renderer
    // stays a pure design atom without a url_launcher dependency.
  }
}

/// Custom `<a>` element builder. For canonical pulse-user / pulse-tag
/// links we render a styled chip (weight 600, no underline) so readers
/// can tell at a glance that the token is a structured reference, not a
/// raw `@foo`/`#foo` string. The tap recognizer dispatches through the
/// provided [onTap]; flutter_markdown_plus's `onTapLink` does NOT fire
/// for elements with a custom builder, so this is the only tap path for
/// mention/tag chips. Everything else falls back to the default
/// underlined-link rendering produced by [MarkdownStyleSheet.a].
class _PulseLinkBuilder extends MarkdownElementBuilder {
  _PulseLinkBuilder({
    required this.baseStyle,
    required this.chipColor,
    required this.onTap,
  });

  final TextStyle baseStyle;
  final Color chipColor;
  final void Function(String href) onTap;

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final href = element.attributes['href'] ?? '';
    if (!href.startsWith(_userScheme) && !href.startsWith(_tagScheme)) {
      return null; // default rendering
    }
    final label = element.textContent;
    final chip = Text.rich(
      TextSpan(
        text: label,
        style: baseStyle.copyWith(
          color: chipColor,
          fontWeight: FontWeight.w600,
        ),
        recognizer: TapGestureRecognizer()..onTap = () => onTap(href),
      ),
    );
    if (href.startsWith(_userScheme)) {
      final slug = href.substring(_userScheme.length);
      return MentionHoverable.user(
        slug: slug,
        onTap: () => onTap(href),
        child: chip,
      );
    }
    final path = href.substring(_tagScheme.length);
    return MentionHoverable.tag(
      path: path,
      onTap: () => onTap(href),
      child: chip,
    );
  }
}
