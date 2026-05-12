import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ui_state_storage.dart';

/// Single shared [SharedPreferences] handle. Resolving this future once
/// at startup lets the persisting notifiers below read synchronously
/// during build instead of each one doing its own async getInstance().
final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) {
  return SharedPreferences.getInstance();
});

/// Synchronous handle to [UiStateStorage]. Reads will throw if the
/// preferences future hasn't resolved yet — callers must gate on
/// [sharedPreferencesProvider] (the AuthGate splash does this) before
/// reading from it.
final uiStateStorageProvider = Provider<UiStateStorage>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider).requireValue;
  return UiStateStorage(prefs);
});
