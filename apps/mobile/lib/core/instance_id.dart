/// Build-time tag that prefixes every on-device storage key/filename so
/// two clients can run side-by-side on one machine (shared_preferences,
/// libsecret keyring entries, drift sqlite files all collide otherwise).
/// Empty default = no prefix, identical to a single-client install.
const pulseInstanceId = String.fromEnvironment('PULSE_INSTANCE_ID');

String namespacedKey(String key) =>
    pulseInstanceId.isEmpty ? key : '$pulseInstanceId.$key';

String namespacedFile(String baseName, String ext) => pulseInstanceId.isEmpty
    ? '$baseName.$ext'
    : '${baseName}_$pulseInstanceId.$ext';

/// Like [namespacedFile] but returns a bare name (no extension), suitable for
/// `driftDatabase(name:)` which appends `.sqlite` on native and uses the value
/// as an OPFS / IndexedDB key on web.
String namespacedName(String baseName) =>
    pulseInstanceId.isEmpty ? baseName : '${baseName}_$pulseInstanceId';
