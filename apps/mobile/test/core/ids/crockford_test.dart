import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/core/ids/crockford.dart' as ids;

/// Path to the shared golden vectors. The Go side keeps the authoritative
/// copy at services/api/pkg/ids/testdata/crockford_vectors.json; the Dart
/// test reads it directly so the two codecs can never silently drift.
const _vectorsPath = '../../services/api/pkg/ids/testdata/crockford_vectors.json';

Map<String, dynamic> _loadVectors() {
  final f = File(_vectorsPath);
  if (!f.existsSync()) {
    throw StateError('vectors not found at $_vectorsPath');
  }
  return jsonDecode(f.readAsStringSync()) as Map<String, dynamic>;
}

void main() {
  group('Crockford codec', () {
    final v = _loadVectors();

    test('round-trip vectors match Go', () {
      final roundTrips = (v['roundTrips'] as List).cast<Map<String, dynamic>>();
      for (final rt in roundTrips) {
        final kind = rt['kind'] as int;
        final body = rt['body'] as int;
        final wantStr = rt['str'] as String;
        final n = (kind << 55) | body;
        expect(ids.encode(n), wantStr, reason: 'encode kind=$kind body=$body');
        expect(ids.decode(wantStr), n, reason: 'decode "$wantStr"');
      }
    });

    test('lowercase variant decodes equivalently', () {
      final eqs =
          (v['lowercaseEquivalents'] as List).cast<Map<String, dynamic>>();
      for (final eq in eqs) {
        expect(
          ids.decode(eq['variant'] as String),
          ids.decode(eq['canonical'] as String),
        );
      }
    });

    test('I/L/O substitutions decode equivalently', () {
      final subs = (v['substitutions'] as List).cast<Map<String, dynamic>>();
      for (final s in subs) {
        final canonical = ids.decode(s['canonical'] as String);
        for (final variant in (s['variants'] as List).cast<String>()) {
          expect(ids.decode(variant), canonical, reason: variant);
        }
      }
    });

    test('rejections fail', () {
      final rejections = (v['rejections'] as List).cast<Map<String, dynamic>>();
      for (final r in rejections) {
        expect(
          () => ids.decode(r['input'] as String),
          throwsA(anything),
          reason: r['input'] as String,
        );
      }
    });

    test('unregistered kinds rejected by kindOf', () {
      final unreg = (v['unregisteredKinds'] as List).cast<Map<String, dynamic>>();
      for (final u in unreg) {
        expect(
          () => ids.kindOf(u['input'] as String),
          throwsA(isA<ids.InvalidIdException>()),
          reason: u['input'] as String,
        );
      }
    });
  });

  group('parseAs', () {
    test('accepts matching kind', () {
      const post = 'P1XB7NE7X7RV';
      expect(ids.parseAs(ids.IdKind.post, post), post);
    });

    test('rejects cross-kind', () {
      const post = 'P1XB7NE7X7RV';
      expect(
        () => ids.parseAs(ids.IdKind.comment, post),
        throwsA(isA<ids.InvalidIdException>()),
      );
    });

    test('rejects malformed', () {
      expect(
        () => ids.parseAs(ids.IdKind.post, 'P1XB7'),
        throwsA(isA<ids.InvalidIdException>()),
      );
    });
  });

  group('kindOf', () {
    test('extracts kind without decoding body', () {
      expect(ids.kindOf('P1XB7NE7X7RV'), ids.IdKind.post);
      expect(ids.kindOf('C00000000001'), ids.IdKind.comment);
      expect(ids.kindOf('T00000000000'), ids.IdKind.tag);
      expect(ids.kindOf('R00000000000'), ids.IdKind.room);
      expect(ids.kindOf('V00000000000'), ids.IdKind.user);
    });
  });

  group('isValid', () {
    test('accepts well-formed IDs', () {
      expect(ids.isValid('P1XB7NE7X7RV'), isTrue);
      expect(ids.isValid('p1xb7ne7x7rv'), isTrue);
    });
    test('rejects malformed', () {
      expect(ids.isValid('P1XB7'), isFalse);
      expect(ids.isValid('U00000000000'), isFalse); // Crockford excludes U
      expect(ids.isValid('X00000000000'), isFalse); // X is unregistered
    });
  });
}
