import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/auth_controller.dart';
import 'core/cache_evictor.dart';
import 'core/outbox_replay.dart';
import 'core/prefs_provider.dart';
import 'core/server_config_controller.dart';
import 'design/theme_controller.dart';
import 'design/themes.dart';
import 'features/auth/login_screen.dart';
import 'features/onboarding/server_url_screen.dart';
import 'features/shell/three_pane_shell.dart';

void main() {
  runApp(const ProviderScope(child: PulseApp()));
}

class PulseApp extends ConsumerWidget {
  const PulseApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeKey = ref.watch(pulseThemeControllerProvider);
    return MaterialApp(
      title: 'Pulse',
      theme: pulseTheme(themeKey),
      home: const AuthGate(),
    );
  }
}

/// AuthGate is the top-level routing widget. It walks two state
/// machines in order:
///   1. ServerConfig — until the app knows what URL to talk to, the
///      login screen and shell can't render anything useful.
///   2. Auth — once we have a server URL, decide login vs. shell.
///
/// While either is bootstrapping from storage we render a splash so
/// returning users don't get a flash of the URL or login screen.
class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serverCfg = ref.watch(serverConfigControllerProvider);
    final auth = ref.watch(authControllerProvider);
    // Persisted UI state (shell tab, selected post, drafts, …) reads
    // synchronously from SharedPreferences during build, so we gate the
    // shell on the prefs handle resolving — otherwise the first frame
    // would show defaults and snap to the saved state on the next.
    final prefs = ref.watch(sharedPreferencesProvider);
    // On login (or returning user), drain any pending outbox mutations.
    // The replayer is idempotent and self-guarded so multiple triggers
    // are harmless. Also kick off a full cache-eviction pass so any TTL
    // expirations and per-room cap trimming run once per session.
    ref.listen(authControllerProvider, (prev, next) {
      if (next is AuthSignedIn) {
        ref.read(outboxReplayProvider).drain();
        ref.read(cacheEvictorProvider).evict();
      }
    });

    if (serverCfg is ServerConfigLoading ||
        auth is AuthLoading ||
        prefs.isLoading) {
      return const _Splash();
    }
    if (serverCfg is ServerConfigMissing) {
      return const ServerUrlScreen();
    }
    return switch (auth) {
      AuthSignedIn() => const ThreePaneShell(),
      _ => const LoginScreen(),
    };
  }
}

class _Splash extends StatelessWidget {
  const _Splash();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
