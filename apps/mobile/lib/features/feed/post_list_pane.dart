import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ferry_client.dart';
import '../../core/selection.dart';
import '../../graphql/operations/__generated__/posts.req.gql.dart';
import '../composer/post_composer.dart';
import 'post_changed_listener.dart';

class PostListPane extends ConsumerWidget {
  const PostListPane({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagId = ref.watch(selectedTagIdProvider);
    if (tagId == null) {
      return const _Placeholder(
        title: 'No tag selected',
        subtitle: 'Pick a tag from the tree to see its posts.',
      );
    }
    // Subscribe to live updates for this tag — postChanged fires on
    // create; we invalidate the list query when one arrives.
    ref.listen(postChangedListenerProvider(tagId), (_, __) {});
    return _PostList(tagId: tagId);
  }
}

class _PostList extends ConsumerWidget {
  const _PostList({required this.tagId});

  final String tagId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            if (snap.connectionState == ConnectionState.waiting && data == null) {
              return const Center(child: CircularProgressIndicator());
            }
            if (resp != null && resp.hasErrors) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    resp.graphqlErrors?.map((e) => e.message).join('\n') ??
                        resp.linkException?.toString() ??
                        'unknown error',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            final edges = data?.tag?.posts.edges.toList() ?? const [];
            if (edges.isEmpty) {
              return const _Placeholder(
                title: 'No posts yet',
                subtitle: 'Be the first to start a thread.',
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.only(top: 8, bottom: 80),
              itemCount: edges.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final node = edges[i].node;
                final selected = ref.watch(selectedPostIdProvider) == node.id;
                return Material(
                  color: selected
                      ? Theme.of(context).colorScheme.secondaryContainer
                      : Colors.transparent,
                  child: ListTile(
                    title: Text(
                      node.title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      node.body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Text(
                      node.author.displayName,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    onTap: () =>
                        ref.read(selectedPostIdProvider.notifier).state = node.id,
                  ),
                );
              },
            );
          },
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: FloatingActionButton.extended(
            onPressed: () => _openComposer(context, tagId),
            icon: const Icon(Icons.edit),
            label: const Text('New post'),
          ),
        ),
      ],
    );
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
  const _Placeholder({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(subtitle, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
