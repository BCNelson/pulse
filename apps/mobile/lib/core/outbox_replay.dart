import 'dart:async';
import 'dart:convert';

import 'package:ferry/ferry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../graphql/__generated__/schema.schema.gql.dart';
import '../graphql/cache_handlers.dart';
import '../graphql/operations/__generated__/posts.req.gql.dart';
import 'ferry_client.dart';
import 'outbox.dart';

/// outboxReplayProvider runs once when the app boots into a signed-in
/// state. Walks the pending mutations table, re-issues each, and removes
/// the row on success. Failures bump attempts and stay queued.
final outboxReplayProvider = Provider<OutboxReplayer>((ref) {
  return OutboxReplayer(ref);
});

class OutboxReplayer {
  OutboxReplayer(this._ref);
  final Ref _ref;
  bool _running = false;

  Future<void> drain() async {
    if (_running) return;
    _running = true;
    try {
      final db = _ref.read(outboxDatabaseProvider);
      final client = _ref.read(ferryClientProvider);
      final pending = await db.peekAll();
      for (final row in pending) {
        try {
          final payload = jsonDecode(row.payload) as Map<String, dynamic>;
          await _replay(client, row.kind, payload);
          await db.remove(row.id);
        } catch (e) {
          await db.markFailure(row.id, e.toString());
        }
      }
    } finally {
      _running = false;
    }
  }

  Future<void> _replay(
      Client client, String kind, Map<String, dynamic> payload) async {
    switch (kind) {
      case 'createPost':
        final req = GCreatePostReq(
          (b) => b
            ..vars.input.title = payload['title'] as String
            ..vars.input.body = payload['body'] as String
            ..vars.input.tags.add(
                  GPostTagInput((tb) => tb..tagId = payload['tagId'] as String),
                )
            ..updateCacheHandlerKey = kPrependPostHandlerKey,
        );
        final resp = await client.request(req).first;
        if (resp.hasErrors) throw Exception('replay failed: createPost');
        return;
      case 'createComment':
        final req = GCreateCommentReq(
          (b) => b
            ..vars.input.postId = payload['postId'] as String
            ..vars.input.body = payload['body'] as String
            ..updateCacheHandlerKey = kAppendCommentHandlerKey,
        );
        final resp = await client.request(req).first;
        if (resp.hasErrors) throw Exception('replay failed: createComment');
        return;
      default:
        throw UnsupportedError('Unknown outbox kind: $kind');
    }
  }
}
