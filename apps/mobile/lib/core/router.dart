import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/login_screen.dart';
import '../features/chat/chat_pane.dart';
import '../features/feed/feed_screen.dart';
import '../features/inbox/inbox_screen.dart';
import '../features/onboarding/server_url_screen.dart';
import '../features/settings/cache_settings_screen.dart';
import '../features/settings/theme_picker_screen.dart';
import '../features/shell/scaffold_with_nav_bar.dart';
import '../features/shell/three_pane_shell.dart' show ShellTab;
import 'auth_controller.dart';
import 'prefs_provider.dart';
import 'server_config_controller.dart';
import 'ui_state_storage.dart';

/// Listenable that asks the router to re-evaluate its [GoRouter.redirect]
/// when auth, server-config, or prefs hydration state changes. The
/// redirect reads those providers via `ref.read`; this listenable is what
/// kicks the redirect re-evaluation.
class _RouterRefresh extends ChangeNotifier {
  _RouterRefresh(Ref ref) {
    ref.listen<AuthState>(authControllerProvider, (_, __) => notifyListeners());
    ref.listen<ServerConfigState>(
      serverConfigControllerProvider,
      (_, __) => notifyListeners(),
    );
    ref.listen(sharedPreferencesProvider, (_, __) => notifyListeners());
  }
}

final _routerRefreshProvider = Provider<_RouterRefresh>((ref) {
  final listenable = _RouterRefresh(ref);
  ref.onDispose(listenable.dispose);
  return listenable;
});

/// The single [GoRouter] for the app. Constructed once and owned by the
/// provider scope — disposed on tear-down.
///
/// Derived URL-state providers (`currentTabProvider`, `currentPostIdProvider`,
/// ...) listen via [_currentRouteProvider] below so they rebuild on
/// navigation. Consumers that just need the router instance for `context.go`
/// or [MaterialApp.router] use [goRouterProvider] directly.
///
/// Step 1 of the router migration: this is declared but **not yet wired**
/// to [MaterialApp]. The old selection notifiers still drive the UI.
final goRouterProvider = Provider<GoRouter>((ref) {
  final refresh = ref.watch(_routerRefreshProvider);

  final router = GoRouter(
    initialLocation: '/',
    refreshListenable: refresh,
    debugLogDiagnostics: kDebugMode,
    redirect: (context, state) {
      final path = state.uri.path;
      final prefs = ref.read(sharedPreferencesProvider);
      final server = ref.read(serverConfigControllerProvider);
      final auth = ref.read(authControllerProvider);

      final atLoading = path == '/_loading';
      final atSetup = path == '/setup';
      final atLogin = path == '/login';

      // While any bootstrapping is in flight, keep the splash up so no
      // screen tries to read uiStateStorageProvider before prefs hydrate.
      final stillLoading = prefs.isLoading ||
          server is ServerConfigLoading ||
          auth is AuthLoading;
      if (stillLoading) return atLoading ? null : '/_loading';

      if (server is ServerConfigMissing) return atSetup ? null : '/setup';
      if (auth is! AuthSignedIn) return atLogin ? null : '/login';

      // Catch degenerate feed URLs that would otherwise miss every route
      // and crash with "no routes for location: ...". Reach this if a
      // call site does context.go('/feed/t/$empty') or if a stale
      // lastRouteKey points at `/feed/t` / `/feed/p` from before the
      // slug-path migration.
      if (path == '/feed/t' || path == '/feed/t/' || path == '/feed/p' ||
          path == '/feed/p/') {
        return '/feed';
      }

      // Auth + server passed. Bounce away from gate / splash screens.
      if (atLogin || atSetup || atLoading || path == '/') {
        return _resumeOrInbox(ref);
      }
      return null;
    },
    errorBuilder: (context, state) => _NotFoundScreen(uri: state.uri),
    routes: [
      GoRoute(
        path: '/_loading',
        builder: (_, __) => const _Splash(),
      ),
      GoRoute(
        path: '/setup',
        builder: (_, __) => const ServerUrlScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (_, __) => const LoginScreen(),
      ),
      // Settings screens are full-screen, outside the shell.
      GoRoute(
        path: '/settings/theme',
        builder: (_, __) => const ThemePickerScreen(),
      ),
      GoRoute(
        path: '/settings/cache',
        builder: (_, __) => const CacheSettingsScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navShell) =>
            ScaffoldWithNavBar(navigationShell: navShell),
        branches: [
          // Branch 0 — Inbox.
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/inbox',
                builder: (_, __) => const InboxScreen(),
              ),
            ],
          ),
          // Branch 1 — Feed. Tag selection is a hierarchical slug path
          // (e.g. /feed/t/programming/rust); post selection is a 12-char
          // typed-Crockford ID. All routes render [FeedScreen]; it adapts
          // on screen width and reads selection from the URL via
          // currentTagPathProvider / currentPostIdProvider.
          //
          // Routes are ordered most-specific-first so the regex on postId
          // disambiguates "/feed/t/<segments>/p/<id>" from a tag-path that
          // happens to end in /p/<something>.
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/feed',
                builder: (_, __) => const FeedScreen(),
                routes: [
                  // All feed URLs render the same FeedScreen driven by URL
                  // state. NoTransitionPage suppresses the default push
                  // animation, which would otherwise fire only on depth
                  // changes (parent → child) and not on sibling param
                  // changes — producing an inconsistent feel.
                  GoRoute(
                    path: r't/:tagPath(.+)/p/:postId([0-9A-HJ-NP-TV-Za-hj-np-tv-zIiLlOo]{12})',
                    pageBuilder: (_, __) =>
                        const NoTransitionPage(child: FeedScreen()),
                  ),
                  GoRoute(
                    path: r'p/:postId([0-9A-HJ-NP-TV-Za-hj-np-tv-zIiLlOo]{12})',
                    pageBuilder: (_, __) =>
                        const NoTransitionPage(child: FeedScreen()),
                  ),
                  GoRoute(
                    path: r't/:tagPath(.+)',
                    pageBuilder: (_, __) =>
                        const NoTransitionPage(child: FeedScreen()),
                  ),
                ],
              ),
            ],
          ),
          // Branch 2 — Chat.
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/chat',
                builder: (_, __) => const ChatPane(),
                routes: [
                  GoRoute(
                    path: 'r/:roomId',
                    builder: (_, __) => const ChatPane(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );

  // Persist current path on every navigation so the next cold boot can
  // resume where the user left off. Transient routes (splash, gates) are
  // skipped so they're never restored.
  router.routerDelegate.addListener(() {
    final config = router.routerDelegate.currentConfiguration;
    if (config.isError) return;
    final path = config.uri.toString();
    if (path == '/' ||
        path == '/login' ||
        path == '/setup' ||
        path == '/_loading') {
      return;
    }
    final prefs = ref.read(sharedPreferencesProvider);
    if (!prefs.hasValue) return;
    ref
        .read(uiStateStorageProvider)
        .writeString(UiStateStorage.lastRouteKey, path);
  });

  ref.onDispose(router.dispose);
  return router;
});

/// Resolve `/` (or any gate-screen bounce) to either the last-visited
/// route or the inbox.
String _resumeOrInbox(Ref ref) {
  final prefs = ref.read(sharedPreferencesProvider);
  if (!prefs.hasValue) return '/inbox';
  final last = ref
      .read(uiStateStorageProvider)
      .readString(UiStateStorage.lastRouteKey);
  if (last == null || last.isEmpty) return '/inbox';
  if (last == '/' || last == '/login' || last == '/setup') return '/inbox';
  return last;
}

// ---------------------------------------------------------------------------
// Derived "currentX" providers — single source of truth is the URL.
// ---------------------------------------------------------------------------

/// Mirrors the router's [GoRouterDelegate.currentConfiguration] into
/// Riverpod so derived providers can `ref.watch` it and rebuild on
/// navigation. The delegate itself is a [ChangeNotifier]; this notifier
/// subscribes once and re-emits the current match list on every tick.
class _CurrentRouteNotifier extends Notifier<RouteMatchList> {
  @override
  RouteMatchList build() {
    final router = ref.watch(goRouterProvider);
    final delegate = router.routerDelegate;
    void onChange() {
      state = delegate.currentConfiguration;
    }

    delegate.addListener(onChange);
    ref.onDispose(() => delegate.removeListener(onChange));
    return delegate.currentConfiguration;
  }
}

final _currentRouteProvider =
    NotifierProvider<_CurrentRouteNotifier, RouteMatchList>(
  _CurrentRouteNotifier.new,
);

/// The active shell tab, derived from the current route's path prefix.
final currentTabProvider = Provider<ShellTab>((ref) {
  final path = ref.watch(_currentRouteProvider).uri.path;
  if (path.startsWith('/feed')) return ShellTab.feed;
  if (path.startsWith('/chat')) return ShellTab.chat;
  return ShellTab.inbox;
});

/// The currently selected tag slug path (from `/feed/t/<slug>/<slug>/.../...`),
/// or null. Returns the list of slug segments in root-to-leaf order.
final currentTagPathProvider = Provider<List<String>?>((ref) {
  final raw = ref.watch(_currentRouteProvider).pathParameters['tagPath'];
  if (raw == null || raw.isEmpty) return null;
  return raw.split('/');
});

/// Joins a slug path back into the URL form used by [GoRouter].
String tagPathToUrl(List<String> path) => path.join('/');

/// Compatibility shim: code that hasn't yet been migrated to use the
/// resolved-tag entity reads this provider. It returns the same string
/// the URL carries (full slash-separated slug path), which post-list and
/// tree-pane code use as an opaque selection token. Once a tag resolution
/// layer is wired up, callers that need the entity's int64 id should
/// switch to a `resolvedTagProvider`-derived provider instead.
final currentTagIdProvider = Provider<String?>((ref) {
  final path = ref.watch(currentTagPathProvider);
  if (path == null) return null;
  return tagPathToUrl(path);
});

/// The currently open post id (from `/feed[/t/...]/p/:postId`), or null.
final currentPostIdProvider = Provider<String?>((ref) {
  return ref.watch(_currentRouteProvider).pathParameters['postId'];
});

/// The currently selected chat room id (from `/chat/r/:roomId`), or null.
final currentRoomIdProvider = Provider<String?>((ref) {
  return ref.watch(_currentRouteProvider).pathParameters['roomId'];
});

/// Splash shown while prefs / auth / server-config are still hydrating.
/// Identical in intent to the `_Splash` widget that used to live in
/// `AuthGate` before this migration; routed here so the rest of the
/// app shell never builds with hot-cold state.
class _Splash extends StatelessWidget {
  const _Splash();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

class _NotFoundScreen extends StatelessWidget {
  const _NotFoundScreen({required this.uri});

  final Uri uri;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Page not found')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'No route matched',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                uri.toString(),
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => context.go('/inbox'),
                child: const Text('Go home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
