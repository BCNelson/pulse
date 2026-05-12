import 'package:ferry/ferry.dart';
import 'package:ferry/typed_links.dart' show CacheProxy;

import '__generated__/schema.schema.gql.dart';
import 'operations/__generated__/posts.data.gql.dart';
import 'operations/__generated__/posts.req.gql.dart';
import 'operations/__generated__/posts.var.gql.dart';

/// Cache handler keys used by mutation requests. Setting
/// `req.updateCacheHandlerKey = <one of these>` tells the Ferry client to
/// invoke the matching handler with a CacheProxy after the mutation
/// response is returned, so the splice happens once at the data layer
/// instead of being repeated at every call site.
const kAppendCommentHandlerKey = 'appendComment';
const kPrependPostHandlerKey = 'prependPost';

/// Splices a newly created comment into the PostDetail query's
/// `comments.edges`. The mutation response already carries every field
/// listed in the CommentSummary fragment, so we can construct an edge
/// node by JSON round-trip and append it.
void appendCommentHandler(
  CacheProxy proxy,
  OperationResponse<GCreateCommentData, GCreateCommentVars> response,
) {
  final data = response.data;
  if (data == null) return;
  final created = data.createComment;

  final postReq = GPostDetailReq((b) => b..vars.id = created.postId);
  final cached = proxy.readQuery(postReq);
  if (cached == null || cached.post == null) return;
  if (cached.post!.comments.edges.any((e) => e.node.id == created.id)) return;

  final newNode = GPostDetailData_post_comments_edges_node.fromJson(
    created.toJson(),
  );
  if (newNode == null) return;

  final updated = cached.rebuild((b) {
    b.post.comments.edges.add(
      GPostDetailData_post_comments_edges((e) => e..node.replace(newNode)),
    );
  });
  proxy.writeQuery(postReq, updated);
}

/// Splices a newly created post into the PostsForTag connection for
/// each tag the post was filed under. The PostsForTag list pane queries
/// with `first: 50`, so we update that exact request shape.
void prependPostHandler(
  CacheProxy proxy,
  OperationResponse<GCreatePostData, GCreatePostVars> response,
) {
  final data = response.data;
  if (data == null) return;
  final created = data.createPost;

  final tagIds = response.operationRequest.vars.input.tags
      .map((t) => t.tagId)
      .toList();
  for (final tagId in tagIds) {
    final req = GPostsForTagReq(
      (b) => b
        ..vars.tagId = tagId
        ..vars.first = 50,
    );
    final cached = proxy.readQuery(req);
    if (cached == null || cached.tag == null) continue;
    if (cached.tag!.posts.edges.any((e) => e.node.id == created.id)) continue;

    final newNode = GPostsForTagData_tag_posts_edges_node.fromJson(
      created.toJson(),
    );
    if (newNode == null) continue;

    final newEdge = GPostsForTagData_tag_posts_edges(
      (e) => e
        // Synthetic cursor — the server's cursor for this new row will
        // arrive on the next full refetch (pagination / cold start).
        // Local-only splice never relies on this value.
        ..cursor = ''
        ..node.replace(newNode),
    );
    final updatedData = cached.rebuild((b) {
      b.tag.posts.edges.insert(0, newEdge);
    });
    proxy.writeQuery(req, updatedData);
  }
}

/// The handler map passed to the Ferry Client at construction time.
final Map<String, Function> pulseCacheHandlers = <String, Function>{
  kAppendCommentHandlerKey: appendCommentHandler,
  kPrependPostHandlerKey: prependPostHandler,
};

// ---------------------------------------------------------------------------
// Optimistic response builders. Each mutation call site can attach one of
// these to `req.optimisticResponse` to make the matching cache handler run
// immediately with placeholder data — Ferry then re-runs the handler with
// the real response and rolls back the optimistic patch automatically.
// ---------------------------------------------------------------------------

String _tempId(String prefix) =>
    '$prefix:${DateTime.now().microsecondsSinceEpoch}';

String _nowIso() => DateTime.now().toUtc().toIso8601String();

/// Builds an optimistic `createComment` response. `authorId` /
/// `authorDisplayName` default to placeholder values shown only between
/// keypress and server confirmation.
GCreateCommentData buildOptimisticCreateComment({
  required String postId,
  String? parentId,
  required String body,
  required int depth,
  String authorId = 'optimistic-author',
  String authorDisplayName = 'you',
}) {
  return GCreateCommentData(
    (b) => b
      ..createComment.id = _tempId('opt-comment')
      ..createComment.postId = postId
      ..createComment.parentId = parentId
      ..createComment.depth = depth
      ..createComment.body = body
      ..createComment.createdAt.replace(GTime(_nowIso()))
      ..createComment.author.id = authorId
      ..createComment.author.displayName = authorDisplayName,
  );
}

/// Builds an optimistic `createPost` response.
GCreatePostData buildOptimisticCreatePost({
  required String title,
  required String body,
  String authorId = 'optimistic-author',
  String authorDisplayName = 'you',
}) {
  return GCreatePostData(
    (b) => b
      ..createPost.id = _tempId('opt-post')
      ..createPost.title = title
      ..createPost.body = body
      ..createPost.createdAt.replace(GTime(_nowIso()))
      ..createPost.author.id = authorId
      ..createPost.author.displayName = authorDisplayName,
  );
}

/// Builds an optimistic `reactToPost` response by adding/incrementing the
/// emoji for the viewer. Pass the post's *current* reactions so the
/// returned list reflects the toggle precisely.
GReactToPostData buildOptimisticReact({
  required String postId,
  required String emoji,
  required Iterable<({String emoji, int count, bool byViewer})>
      currentReactions,
}) {
  final next = <({String emoji, int count, bool byViewer})>[];
  var found = false;
  for (final r in currentReactions) {
    if (r.emoji == emoji) {
      found = true;
      if (r.byViewer) {
        next.add(r); // already reacted; idempotent
      } else {
        next.add((emoji: emoji, count: r.count + 1, byViewer: true));
      }
    } else {
      next.add(r);
    }
  }
  if (!found) next.add((emoji: emoji, count: 1, byViewer: true));
  return GReactToPostData(
    (b) => b
      ..reactToPost.id = postId
      ..reactToPost.reactions.addAll(
        next.map(
          (r) => GReactToPostData_reactToPost_reactions(
            (rb) => rb
              ..emoji = r.emoji
              ..count = r.count
              ..byViewer = r.byViewer,
          ),
        ),
      ),
  );
}

/// Builds an optimistic `unreactToPost` response by removing the viewer's
/// reaction for the emoji (decrements count, drops the row if it hits 0).
GUnreactToPostData buildOptimisticUnreact({
  required String postId,
  required String emoji,
  required Iterable<({String emoji, int count, bool byViewer})>
      currentReactions,
}) {
  final next = <({String emoji, int count, bool byViewer})>[];
  for (final r in currentReactions) {
    if (r.emoji == emoji && r.byViewer) {
      final newCount = r.count - 1;
      if (newCount > 0) {
        next.add((emoji: emoji, count: newCount, byViewer: false));
      }
    } else {
      next.add(r);
    }
  }
  return GUnreactToPostData(
    (b) => b
      ..unreactToPost.id = postId
      ..unreactToPost.reactions.addAll(
        next.map(
          (r) => GUnreactToPostData_unreactToPost_reactions(
            (rb) => rb
              ..emoji = r.emoji
              ..count = r.count
              ..byViewer = r.byViewer,
          ),
        ),
      ),
  );
}
