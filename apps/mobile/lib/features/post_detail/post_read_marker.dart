import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ferry_client.dart';
import '../../graphql/__generated__/schema.schema.gql.dart';
import '../../graphql/operations/__generated__/posts.req.gql.dart';

/// Per-post read-mark advancer. State is the last `seenAt` we successfully
/// submitted (or are submitting) to the server, or null when nothing has
/// been submitted this visit.
///
/// Every significant interaction during a visit (scroll, comment, react,
/// collapse) calls [markIfAdvanced]. The call fires `MarkPostRead` only if
/// the newest cached comment's `createdAt` is strictly newer than what we
/// last submitted — so an interaction with no new comments since the last
/// mark is a free no-op, but a new comment streaming in mid-visit will be
/// acknowledged on the next interaction.
///
/// `_PostDetailState.initState` calls [reset] so each fresh visit starts
/// with a clean baseline (even if Riverpod kept the instance alive across
/// the brief gap between disposals).
class PostReadMarker extends Notifier<DateTime?> {
  PostReadMarker(this.postId);

  final String postId;
  bool _inFlight = false;

  @override
  DateTime? build() => null;

  void reset() {
    _inFlight = false;
    state = null;
  }

  Future<void> markIfAdvanced() async {
    if (_inFlight) return;

    final client = ref.read(ferryClientProvider);
    final cached = client.cache.readQuery(
      GPostDetailReq((b) => b..vars.id = postId),
    );
    DateTime? newest;
    final edges = cached?.post?.comments.edges;
    if (edges != null) {
      for (final e in edges) {
        if (e.node.id.startsWith('opt-')) continue;
        final t = DateTime.tryParse(e.node.createdAt.value);
        if (t != null && (newest == null || t.isAfter(newest))) {
          newest = t;
        }
      }
    }
    if (newest == null) return;
    final lastSubmitted = state;
    if (lastSubmitted != null && !newest.isAfter(lastSubmitted)) return;

    _inFlight = true;
    state = newest;
    final req = GMarkPostReadReq((b) {
      b.vars.postId = postId;
      b.vars.seenAt.replace(GTime(newest!.toUtc().toIso8601String()));
    });
    try {
      await client.request(req).first;
    } catch (_) {
      // Best-effort. Server clamps with GREATEST so we can't move
      // backwards; the next interaction will retry.
    } finally {
      _inFlight = false;
    }
  }
}

final postReadMarkerProvider =
    NotifierProvider.family<PostReadMarker, DateTime?, String>(
  PostReadMarker.new,
);
