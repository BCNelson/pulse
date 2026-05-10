import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ferry_client.dart';
import '../../core/selection.dart';
import '../../graphql/operations/__generated__/posts.req.gql.dart';
import '../composer/comment_composer.dart';
import 'reaction_bar.dart';

class PostDetailPane extends ConsumerWidget {
  const PostDetailPane({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postId = ref.watch(selectedPostIdProvider);
    if (postId == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text('Pick a post to read it.', textAlign: TextAlign.center),
        ),
      );
    }
    return _PostDetail(postId: postId);
  }
}

class _PostDetail extends ConsumerWidget {
  const _PostDetail({required this.postId});

  final String postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final client = ref.watch(ferryClientProvider);
    final req = GPostDetailReq((b) => b..vars.id = postId);
    return StreamBuilder(
      stream: client.request(req),
      builder: (context, snap) {
        final resp = snap.data;
        final data = resp?.data;
        if (snap.connectionState == ConnectionState.waiting && data == null) {
          return const Center(child: CircularProgressIndicator());
        }
        if (resp != null && resp.hasErrors) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                resp.graphqlErrors?.map((e) => e.message).join('\n') ??
                    'unknown error',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        final post = data?.post;
        if (post == null) {
          return const Center(child: Text('Post not found or hidden.'));
        }
        return Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text(
                    post.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'By ${post.author.displayName}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  Text(post.body),
                  const SizedBox(height: 12),
                  ReactionBar(
                    postId: post.id,
                    reactions: post.reactions
                        .map((r) => (
                              emoji: r.emoji,
                              count: r.count,
                              byViewer: r.byViewer,
                            ))
                        .toList(),
                  ),
                  const Divider(height: 32),
                  Text(
                    'Comments (${post.comments.edges.length})',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  for (final edge in post.comments.edges)
                    Padding(
                      padding: EdgeInsets.only(left: 16.0 * edge.node.depth),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                edge.node.author.displayName,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(height: 4),
                              Text(edge.node.body),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const Divider(height: 1),
            CommentComposer(postId: post.id),
          ],
        );
      },
    );
  }
}
