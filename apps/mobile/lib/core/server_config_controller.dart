import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'server_config.dart';
import 'server_config_storage.dart';

/// Build-time override. When set via `--dart-define=PULSE_SERVER_URL=...`
/// the app uses it directly and skips the first-run URL screen.
const _envServerUrl = String.fromEnvironment('PULSE_SERVER_URL');

/// AuthGate consults this state to decide whether to show the server
/// URL entry screen, the login screen, or the app shell.
sealed class ServerConfigState {
  const ServerConfigState();
}

class ServerConfigLoading extends ServerConfigState {
  const ServerConfigLoading();
}

class ServerConfigMissing extends ServerConfigState {
  const ServerConfigMissing({this.lastError});
  final String? lastError;
}

class ServerConfigReady extends ServerConfigState {
  const ServerConfigReady(this.config);
  final ServerConfig config;
}

/// Owns the server URL the app talks to. Boot order:
///   1. PULSE_SERVER_URL dart-define (preconfigured/enterprise builds)
///   2. SharedPreferences (returning user)
///   3. Missing → show first-run entry screen
class ServerConfigController extends Notifier<ServerConfigState> {
  late final ServerConfigStorage _storage;

  ServerConfig? get config =>
      switch (state) { ServerConfigReady s => s.config, _ => null };

  @override
  ServerConfigState build() {
    _storage = ServerConfigStorage();
    _restore();
    return const ServerConfigLoading();
  }

  Future<void> _restore() async {
    if (_envServerUrl.isNotEmpty) {
      // Build-time override wins absolutely. Persisted storage is
      // ignored and the first-run entry screen is never shown. A
      // misconfigured PULSE_SERVER_URL is treated as a build bug:
      // we leave the controller in Loading so the splash persists
      // and a debug-build assertion surfaces the cause.
      try {
        state = ServerConfigReady(parseServerUrl(_envServerUrl));
      } catch (e) {
        debugPrint('PULSE_SERVER_URL is invalid ($_envServerUrl): $e');
        assert(false, 'PULSE_SERVER_URL is invalid ($_envServerUrl): $e');
      }
      return;
    }

    final stored = await _storage.read();
    if (stored != null && stored.isNotEmpty) {
      try {
        state = ServerConfigReady(parseServerUrl(stored));
        return;
      } catch (_) {
        // Stored value got corrupted somehow — clear it and re-prompt.
        await _storage.clear();
      }
    }
    state = const ServerConfigMissing();
  }

  /// Parse [input], persist on success, transition to Ready (or back
  /// to Missing with [ServerConfigMissing.lastError] on parse failure).
  /// Returns true if the URL was accepted.
  Future<bool> submit(String input) async {
    try {
      final config = parseServerUrl(input);
      await _storage.save(config.baseUrl);
      state = ServerConfigReady(config);
      return true;
    } on FormatException catch (e) {
      state = ServerConfigMissing(lastError: e.message);
      return false;
    }
  }

  Future<void> clear() async {
    await _storage.clear();
    state = const ServerConfigMissing();
  }
}

final serverConfigControllerProvider =
    NotifierProvider<ServerConfigController, ServerConfigState>(
  ServerConfigController.new,
);
