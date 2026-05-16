import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/core/cache_evictor.dart';
import 'package:pulse/core/persistent_cache.dart';
import 'package:pulse/features/settings/cache_settings_screen.dart';

import '../_widget_test_helpers.dart';

void main() {
  testWidgets('CacheSettingsScreen renders usage + budget slider against an '
      'empty in-memory cache', (tester) async {
    final db = CacheDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);

    await pumpScreen(
      tester,
      const CacheSettingsScreen(),
      overrides: [
        cacheDatabaseProvider.overrideWithValue(db),
        cacheMaxBytesProvider
            .overrideWith(() => _FixedCacheBudget(64 * 1024 * 1024)),
      ],
    );

    // Future-backed usage resolves on the next microtask.
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('CACHE'), findsOneWidget);
    expect(find.text('On-device cache'), findsOneWidget);
    expect(find.byType(Slider), findsOneWidget);
  });
}

class _FixedCacheBudget extends CacheMaxBytesNotifier {
  _FixedCacheBudget(this._value);

  final int _value;

  @override
  int build() => _value;

  @override
  Future<void> set(int bytes) async {
    state = bytes;
  }
}
