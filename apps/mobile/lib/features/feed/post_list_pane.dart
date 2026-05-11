import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ferry_client.dart';
import '../../core/selection.dart';
import '../../design/atoms/pulse_feed_bar.dart';
import '../../design/atoms/pulse_page_head.dart';
import '../../design/atoms/pulse_post_card.dart';
import '../../design/atoms/pulse_segmented.dart';
import '../../design/tokens.dart';
import '../../design/typography.dart';
import '../../graphql/__generated__/schema.schema.gql.dart';
import '../../graphql/operations/__generated__/posts.req.gql.dart';
import '../composer/post_composer.dart';
import 'post_changed_listener.dart';

enum _SortMode { forYou, recent, unread, active }

class _SortModeNotifier extends Notifier<_SortMode> {
  @override
  _SortMode build() => _SortMode.recent;
  void set(_SortMode m) => state = m;
}

final _sortModeProvider =
    NotifierProvider<_SortModeNotifier, _SortMode>(_SortModeNotifier.new);

class PostListPane extends ConsumerWidget {
  const PostListPane({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final tagId = ref.watch(selectedTagIdProvider);
    if (tagId == null) {
      return _Placeholder(
        color: t.paper,
        title: 'No tag selected',
        subtitle: 'Pick a tag from the tree to see its posts.',
      );
    }
    // Subscribe to live updates for this tag.
    ref.listen(postChangedListenerProvider(tagId), (_, __) {});
    return Container(color: t.paper, child: _PostList(tagId: tagId));
  }
}

class _PostList extends ConsumerWidget {
  const _PostList({required this.tagId});

  final String tagId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final client = ref.watch(ferryClientProvider);
    final req = GPostsForTagReq(
      (b) => b
        ..vars.tagId = tagId
        ..vars.first = 50,
    );
    return Stack(
      children: [
        StreamBuilder(
          stream: client.request(req),
          builder: (context, snap) {
            final resp = snap.data;
            final data = resp?.data;
            final isLoading =
                snap.connectionState == ConnectionState.waiting && data == null;
            final tag = data?.tag;
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: PulsePageHead(
                    title: tag?.displayName ?? 'Posts',
                    subtitle: tag != null ? '#${tag.path}' : null,
                  ),
                ),
                SliverToBoxAdapter(
                  child: PulseFeedBar(
                    children: [
                      Text('SORT',
                          style: TextStyle(
                            fontFamily: pulseMonoFamily,
                            fontSize: 10,
                            color: t.ink3,
                            letterSpacing: 0.08 * 10,
                          )),
                      Consumer(builder: (context, ref, _) {
                        final mode = ref.watch(_sortModeProvider);
                        return PulseSegmented<_SortMode>(
                          options: _SortMode.values,
                          selected: mode,
                          onChanged: (m) =>
                              ref.read(_sortModeProvider.notifier).set(m),
                          labelOf: (m) => switch (m) {
                            _SortMode.forYou => 'For you',
                            _SortMode.recent => 'Recent',
                            _SortMode.unread => 'Unread',
                            _SortMode.active => 'Active',
                          },
                        );
                      }),
                    ],
                  ),
                ),
                if (isLoading)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: t.ink2),
                      ),
                    ),
                  )
                else if (resp != null && resp.hasErrors)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          resp.graphqlErrors
                                  ?.map((e) => e.message)
                                  .join('\n') ??
                              resp.linkException?.toString() ??
                              'unknown error',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: pulseMonoFamily,
                            fontSize: 11,
                            color: t.ink2,
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  _buildPostList(context, ref, data?.tag?.posts.edges.toList()),
                const SliverToBoxAdapter(child: SizedBox(height: 80)),
              ],
            );
          },
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: FloatingActionButton.extended(
            onPressed: () => _openComposer(context, tagId),
            icon: const Icon(Icons.edit),
            label: Text('New post',
                style: pulseMono(context,
                    size: 11, color: t.paper, weight: FontWeight.w600)),
          ),
        ),
      ],
    );
  }

  Widget _buildPostList(
    BuildContext context,
    WidgetRef ref,
    List<dynamic>? edges,
  ) {
    if (edges == null || edges.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: _Placeholder(
            color: context.tokens.paper,
            title: 'No posts yet',
            subtitle: 'Be the first to start a thread.',
          ),
        ),
      );
    }
    return SliverList.builder(
      itemCount: edges.length,
      itemBuilder: (context, i) {
        final node = edges[i].node;
        final selected = ref.watch(selectedPostIdProvider) == node.id;
        final decision = _decisionFor(node.decisionStatus);
        return PulsePostCard(
          title: node.title,
          body: node.body,
          decision: decision,
          authorInitials: _initials(node.author.displayName),
          authorName: node.author.displayName,
          whenLabel: _shortWhen(node.createdAt.value),
          comments: node.reactions.length,
          cursor: selected,
          onTap: () =>
              ref.read(selectedPostIdProvider.notifier).state = node.id,
        );
      },
    );
  }

  PulsePostDecision _decisionFor(GDecisionStatus? status) {
    if (status == GDecisionStatus.DECISION) return PulsePostDecision.decided;
    if (status == GDecisionStatus.ANSWER) return PulsePostDecision.answered;
    return PulsePostDecision.none;
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '··';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }

  String _shortWhen(String iso) {
    final parsed = DateTime.tryParse(iso);
    if (parsed == null) return '';
    final diff = DateTime.now().toUtc().difference(parsed.toUtc());
    if (diff.inSeconds < 60) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    if (diff.inDays < 7) return '${diff.inDays}d';
    return '${(diff.inDays / 7).floor()}w';
  }

  void _openComposer(BuildContext context, String tagId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: PostComposer(tagId: tagId),
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({
    required this.title,
    required this.subtitle,
    required this.color,
  });

  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Container(
      color: color,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: pulseMonoFamily,
                  fontSize: 11,
                  color: t.ink3,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
