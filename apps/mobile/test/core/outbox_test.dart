import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/core/outbox.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late OutboxDatabase db;

  setUp(() {
    db = OutboxDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() => db.close());

  test('enqueue + peekAll preserves insertion order and round-trips payload',
      () async {
    final id1 = await db.enqueue('createPost', {'title': 'first', 'tags': []});
    final id2 = await db.enqueue('sendMessage', {'roomId': 'r1', 'body': 'hi'});

    final rows = await db.peekAll();
    expect(rows.map((r) => r.id).toList(), [id1, id2]);
    expect(rows[0].kind, 'createPost');
    expect(rows[1].kind, 'sendMessage');

    expect(jsonDecode(rows[0].payload), {'title': 'first', 'tags': <Object>[]});
    expect(jsonDecode(rows[1].payload), {'roomId': 'r1', 'body': 'hi'});
    expect(rows[0].attempts, 0);
    expect(rows[0].lastError, isNull);
    expect(rows[0].queuedAt, isNotNull);
  });

  test('remove deletes the named row and leaves siblings intact', () async {
    final id1 = await db.enqueue('a', {});
    final id2 = await db.enqueue('b', {});

    final removed = await db.remove(id1);
    expect(removed, 1);

    final remaining = await db.peekAll();
    expect(remaining.length, 1);
    expect(remaining.single.id, id2);
  });

  test('remove of an unknown id is a no-op (idempotent on reconnect drain)',
      () async {
    expect(await db.remove(999), 0);
  });

  test('markFailure stores the latest error string on the row', () async {
    final id = await db.enqueue('createPost', {'title': 't'});
    await db.markFailure(id, 'network: connection refused');

    final row = (await db.peekAll()).single;
    expect(row.lastError, 'network: connection refused');

    await db.markFailure(id, 'server: 503');
    final updated = (await db.peekAll()).single;
    expect(updated.lastError, 'server: 503');
  });
}
