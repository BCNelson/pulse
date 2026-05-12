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
