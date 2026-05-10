import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/outbox.dart';

/// OutboxIndicator shows a small pill in the app bar when pending
/// mutations are queued. Tap to open the outbox sheet (M5.C+ —
/// minimal here).
class OutboxIndicator extends ConsumerWidget {
  const OutboxIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(outboxCountProvider);
    final count = async.whenOrNull(data: (n) => n) ?? 0;
    if (count == 0) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off_outlined, size: 14, color: Colors.white),
            const SizedBox(width: 4),
            Text(
              '$count pending',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
