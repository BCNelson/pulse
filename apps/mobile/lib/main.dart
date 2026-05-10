import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/auth_controller.dart';
import 'core/outbox_replay.dart';
import 'features/auth/login_screen.dart';
import 'features/shell/three_pane_shell.dart';

void main() {
  runApp(const ProviderScope(child: PulseApp()));
}

class PulseApp extends StatelessWidget {
  const PulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pulse',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1B7F79)),
        useMaterial3: true,
      ),
      home: const AuthGate(),
    );
  }
}

/// AuthGate switches between the login screen and the app shell based
/// on the auth controller's state. While the controller boots from
/// secure storage we render a splash so we don't flash the login screen
/// to a returning user.
class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authControllerProvider);
    // On login (or returning user), drain any pending outbox mutations.
    // The replayer is idempotent and self-guarded so multiple triggers
    // are harmless.
    ref.listen(authControllerProvider, (prev, next) {
      if (next is AuthSignedIn) {
        ref.read(outboxReplayProvider).drain();
      }
    });
    return switch (state) {
      AuthLoading() => const _Splash(),
      AuthSignedOut() => const LoginScreen(),
      AuthSignedIn() => const ThreePaneShell(),
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
