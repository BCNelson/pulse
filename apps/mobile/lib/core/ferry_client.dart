import 'package:ferry/ferry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:gql_websocket_link/gql_websocket_link.dart';

import 'auth_controller.dart';
import 'server_config_controller.dart';

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

  // Split: subscriptions over WS, queries/mutations over HTTP. Both
  // routes go through AuthLink first so headers stay consistent.
  final link = Link.split(
    (request) =>
        request.operation.getOperationType() == OperationType.subscription,
    Link.from([authLink, wsLink]),
    Link.from([authLink, httpLink]),
  );

  final client = Client(link: link);
  ref.onDispose(client.dispose);
  return client;
});
