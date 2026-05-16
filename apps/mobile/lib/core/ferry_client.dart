import 'dart:async';

import 'package:ferry/ferry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:gql_websocket_link/gql_websocket_link.dart';

import '../graphql/cache_handlers.dart';
import 'auth_controller.dart';
import 'server_config_controller.dart';

/// RetryLink re-issues a request on transient failures. The retry
/// budget depends on the failure mode:
///
///   * **4xx response** (auth denied, validation, not found) → no retry.
///     Retrying won't change the outcome.
///   * **5xx response, network error, or response parse failure** →
///     retry up to [maxAttempts] times with exponential backoff capped
///     at [maxDelay]. Covers server hiccups, momentary connectivity
///     drops, mid-flight TLS resets, etc.
///
/// Subscriptions are passed through unchanged — their stream is
/// long-lived and managed by gql_websocket_link.
class RetryLink extends Link {
  RetryLink({
    this.maxAttempts = 6,
    this.baseDelay = const Duration(milliseconds: 250),
    this.maxDelay = const Duration(seconds: 5),
  });

  final int maxAttempts;
  final Duration baseDelay;
  final Duration maxDelay;

  @override
  Stream<Response> request(Request request, [NextLink? forward]) async* {
    final next = forward;
    if (next == null) {
      throw StateError('RetryLink must be composed with a forwarding link');
    }
    if (request.operation.getOperationType() == OperationType.subscription) {
      yield* next(request);
      return;
    }
    var attempt = 0;
    while (true) {
      try {
        // `await for` is required here rather than `yield* next(request)`:
        // a stream error from `yield*` flows out of the outer stream
        // without ever entering the surrounding try-catch, so retries
        // would silently never run.
        await for (final response in next(request)) {
          yield response;
        }
        return;
      } on LinkException catch (e) {
        attempt += 1;
        final code = e is ServerException ? e.statusCode : null;
        final is4xx = code != null && code >= 400 && code < 500;
        if (is4xx || attempt >= maxAttempts) rethrow;
        var delay = baseDelay * (1 << (attempt - 1));
        if (delay > maxDelay) delay = maxDelay;
        await Future<void>.delayed(delay);
      }
    }
  }
}

/// AuthLink stamps Authorization: Bearer <token> onto every outbound
/// request when a token is present. The token comes from the Riverpod
/// auth controller via a callback so we don't have to rebuild the
/// client when login state changes.
class AuthLink extends Link {
  AuthLink(this._tokenLookup);

  final String? Function() _tokenLookup;

  @override
  Stream<Response> request(Request request, [NextLink? forward]) {
    final token = _tokenLookup();
    final next = forward;
    if (next == null) {
      throw StateError('AuthLink must be composed with a forwarding link');
    }
    if (token == null || token.isEmpty) {
      return next(request);
    }
    final updated = request.updateContextEntry<HttpLinkHeaders>(
      (entry) => HttpLinkHeaders(
        headers: <String, String>{
          ...?entry?.headers,
          'Authorization': 'Bearer $token',
        },
      ),
    );
    return next(updated);
  }
}

/// ferryClientProvider builds a ferry Client wired with auth + a split
/// link that routes subscriptions over WebSocket and everything else
/// over HTTP. The client is keyed to the configured server URL: when
/// the URL changes the provider rebuilds and the old client is
/// disposed via [ref.onDispose].
///
/// Callers must only read this after the server URL has been
/// configured (the AuthGate widget guards on that). Reading earlier
/// throws — that is a programmer error, not a runtime condition.
final ferryClientProvider = Provider<Client>((ref) {
  final cfgState = ref.watch(serverConfigControllerProvider);
  if (cfgState is! ServerConfigReady) {
    throw StateError(
      'ferryClientProvider read before server URL was configured',
    );
  }
  final cfg = cfgState.config;
  final authNotifier = ref.read(authControllerProvider.notifier);

  final httpLink = HttpLink(cfg.graphqlHttpUrl);
  final wsLink = WebSocketLink(
    cfg.graphqlWsUrl,
    initialPayload: () {
      final token = authNotifier.token;
      return token == null
          ? <String, dynamic>{}
          : {'authorization': 'Bearer $token'};
    },
  );
  final authLink = AuthLink(() => authNotifier.token);
  final retryLink = RetryLink();

  // Split: subscriptions over WS, queries/mutations over HTTP. Both
  // routes go through AuthLink first so headers stay consistent.
  // RetryLink sits on the HTTP path only — the WS link manages its own
  // reconnect / retry.
  final link = Link.split(
    (request) =>
        request.operation.getOperationType() == OperationType.subscription,
    Link.from([authLink, wsLink]),
    Link.from([authLink, retryLink, httpLink]),
  );

  final client = Client(
    link: link,
    updateCacheHandlers: pulseCacheHandlers,
  );
  ref.onDispose(client.dispose);
  return client;
});
