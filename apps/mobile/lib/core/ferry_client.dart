import 'package:ferry/ferry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:gql_websocket_link/gql_websocket_link.dart';

import 'auth_controller.dart';

/// Endpoint configuration. Override at build time with --dart-define so
/// the same artifact can ship to local dev and production.
const graphQLEndpoint = String.fromEnvironment(
  'GRAPHQL_ENDPOINT',
  defaultValue: 'http://127.0.0.1:8080/graphql',
);

const graphQLWsEndpoint = String.fromEnvironment(
  'GRAPHQL_WS_ENDPOINT',
  defaultValue: 'ws://127.0.0.1:8080/graphql',
);

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
/// over HTTP. The client lives for the app's lifetime; auth changes
/// flow through AuthLink without recreating it.
final ferryClientProvider = Provider<Client>((ref) {
  final authNotifier = ref.read(authControllerProvider.notifier);

  final httpLink = HttpLink(graphQLEndpoint);
  final wsLink = WebSocketLink(
    graphQLWsEndpoint,
    initialPayload: () {
      final token = authNotifier.token;
      return token == null ? <String, dynamic>{} : {'authorization': 'Bearer $token'};
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
