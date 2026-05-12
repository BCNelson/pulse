/// Server configuration: the normalized base URL the app talks to,
/// plus the derived GraphQL HTTP and WebSocket endpoint URLs.
///
/// The base URL is always in explicit `<scheme>://<host>:<port>` form —
/// no implicit ports, no path, no query. That keeps storage round-trips
/// stable (a value read from disk equals the value just written) and
/// makes the WS URL trivial to derive.
class ServerConfig {
  const ServerConfig({
    required this.baseUrl,
    required this.graphqlHttpUrl,
    required this.graphqlWsUrl,
  });

  final String baseUrl;
  final String graphqlHttpUrl;
  final String graphqlWsUrl;

  @override
  bool operator ==(Object other) =>
      other is ServerConfig &&
      other.baseUrl == baseUrl &&
      other.graphqlHttpUrl == graphqlHttpUrl &&
      other.graphqlWsUrl == graphqlWsUrl;

  @override
  int get hashCode => Object.hash(baseUrl, graphqlHttpUrl, graphqlWsUrl);

  @override
  String toString() => 'ServerConfig($baseUrl)';
}

/// Parses raw user input (or a build-time env var) into a [ServerConfig].
///
/// Accepts forms like `https://example.com`, `example.com:8080`, or a
/// bare `example.com` (defaults to https). Always returns a base URL
/// with an explicit port — `:443` for https, `:80` for http when the
/// user didn't supply one.
///
/// Throws [FormatException] on empty input, unparseable URIs, empty
/// hosts, or non-http(s) schemes.
ServerConfig parseServerUrl(String input) {
  final trimmed = input.trim();
  if (trimmed.isEmpty) {
    throw const FormatException('server URL cannot be empty');
  }

  final withScheme =
      trimmed.contains('://') ? trimmed : 'https://$trimmed';

  final uri = Uri.tryParse(withScheme);
  if (uri == null) {
    throw FormatException('not a valid URL: $input');
  }
  final scheme = uri.scheme.toLowerCase();
  if (scheme != 'http' && scheme != 'https') {
    throw FormatException('scheme must be http or https: $input');
  }
  if (uri.host.isEmpty) {
    throw FormatException('missing host: $input');
  }

  // hasPort is false when the source had no explicit ":port" — fill in
  // the scheme default so the stored base URL is always in the explicit
  // proto://host:port form callers expect.
  final port = uri.hasPort ? uri.port : (scheme == 'https' ? 443 : 80);

  final base = '$scheme://${uri.host}:$port';
  final wsScheme = scheme == 'https' ? 'wss' : 'ws';
  return ServerConfig(
    baseUrl: base,
    graphqlHttpUrl: '$base/graphql',
    graphqlWsUrl: '$wsScheme://${uri.host}:$port/graphql',
  );
}
