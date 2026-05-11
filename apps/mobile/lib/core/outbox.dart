import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

part 'outbox.g.dart';

/// PendingMutations rows are mutations the user composed while
/// offline (or while a request was in flight and failed). The replay
/// loop pops them oldest-first and re-issues them through ferry.
@DataClassName('PendingMutation')
class PendingMutations extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get kind =>
      text()(); // 'createPost', 'createComment', 'sendMessage', etc.
  TextColumn get payload => text()(); // JSON-encoded variables
  IntColumn get attempts => integer().withDefault(const Constant(0))();
  DateTimeColumn get queuedAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get lastError => text().nullable()();
}

@DriftDatabase(tables: [PendingMutations])
class OutboxDatabase extends _$OutboxDatabase {
  OutboxDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<int> enqueue(String kind, Map<String, dynamic> payload) {
    return into(pendingMutations).insert(
      PendingMutationsCompanion(
        kind: Value(kind),
        payload: Value(jsonEncode(payload)),
      ),
    );
  }

  Future<List<PendingMutation>> peekAll() => select(pendingMutations).get();

  Future<int> remove(int id) =>
      (delete(pendingMutations)..where((t) => t.id.equals(id))).go();

  Future<int> markFailure(int id, String err) {
    return (update(pendingMutations)..where((t) => t.id.equals(id))).write(
      PendingMutationsCompanion(
        attempts: const Value.absent(),
        lastError: Value(err),
      ),
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/pulse_outbox.sqlite');
    return NativeDatabase.createInBackground(file);
  });
}

final outboxDatabaseProvider = Provider<OutboxDatabase>((ref) {
  final db = OutboxDatabase();
  ref.onDispose(db.close);
  return db;
});

/// outboxCountProvider exposes a live row count for the "n pending"
/// badge in the UI.
final outboxCountProvider = StreamProvider<int>((ref) {
  final db = ref.watch(outboxDatabaseProvider);
  return db.select(db.pendingMutations).watch().map((rows) => rows.length);
});
