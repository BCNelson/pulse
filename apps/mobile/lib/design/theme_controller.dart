import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'themes.dart';

const _themePrefKey = 'pulse.theme';

/// Holds the user's currently selected [PulseThemeKey]. Persisted via
/// SharedPreferences so it survives restarts.
class PulseThemeController extends Notifier<PulseThemeKey> {
  SharedPreferences? _prefs;

  @override
  PulseThemeKey build() {
    _restore();
    return PulseThemeKey.bone;
  }

  Future<void> _restore() async {
    _prefs = await SharedPreferences.getInstance();
    final stored = _prefs!.getString(_themePrefKey);
    if (stored == null) return;
    final found =
        PulseThemeKey.values.where((k) => k.name == stored).firstOrNull;
    if (found != null && found != state) {
      state = found;
    }
  }

  Future<void> select(PulseThemeKey key) async {
    state = key;
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setString(_themePrefKey, key.name);
  }
}

final pulseThemeControllerProvider =
    NotifierProvider<PulseThemeController, PulseThemeKey>(
  PulseThemeController.new,
);
