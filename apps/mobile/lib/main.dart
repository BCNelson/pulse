import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'core/auth_controller.dart';
import 'core/cache_evictor.dart';
import 'core/outbox_replay.dart';
import 'core/router.dart';
import 'devtools/pulse_devtools_service.dart';
import 'design/theme_controller.dart';
import 'design/themes.dart';

void main() {
  // Use clean path-based URLs on web (no leading #). The API's
  // staticSPAHandler in services/api/cmd/api/static.go returns index.html
  // for unknown paths, so deep links like /feed/p/abc work on cold visit.
  usePathUrlStrategy();
  runApp(const ProviderScope(child: PulseApp()));
}

class PulseApp extends ConsumerWidget {
  const PulseApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    assert(registerPulseDevToolsService(ref));
    final themeKey = ref.watch(pulseThemeControllerProvider);

    // Auth side effects on sign-in. Used to live in AuthGate; the gate
    // widget is gone now that the router redirects on auth state.
    ref.listen(authControllerProvider, (prev, next) {
      if (next is AuthSignedIn) {
        ref.read(outboxReplayProvider).drain();
        ref.read(cacheEvictorProvider).evict();
      }
    });

    final router = ref.watch(goRouterProvider);
    return MaterialApp.router(
      title: 'Pulse',
      theme: pulseTheme(themeKey),
      localizationsDelegates: const [
        FlutterQuillLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      routerConfig: router,
    );
  }
}
