import 'dart:async';

import 'package:ferry/ferry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/cache_evictor.dart';
import '../../core/chat_cache.dart';
import '../../core/ferry_client.dart';
import '../../graphql/operations/__generated__/chat.data.gql.dart';
import '../../graphql/operations/__generated__/chat.req.gql.dart';

/// SWR provider for `ChatRoomDetail($id)`. Emits cached room metadata
/// and message log immediately; one-shot refetch writes the latest
/// server window back over the cached log.
final cachedChatRoomProvider =
    StreamProvider.autoDispose.family<CachedChatRoom, String>(
  (ref, roomId) {
    final store = ref.watch(chatCacheStoreProvider);
    final client = ref.watch(ferryClientProvider);
    unawaited(store.touchRoom(roomId));
    unawaited(_refetch(ref, client, store, roomId));
    return store.watchRoom(roomId);
  },
);

Future<void> _refetch(
  Ref ref,
  Client client,
  ChatCacheStore store,
  String roomId,
) async {
  final req = GChatRoomDetailReq(
    (b) => b
      ..vars.id = roomId
      ..fetchPolicy = FetchPolicy.NoCache,
  );
  try {
    final resp = await client.request(req).first;
    if (resp.hasErrors) return;
    final room = resp.data?.chatRoom;
    if (room == null) return;
    final summary = GChatRoomSummaryData.fromJson(room.toJson());
    if (summary != null) {
      await store.upsertRoomSummary(summary);
    }
    final entries = <({String? cursor, GMessageSummaryData node})>[];
    for (final e in room.messages.edges) {
      final node = GMessageSummaryData.fromJson(e.node.toJson());
      if (node != null) {
        entries.add((cursor: e.cursor, node: node));
      }
    }
    await store.replaceMessages(roomId: roomId, entries: entries);
    await ref.read(cacheEvictorProvider).evictIfOverBudget();
  } catch (_) {}
}
