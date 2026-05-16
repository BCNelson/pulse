import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ferry_client.dart';
import '../../design/atoms/mention_avatar.dart';
import '../../design/tokens.dart';
import '../../design/typography.dart';
import '../../graphql/operations/__generated__/mention_hover.req.gql.dart';
import 'mention_preview_provider.dart';

/// MentionHoverCard renders a compact card with an avatar, display name,
/// and handle for a `@user` or `#tag` mention. A reserved slot at the
/// bottom is intentionally empty in v1 so the layout is ready for
/// description, last-seen, post counts, or other profile info later.
///
/// Data is fetched via the lightweight `MentionHoverUser` /
/// `MentionHoverTag` queries. Ferry caches the response so subsequent
/// hovers on the same mention are instant.
class MentionHoverCard extends ConsumerWidget {
  const MentionHoverCard({super.key, required this.target});

  final MentionPreviewTarget target;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (target) {
      final MentionPreviewUserTarget u => _UserHoverBody(slug: u.slug),
      final MentionPreviewTagTarget t => _TagHoverBody(target: t),
    };
  }
}

class _UserHoverBody extends ConsumerWidget {
  const _UserHoverBody({required this.slug});
  final String slug;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final client = ref.watch(ferryClientProvider);
    return StreamBuilder(
      stream: client.request(
        GMentionHoverUserReq((b) => b..vars.slug = slug),
      ),
      builder: (context, snap) {
        final user = snap.data?.data?.userByHandle;
        if (snap.data == null) {
          return _HoverFrame(
            avatar: MentionAvatar.user(displayName: slug),
            title: '@$slug',
            subtitle: 'loading…',
          );
        }
        if (user == null) {
          return _HoverFrame(
            avatar: MentionAvatar.user(displayName: slug),
            title: '@$slug',
            subtitle: 'no longer available',
          );
        }
        return _HoverFrame(
          avatar: MentionAvatar.user(displayName: user.displayName),
          title: user.displayName,
          subtitle: user.homeTag != null ? '@${user.homeTag!.slug}' : null,
        );
      },
    );
  }
}

class _TagHoverBody extends ConsumerWidget {
  const _TagHoverBody({required this.target});
  final MentionPreviewTagTarget target;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final client = ref.watch(ferryClientProvider);
    return StreamBuilder(
      stream: client.request(
        GMentionHoverTagReq(
          (b) => b..vars.path.replace(target.segments),
        ),
      ),
      builder: (context, snap) {
        final tag = snap.data?.data?.tagBySlugPath;
        if (snap.data == null) {
          return _HoverFrame(
            avatar: MentionAvatar.tag(displayName: target.path),
            title: '#${target.path}',
            subtitle: 'loading…',
          );
        }
        if (tag == null) {
          return _HoverFrame(
            avatar: MentionAvatar.tag(displayName: target.path),
            title: '#${target.path}',
            subtitle: 'archived or removed',
          );
        }
        return _HoverFrame(
          avatar: MentionAvatar.tag(displayName: tag.displayName),
          title: tag.displayName,
          subtitle: '#${tag.path}',
          footnote: tag.parent != null
              ? 'under ${tag.parent!.displayName}'
              : null,
        );
      },
    );
  }
}

/// Shared visual frame so both kinds of hover card line up identically
/// and future additions land in one place. The [reservedSlot] keeps
/// vertical space for description / activity widgets to drop in later.
class _HoverFrame extends StatelessWidget {
  const _HoverFrame({
    required this.avatar,
    required this.title,
    this.subtitle,
    this.footnote,
  });

  final Widget avatar;
  final String title;
  final String? subtitle;
  final String? footnote;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Material(
      color: t.paper,
      elevation: 6,
      borderRadius: BorderRadius.circular(t.radius),
      child: Container(
        width: 260,
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
        decoration: BoxDecoration(
          border: Border.all(color: t.hair),
          borderRadius: BorderRadius.circular(t.radius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                avatar,
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: t.ink,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          style: TextStyle(
                            fontFamily: pulseMonoFamily,
                            fontSize: 11,
                            color: t.ink2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
              ],
            ),
            if (footnote != null) ...[
              const SizedBox(height: 8),
              Text(
                footnote!,
                style: TextStyle(fontSize: 11, color: t.ink3),
              ),
            ],
            // Reserved slot for future profile info (description,
            // last-seen, post counts, etc.). Sized to ~36 dp so the
            // hover card has a consistent shape today and bodies that
            // land here later don't shift everything around.
            const SizedBox(height: 10),
            Container(
              height: 36,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: t.paper2,
                border: Border.all(color: t.hair2),
                borderRadius: BorderRadius.circular(t.radius / 2),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '— more info coming soon —',
                style: TextStyle(
                  fontSize: 11,
                  color: t.ink3,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
