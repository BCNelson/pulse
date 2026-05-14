import 'dart:async';
import 'dart:convert';

import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const PulseDevToolsExtension());
}

class PulseDevToolsExtension extends StatelessWidget {
  const PulseDevToolsExtension({super.key});

  @override
  Widget build(BuildContext context) {
    return const DevToolsExtension(child: PulseDevToolsApp());
  }
}

class PulseDevToolsApp extends StatelessWidget {
  const PulseDevToolsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pulse',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff2f6f73),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        visualDensity: VisualDensity.compact,
      ),
      home: const PulseDevToolsHome(),
    );
  }
}

class PulseDevToolsHome extends StatefulWidget {
  const PulseDevToolsHome({super.key});

  @override
  State<PulseDevToolsHome> createState() => _PulseDevToolsHomeState();
}

class _PulseDevToolsHomeState extends State<PulseDevToolsHome> {
  PulseSnapshot? _snapshot;
  String? _error;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    unawaited(_refresh());
  }

  Future<void> _refresh() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final response = await serviceManager.callServiceExtensionOnMainIsolate(
        'ext.pulse.snapshot',
      );
      setState(() {
        _snapshot = PulseSnapshot.fromJson(response.json ?? const {});
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Future<void> _runCacheEviction() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final response = await serviceManager.callServiceExtensionOnMainIsolate(
        'ext.pulse.runCacheEviction',
      );
      final json = response.json ?? const {};
      final snapshot = json['snapshot'] is Map<String, Object?>
          ? json['snapshot'] as Map<String, Object?>
          : json;
      setState(() {
        _snapshot = PulseSnapshot.fromJson(snapshot);
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final snapshot = _snapshot;
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pulse'),
          actions: [
            IconButton(
              tooltip: 'Refresh',
              onPressed: _loading ? null : _refresh,
              icon: _loading
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.refresh),
            ),
          ],
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(icon: Icon(Icons.outbox), text: 'Outbox'),
              Tab(icon: Icon(Icons.storage), text: 'Cache'),
              Tab(icon: Icon(Icons.account_circle), text: 'Auth'),
              Tab(icon: Icon(Icons.hub), text: 'GraphQL'),
              Tab(icon: Icon(Icons.sync_alt), text: 'Realtime'),
              Tab(icon: Icon(Icons.edit_note), text: 'Composer'),
            ],
          ),
        ),
        body: Column(
          children: [
            if (_error != null)
              MaterialBanner(
                content: Text(_error!),
                actions: [
                  TextButton(onPressed: _refresh, child: const Text('Retry')),
                ],
              ),
            _SnapshotHeader(snapshot: snapshot),
            Expanded(
              child: snapshot == null
                  ? const Center(child: CircularProgressIndicator())
                  : TabBarView(
                      children: [
                        _OutboxTab(snapshot: snapshot),
                        _CacheTab(
                          snapshot: snapshot,
                          onRunEviction: _loading ? null : _runCacheEviction,
                        ),
                        _AuthTab(snapshot: snapshot),
                        _GraphQlTab(snapshot: snapshot),
                        _RealtimeTab(snapshot: snapshot),
                        _ComposerTab(snapshot: snapshot),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class PulseSnapshot {
  PulseSnapshot({
    required this.generatedAt,
    required this.auth,
    required this.server,
    required this.outbox,
    required this.cache,
    required this.composer,
  });

  factory PulseSnapshot.fromJson(Map<String, Object?> json) {
    return PulseSnapshot(
      generatedAt: json['generatedAt']?.toString() ?? 'unknown',
      auth: _asMap(json['auth']),
      server: _asMap(json['server']),
      outbox: _asMap(json['outbox']),
      cache: _asMap(json['cache']),
      composer: _asMap(json['composer']),
    );
  }

  final String generatedAt;
  final Map<String, Object?> auth;
  final Map<String, Object?> server;
  final Map<String, Object?> outbox;
  final Map<String, Object?> cache;
  final Map<String, Object?> composer;
}

class _SnapshotHeader extends StatelessWidget {
  const _SnapshotHeader({required this.snapshot});

  final PulseSnapshot? snapshot;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final snapshot = this.snapshot;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: theme.colorScheme.surfaceContainerHighest,
      child: Wrap(
        spacing: 16,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          _Metric(
            label: 'Auth',
            value: snapshot?.auth['state']?.toString() ?? 'loading',
          ),
          _Metric(
            label: 'Server',
            value: snapshot?.server['state']?.toString() ?? 'loading',
          ),
          _Metric(
            label: 'Outbox',
            value: '${_int(snapshot?.outbox['pendingCount'])} pending',
          ),
          _Metric(
            label: 'Cache',
            value: _bytes(_int(snapshot?.cache['totalBytes'])),
          ),
          _Metric(label: 'Snapshot', value: snapshot?.generatedAt ?? 'loading'),
        ],
      ),
    );
  }
}

class _OutboxTab extends StatelessWidget {
  const _OutboxTab({required this.snapshot});

  final PulseSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final items = _asList(snapshot.outbox['items']);
    return _PanelList(
      children: [
        _SectionTitle(
          title: 'Pending mutations',
          trailing: '${_int(snapshot.outbox['pendingCount'])} queued',
        ),
        if (items.isEmpty)
          const _EmptyState('No pending offline mutations.')
        else
          for (final item in items)
            _DataCard(
              title: '#${item['id']} ${item['kind']}',
              subtitle:
                  'queued ${item['queuedAt']} · attempts ${item['attempts']}',
              rows: {
                'last error': item['lastError'] ?? '',
                'payload': item['payloadPreview'] ?? '',
              },
            ),
      ],
    );
  }
}

class _CacheTab extends StatelessWidget {
  const _CacheTab({required this.snapshot, required this.onRunEviction});

  final PulseSnapshot snapshot;
  final VoidCallback? onRunEviction;

  @override
  Widget build(BuildContext context) {
    final tables = _asMap(snapshot.cache['tables']);
    final posts = _asList(snapshot.cache['recentPosts']);
    final rooms = _asList(snapshot.cache['recentRooms']);
    return _PanelList(
      children: [
        _SectionTitle(
          title: 'Persistent cache',
          trailing: _bytes(_int(snapshot.cache['totalBytes'])),
          action: FilledButton.icon(
            onPressed: onRunEviction,
            icon: const Icon(Icons.cleaning_services),
            label: const Text('Run eviction'),
          ),
        ),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _MetricCard(label: 'Tags', value: '${_int(tables['tags'])}'),
            _MetricCard(
              label: 'Feed rows',
              value: '${_int(tables['tagFeedRows'])}',
            ),
            _MetricCard(label: 'Posts', value: '${_int(tables['posts'])}'),
            _MetricCard(
              label: 'Post details',
              value: '${_int(tables['postDetails'])}',
            ),
            _MetricCard(label: 'Rooms', value: '${_int(tables['rooms'])}'),
            _MetricCard(
              label: 'Messages',
              value: '${_int(tables['messages'])}',
            ),
          ],
        ),
        const _SectionTitle(title: 'Recent posts'),
        if (posts.isEmpty)
          const _EmptyState('No cached posts.')
        else
          for (final post in posts)
            _DataCard(
              title: post['id']?.toString() ?? 'post',
              subtitle: _bytes(_int(post['byte_size'])),
              rows: {
                'has detail': post['has_detail'] ?? false,
                'last viewed': _millis(post['last_viewed_at_ms']),
                'updated': _millis(post['updated_at_ms']),
              },
            ),
        const _SectionTitle(title: 'Recent rooms'),
        if (rooms.isEmpty)
          const _EmptyState('No cached rooms.')
        else
          for (final room in rooms)
            _DataCard(
              title: room['id']?.toString() ?? 'room',
              subtitle: _bytes(_int(room['byte_size'])),
              rows: {
                'last viewed': _millis(room['last_viewed_at_ms']),
                'updated': _millis(room['updated_at_ms']),
              },
            ),
      ],
    );
  }
}

class _AuthTab extends StatelessWidget {
  const _AuthTab({required this.snapshot});

  final PulseSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return _PanelList(
      children: [
        const _SectionTitle(title: 'Session'),
        _DataCard(
          title: snapshot.auth['state']?.toString() ?? 'unknown',
          rows: {
            'email': snapshot.auth['email'] ?? '',
            'has token': snapshot.auth['hasToken'] ?? false,
            'token length': snapshot.auth['tokenLength'] ?? '',
            'last error': snapshot.auth['lastError'] ?? '',
          },
        ),
        const _SectionTitle(title: 'Server'),
        _DataCard(
          title: snapshot.server['state']?.toString() ?? 'unknown',
          rows: {
            'base URL': snapshot.server['baseUrl'] ?? '',
            'GraphQL HTTP': snapshot.server['graphqlHttpUrl'] ?? '',
            'GraphQL WS': snapshot.server['graphqlWsUrl'] ?? '',
            'last error': snapshot.server['lastError'] ?? '',
          },
        ),
      ],
    );
  }
}

class _GraphQlTab extends StatelessWidget {
  const _GraphQlTab({required this.snapshot});

  final PulseSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return _PanelList(
      children: [
        const _SectionTitle(title: 'GraphQL endpoints'),
        _DataCard(
          title: 'Configured transport',
          rows: {
            'queries and mutations': snapshot.server['graphqlHttpUrl'] ?? '',
            'subscriptions': snapshot.server['graphqlWsUrl'] ?? '',
            'auth state': snapshot.auth['state'] ?? '',
          },
        ),
        const _EmptyState(
          'Operation timing and error traces can be added by instrumenting the Ferry link chain.',
        ),
      ],
    );
  }
}

class _RealtimeTab extends StatelessWidget {
  const _RealtimeTab({required this.snapshot});

  final PulseSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final tables = _asMap(snapshot.cache['tables']);
    return _PanelList(
      children: [
        const _SectionTitle(title: 'Realtime sync'),
        _DataCard(
          title: 'Subscription transport',
          rows: {
            'websocket URL': snapshot.server['graphqlWsUrl'] ?? '',
            'cached rooms': tables['rooms'] ?? 0,
            'cached messages': tables['messages'] ?? 0,
            'cached posts': tables['posts'] ?? 0,
          },
        ),
        const _EmptyState(
          'Live subscription event history can be added behind the same debug service.',
        ),
      ],
    );
  }
}

class _ComposerTab extends StatelessWidget {
  const _ComposerTab({required this.snapshot});

  final PulseSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final draftKeys = _asScalarList(snapshot.composer['draftKeys']);
    return _PanelList(
      children: [
        _SectionTitle(
          title: 'Draft storage',
          trailing: '${_int(snapshot.composer['draftCount'])} drafts',
        ),
        if (draftKeys.isEmpty)
          const _EmptyState('No saved composer drafts.')
        else
          for (final key in draftKeys) _DataCard(title: key, rows: const {}),
      ],
    );
  }
}

class _PanelList extends StatelessWidget {
  const _PanelList({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(16), children: children);
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, this.trailing, this.action});

  final String title;
  final String? trailing;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 10),
      child: Row(
        children: [
          Expanded(child: Text(title, style: theme.textTheme.titleMedium)),
          if (trailing != null)
            Text(trailing!, style: theme.textTheme.labelLarge),
          if (action != null) ...[const SizedBox(width: 12), action!],
        ],
      ),
    );
  }
}

class _DataCard extends StatelessWidget {
  const _DataCard({required this.title, this.subtitle, required this.rows});

  final String title;
  final String? subtitle;
  final Map<String, Object?> rows;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.titleSmall),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(subtitle!, style: theme.textTheme.bodySmall),
            ],
            if (rows.isNotEmpty) const Divider(height: 18),
            for (final entry in rows.entries)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 132,
                      child: Text(
                        entry.key,
                        style: theme.textTheme.labelMedium,
                      ),
                    ),
                    Expanded(
                      child: SelectableText(
                        _formatValue(entry.value),
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 132,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: 8),
              Text(value, style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RichText(
      text: TextSpan(
        style: theme.textTheme.bodySmall,
        children: [
          TextSpan(
            text: '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          TextSpan(text: value),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState(this.message);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}

Map<String, Object?> _asMap(Object? value) {
  if (value is Map<String, Object?>) return value;
  if (value is Map) return value.cast<String, Object?>();
  return const {};
}

List<Map<String, Object?>> _asList(Object? value) {
  if (value is! List) return const [];
  return value
      .whereType<Map>()
      .map((item) => item.cast<String, Object?>())
      .toList();
}

List<String> _asScalarList(Object? value) {
  if (value is! List) return const [];
  return value.map((item) => item.toString()).toList();
}

int _int(Object? value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? 0;
}

String _bytes(int bytes) {
  if (bytes < 1024) return '$bytes B';
  if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
  return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
}

String _millis(Object? value) {
  final millis = _int(value);
  if (millis == 0) return '';
  return DateTime.fromMillisecondsSinceEpoch(millis).toIso8601String();
}

String _formatValue(Object? value) {
  if (value == null) return '';
  if (value is Map || value is List) {
    return const JsonEncoder.withIndent('  ').convert(value);
  }
  return value.toString();
}
