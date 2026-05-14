import 'dart:convert';
import 'dart:developer' as developer;

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/auth_controller.dart';
import '../core/cache_evictor.dart';
import '../core/outbox.dart';
import '../core/persistent_cache.dart';
import '../core/prefs_provider.dart';
import '../core/server_config_controller.dart';
import '../core/ui_state_storage.dart';

bool _registered = false;

/// Registers Pulse-specific VM service extensions for the DevTools package.
///
/// This function is called from an `assert` in `main.dart`, so the registration
/// call and the callbacks are unreachable in profile and release builds.
bool registerPulseDevToolsService(WidgetRef ref) {
  if (_registered) return true;
  _registered = true;

  developer.registerExtension('ext.pulse.snapshot', (_, __) async {
    return developer.ServiceExtensionResponse.result(
      jsonEncode(await _snapshot(ref)),
    );
  });

  developer.registerExtension('ext.pulse.runCacheEviction', (_, __) async {
    await ref.read(cacheEvictorProvider).evict();
    return developer.ServiceExtensionResponse.result(
      jsonEncode({
        'ok': true,
        'snapshot': await _snapshot(ref),
      }),
    );
  });

  return true;
}

Future<Map<String, Object?>> _snapshot(WidgetRef ref) async {
  final outbox = ref.read(outboxDatabaseProvider);
  final cache = ref.read(cacheDatabaseProvider);
  final prefs = await ref.read(sharedPreferencesProvider.future);
  final auth = ref.read(authControllerProvider);
  final server = ref.read(serverConfigControllerProvider);

  final pending = await outbox.peekAll();
  final cacheBudgetBytes = UiStateStorage(prefs).readCacheMaxBytes();
  final cacheStats = await _cacheStats(cache, cacheBudgetBytes);
  final draftKeys = prefs
      .getKeys()
      .where((key) =>
          key.contains('.pulse.ui.draft.') || key.startsWith('pulse.ui.draft.'))
      .toList()
    ..sort();

  return {
    'generatedAt': DateTime.now().toIso8601String(),
    'auth': _authSummary(auth),
    'server': _serverSummary(server),
    'outbox': {
      'pendingCount': pending.length,
      'oldestQueuedAt':
          pending.isEmpty ? null : pending.first.queuedAt.toIso8601String(),
      'items': pending.take(25).map(_pendingMutationJson).toList(),
    },
    'cache': cacheStats,
    'composer': {
      'draftCount': draftKeys.length,
      'draftKeys': draftKeys.take(50).toList(),
    },
  };
}

Map<String, Object?> _authSummary(AuthState auth) {
  return switch (auth) {
    AuthLoading() => {'state': 'loading'},
    AuthSignedOut(:final lastError) => {
        'state': 'signedOut',
        'lastError': lastError,
      },
    AuthSignedIn(:final email, :final token) => {
        'state': 'signedIn',
        'email': email,
        'hasToken': token.isNotEmpty,
        'tokenLength': token.length,
      },
  };
}

Map<String, Object?> _serverSummary(ServerConfigState server) {
  return switch (server) {
    ServerConfigLoading() => {'state': 'loading'},
    ServerConfigMissing(:final lastError) => {
        'state': 'missing',
        'lastError': lastError,
      },
    ServerConfigReady(:final config) => {
        'state': 'ready',
        'baseUrl': config.baseUrl,
        'graphqlHttpUrl': config.graphqlHttpUrl,
        'graphqlWsUrl': config.graphqlWsUrl,
      },
  };
}

Future<Map<String, Object?>> _cacheStats(
  CacheDatabase db,
  int cacheBudgetBytes,
) async {
  final totalBytes = await db.totalByteSize();
  final tags = await _count(db, 'cached_tags', db.cachedTags);
  final feedRows = await _count(db, 'cached_tag_feed', db.cachedTagFeed);
  final posts = await _count(db, 'cached_posts', db.cachedPosts);
  final postDetails = await _countWhere(
    db,
    'cached_posts',
    'detail_json IS NOT NULL',
    db.cachedPosts,
  );
  final rooms = await _count(db, 'cached_rooms', db.cachedRooms);
  final messages = await _count(db, 'cached_messages', db.cachedMessages);
  final topPosts = await db.customSelect(
    'SELECT id, byte_size, last_viewed_at_ms, updated_at_ms, '
    'detail_json IS NOT NULL AS has_detail '
    'FROM cached_posts ORDER BY last_viewed_at_ms DESC LIMIT 10',
    readsFrom: {db.cachedPosts},
  ).get();
  final topRooms = await db.customSelect(
    'SELECT id, byte_size, last_viewed_at_ms, updated_at_ms '
    'FROM cached_rooms ORDER BY last_viewed_at_ms DESC LIMIT 10',
    readsFrom: {db.cachedRooms},
  ).get();

  return {
    'totalBytes': totalBytes,
    'budgetBytes': cacheBudgetBytes,
    'tables': {
      'tags': tags,
      'tagFeedRows': feedRows,
      'posts': posts,
      'postDetails': postDetails,
      'rooms': rooms,
      'messages': messages,
    },
    'recentPosts': topPosts.map((row) => row.data).toList(),
    'recentRooms': topRooms.map((row) => row.data).toList(),
  };
}

Future<int> _count(
  CacheDatabase db,
  String table,
  ResultSetImplementation<Table, Object?> readsFrom,
) async {
  final row = await db.customSelect(
    'SELECT COUNT(*) AS c FROM $table',
    readsFrom: {readsFrom},
  ).getSingle();
  return row.data['c'] as int;
}

Future<int> _countWhere(
  CacheDatabase db,
  String table,
  String where,
  ResultSetImplementation<Table, Object?> readsFrom,
) async {
  final row = await db.customSelect(
    'SELECT COUNT(*) AS c FROM $table WHERE $where',
    readsFrom: {readsFrom},
  ).getSingle();
  return row.data['c'] as int;
}

Map<String, Object?> _pendingMutationJson(PendingMutation row) {
  return {
    'id': row.id,
    'kind': row.kind,
    'attempts': row.attempts,
    'queuedAt': row.queuedAt.toIso8601String(),
    'lastError': row.lastError,
    'payloadPreview': row.payload.length <= 500
        ? row.payload
        : '${row.payload.substring(0, 500)}...',
  };
}
