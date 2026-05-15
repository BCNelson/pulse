/// Typed Crockford-base32 ID codec, mirroring services/api/pkg/ids.
///
/// Every entity carries a 63-bit positive bigint primary key. The wire form
/// — what appears in URLs, GraphQL responses, federation URIs — is the
/// bottom 60 bits Crockford-encoded MSB-first as a 12-character string.
/// char[0] is the kind letter (a Crockford-alphabet character whose value
/// 0..31 names the entity kind); chars[1..11] are the random body.
///
/// The Dart side mostly treats typed IDs as opaque strings — the codec is
/// here for the rare site (debug tools, validation) that wants to inspect
/// the kind without round-tripping through the server.
library;

const String _alphabet = '0123456789ABCDEFGHJKMNPQRSTVWXYZ';

/// Lookup table: byte value → 5-bit Crockford value, or -1 if invalid.
/// Initialized once at first use.
final List<int> _decodeTable = () {
  final t = List<int>.filled(256, -1);
  for (var i = 0; i < _alphabet.length; i++) {
    final c = _alphabet.codeUnitAt(i);
    t[c] = i;
    // Lowercase variant.
    if (c >= 0x41 && c <= 0x5A) {
      t[c + 0x20] = i;
    }
  }
  // Crockford substitutions.
  t[0x49] = t[0x69] = 1; // I/i → 1
  t[0x4C] = t[0x6C] = 1; // L/l → 1
  t[0x4F] = t[0x6F] = 0; // O/o → 0
  return List<int>.unmodifiable(t);
}();

/// The kind index ↔ letter ↔ name registry. Kept in lockstep with
/// services/api/pkg/ids/kinds.go and db/migrations/000001_init.sql.
enum IdKind {
  attachment(10, 'attachments'),
  comment(12, 'comments'),
  device(13, 'devices'),
  message(16, 'messages'),
  job(18, 'jobs'),
  task(19, 'tasks'),
  impersonation(20, 'impersonations'),
  notification(21, 'notifications'),
  post(22, 'posts'),
  room(24, 'chat_rooms'),
  session(25, 'sessions'),
  tag(26, 'tags'),
  user(27, 'principals'),
  workspace(28, 'workspaces');

  final int kindIndex;
  final String pluralName;
  const IdKind(this.kindIndex, this.pluralName);

  /// The single Crockford character every encoded ID of this kind starts with.
  String get letter => _alphabet[kindIndex];

  /// Reverse lookup for the kind associated with a Crockford char value,
  /// or null if the value isn't a registered kind.
  static IdKind? fromKindIndex(int idx) {
    for (final k in values) {
      if (k.kindIndex == idx) return k;
    }
    return null;
  }
}

class InvalidIdException implements Exception {
  final String message;
  const InvalidIdException(this.message);
  @override
  String toString() => 'InvalidIdException: $message';
}

/// Encodes the bottom 60 bits of [n] as a 12-character Crockford wire form.
/// Throws [ArgumentError] for values outside the 60-bit range.
String encode(int n) {
  if (n < 0 || n > 0x0FFFFFFFFFFFFFFF) {
    throw ArgumentError('encode: value $n out of 60-bit range');
  }
  final out = List<int>.filled(12, 0);
  for (var i = 0; i < 12; i++) {
    final shift = 5 * (11 - i);
    out[i] = _alphabet.codeUnitAt((n >> shift) & 0x1F);
  }
  return String.fromCharCodes(out);
}

/// Decodes a 12-character Crockford wire form into its packed int.
/// Accepts upper/lowercase plus the standard substitutions (I/L → 1, O → 0).
int decode(String s) {
  if (s.length != 12) {
    throw InvalidIdException('expected 12 chars, got ${s.length}');
  }
  var n = 0;
  for (var i = 0; i < 12; i++) {
    final v = _decodeTable[s.codeUnitAt(i)];
    if (v < 0) {
      throw InvalidIdException('invalid char "${s[i]}" at position $i in "$s"');
    }
    n = (n << 5) | v;
  }
  return n;
}

/// Extract the kind from an encoded ID, validating that it's registered.
IdKind kindOf(String s) {
  if (s.length != 12) {
    throw InvalidIdException('expected 12 chars, got ${s.length}');
  }
  final v = _decodeTable[s.codeUnitAt(0)];
  if (v < 0) {
    throw InvalidIdException('invalid kind char "${s[0]}"');
  }
  final k = IdKind.fromKindIndex(v);
  if (k == null) {
    throw InvalidIdException('unregistered kind char "${s[0]}" (value $v)');
  }
  return k;
}

/// Validates that [id] is a well-formed wire ID of the expected kind.
/// Returns the canonical 12-char form on success.
String parseAs(IdKind expected, String id) {
  final k = kindOf(id);
  if (k != expected) {
    throw InvalidIdException(
      'expected ${expected.name} (${expected.letter}), got ${k.name} (${k.letter})',
    );
  }
  return id;
}

/// True if [s] is a well-formed wire ID (any registered kind).
bool isValid(String s) {
  try {
    kindOf(s);
    decode(s);
    return true;
  } catch (_) {
    return false;
  }
}
