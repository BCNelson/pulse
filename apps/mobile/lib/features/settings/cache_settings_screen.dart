import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/cache_evictor.dart';
import '../../core/persistent_cache.dart';
import '../../core/ui_state_storage.dart';
import '../../design/tokens.dart';
import '../../design/typography.dart';

/// Live byte usage of the persistent cache db. Refreshes on demand
/// (after evictions or clear) by invalidating this provider.
final _cacheUsageProvider = FutureProvider.autoDispose<int>((ref) async {
  final db = ref.watch(cacheDatabaseProvider);
  return db.totalByteSize();
});

class CacheSettingsScreen extends ConsumerWidget {
  const CacheSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final budget = ref.watch(cacheMaxBytesProvider);
    final usage = ref.watch(_cacheUsageProvider);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        title: Text('CACHE', style: pulseMono(context, size: 12)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(22),
        children: [
          Text(
            'On-device cache',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 6),
          Text(
            'Posts (with comments) and chat threads you visit are kept '
            'on this device so they appear instantly on next launch. '
            'Older items are evicted when the budget is reached.',
            style: TextStyle(
              fontFamily: pulseMonoFamily,
              fontSize: 11,
              color: t.ink3,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          Text('Current usage',
              style: pulseMono(context,
                  size: 11, color: t.ink2, weight: FontWeight.w600)),
          const SizedBox(height: 4),
          usage.when(
            data: (bytes) => Text(
              '${_fmtMb(bytes)} of ${_fmtMb(budget)}',
              style: pulseMono(context, size: 13, color: t.ink),
            ),
            loading: () => Text('…', style: pulseMono(context, size: 13)),
            error: (e, _) => Text(e.toString(),
                style: pulseMono(context, size: 11, color: t.amberInk)),
          ),
          const SizedBox(height: 22),
          Text('Budget',
              style: pulseMono(context,
                  size: 11, color: t.ink2, weight: FontWeight.w600)),
          Slider(
            min: UiStateStorage.minCacheMaxBytes.toDouble(),
            max: UiStateStorage.maxCacheMaxBytes.toDouble(),
            value: budget.toDouble().clamp(
                  UiStateStorage.minCacheMaxBytes.toDouble(),
                  UiStateStorage.maxCacheMaxBytes.toDouble(),
                ),
            divisions: 24,
            label: _fmtMb(budget),
            onChanged: (v) {
              ref.read(cacheMaxBytesProvider.notifier).set(v.round());
              // Refresh usage after the eviction pass runs.
              ref.invalidate(_cacheUsageProvider);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_fmtMb(UiStateStorage.minCacheMaxBytes),
                  style: pulseMono(context, size: 10, color: t.ink3)),
              Text(_fmtMb(UiStateStorage.maxCacheMaxBytes),
                  style: pulseMono(context, size: 10, color: t.ink3)),
            ],
          ),
          const SizedBox(height: 28),
          OutlinedButton.icon(
            icon: const Icon(Icons.delete_outline, size: 16),
            label: Text('Clear cache now', style: pulseMono(context, size: 12)),
            onPressed: () async {
              final messenger = ScaffoldMessenger.maybeOf(context);
              await ref.read(cacheDatabaseProvider).clearAll();
              ref.invalidate(_cacheUsageProvider);
              messenger?.showSnackBar(
                const SnackBar(content: Text('cache cleared')),
              );
            },
          ),
        ],
      ),
    );
  }

  static String _fmtMb(int bytes) {
    final mb = bytes / (1024 * 1024);
    if (mb >= 100) return '${mb.toStringAsFixed(0)} MB';
    if (mb >= 10) return '${mb.toStringAsFixed(1)} MB';
    return '${mb.toStringAsFixed(2)} MB';
  }
}
