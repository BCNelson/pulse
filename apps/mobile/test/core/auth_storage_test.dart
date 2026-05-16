import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/core/auth_storage.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // flutter_secure_storage on host platforms talks to a MethodChannel.
  // We back it with a plain Map<String, String> so the storage round-trip
  // is exercised end-to-end without bringing in keychain/keystore.
  const channel = MethodChannel('plugins.it_nomads.com/flutter_secure_storage');
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  late Map<String, String> backing;

  setUp(() {
    backing = <String, String>{};
    messenger.setMockMethodCallHandler(channel, (call) async {
      final args = (call.arguments as Map?)?.cast<String, Object?>() ?? const {};
      final key = args['key'] as String?;
      switch (call.method) {
        case 'write':
          backing[key!] = args['value'] as String;
          return null;
        case 'read':
          return backing[key];
        case 'delete':
          backing.remove(key);
          return null;
        case 'readAll':
          return Map<String, String>.from(backing);
        case 'deleteAll':
          backing.clear();
          return null;
        case 'containsKey':
          return backing.containsKey(key);
        default:
          throw UnimplementedError('mock missing: ${call.method}');
      }
    });
  });

  tearDown(() => messenger.setMockMethodCallHandler(channel, null));

  test('save then read returns the stored token and email', () async {
    final auth = AuthStorage(const FlutterSecureStorage());
    await auth.save(token: 'tok-123', email: 'alice@example.com');

    expect(await auth.readToken(), 'tok-123');
    expect(await auth.readEmail(), 'alice@example.com');
  });

  test('read before save returns null for both fields', () async {
    final auth = AuthStorage(const FlutterSecureStorage());
    expect(await auth.readToken(), isNull);
    expect(await auth.readEmail(), isNull);
  });

  test('clear deletes both keys and survives a re-read', () async {
    final auth = AuthStorage(const FlutterSecureStorage());
    await auth.save(token: 't', email: 'e@x');

    await auth.clear();

    expect(await auth.readToken(), isNull);
    expect(await auth.readEmail(), isNull);
  });

  test('save overwrites a previously-stored token (re-login)', () async {
    final auth = AuthStorage(const FlutterSecureStorage());
    await auth.save(token: 'old', email: 'a@x');
    await auth.save(token: 'new', email: 'a@x');

    expect(await auth.readToken(), 'new');
  });
}
