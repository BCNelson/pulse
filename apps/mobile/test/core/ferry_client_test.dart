import 'package:flutter_test/flutter_test.dart';
// gql is a transitive dep via ferry; the generated GraphQL code under
// lib/graphql/ uses it the same way.
// ignore: depend_on_referenced_packages
import 'package:gql/ast.dart';
// ignore: depend_on_referenced_packages
import 'package:gql/language.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:gql_link/gql_link.dart';
import 'package:pulse/core/ferry_client.dart';

void main() {
  group('RetryLink', () {
    test('passes a successful response through with no retries', () async {
      final next = _ScriptedLink([_okResponse()]);
      final link = RetryLink(baseDelay: Duration.zero, maxDelay: Duration.zero);

      final responses = await link
          .request(_queryRequest(), next.request)
          .toList();

      expect(responses.length, 1);
      expect(next.requestCount, 1);
    });

    test('retries on a 5xx ServerException until success', () async {
      final next = _ScriptedLink([
        _serverError(503),
        _serverError(502),
        _okResponse(),
      ]);
      final link = RetryLink(
        maxAttempts: 5,
        baseDelay: Duration.zero,
        maxDelay: Duration.zero,
      );

      final responses = await link
          .request(_queryRequest(), next.request)
          .toList();

      expect(responses.length, 1);
      expect(next.requestCount, 3);
    });

    test('does not retry a 4xx ServerException', () async {
      final next = _ScriptedLink([_serverError(401)]);
      final link = RetryLink(baseDelay: Duration.zero, maxDelay: Duration.zero);

      await expectLater(
        link.request(_queryRequest(), next.request).toList(),
        throwsA(isA<ServerException>()),
      );
      expect(next.requestCount, 1);
    });

    test('gives up after maxAttempts even when 5xx persists', () async {
      final next = _ScriptedLink([
        _serverError(503),
        _serverError(503),
        _serverError(503),
      ]);
      final link = RetryLink(
        maxAttempts: 3,
        baseDelay: Duration.zero,
        maxDelay: Duration.zero,
      );

      await expectLater(
        link.request(_queryRequest(), next.request).toList(),
        throwsA(isA<ServerException>()),
      );
      expect(next.requestCount, 3);
    });

    test('subscriptions are passed through unchanged', () async {
      // Even if the forward emits a 5xx-ish exception, a subscription
      // shouldn't be re-invoked by RetryLink — the WS link owns reconnect.
      final next = _ScriptedLink([_serverError(503)]);
      final link = RetryLink(baseDelay: Duration.zero, maxDelay: Duration.zero);

      await expectLater(
        link.request(_subscriptionRequest(), next.request).toList(),
        throwsA(isA<ServerException>()),
      );
      expect(next.requestCount, 1);
    });
  });

  group('AuthLink', () {
    test('stamps Authorization: Bearer <token> when a token is present',
        () async {
      String? capturedAuth;
      final next = _CapturingLink((req) {
        capturedAuth = req
            .context
            .entry<HttpLinkHeaders>()
            ?.headers['Authorization'];
        return _okResponse();
      });
      final link = AuthLink(() => 'tkn');

      await link.request(_queryRequest(), next.request).toList();

      expect(capturedAuth, 'Bearer tkn');
    });

    test('does not add a header when the token is null', () async {
      Map<String, String>? captured;
      final next = _CapturingLink((req) {
        captured = req.context.entry<HttpLinkHeaders>()?.headers;
        return _okResponse();
      });
      final link = AuthLink(() => null);

      await link.request(_queryRequest(), next.request).toList();

      expect(captured ?? <String, String>{}, isNot(contains('Authorization')));
    });

    test('does not add a header when the token is empty', () async {
      Map<String, String>? captured;
      final next = _CapturingLink((req) {
        captured = req.context.entry<HttpLinkHeaders>()?.headers;
        return _okResponse();
      });
      final link = AuthLink(() => '');

      await link.request(_queryRequest(), next.request).toList();

      expect(captured ?? <String, String>{}, isNot(contains('Authorization')));
    });
  });
}

Request _queryRequest() => Request(
      operation: Operation(document: _queryDoc),
      variables: const {},
    );

Request _subscriptionRequest() => Request(
      operation: Operation(document: _subscriptionDoc),
      variables: const {},
    );

final DocumentNode _queryDoc = parseString('query Q { viewer { id } }');
final DocumentNode _subscriptionDoc =
    parseString('subscription S { messageAdded { id } }');

Response _okResponse() => Response(
      data: const {'viewer': {'id': '1'}},
      response: const {},
    );

ServerException _serverError(int code) => ServerException(
      statusCode: code,
      originalException: null,
      parsedResponse: Response(
        errors: const [GraphQLError(message: 'http error')],
        response: const {},
      ),
    );

class _ScriptedLink extends Link {
  _ScriptedLink(this._script);

  final List<Object> _script; // Response or ServerException
  int requestCount = 0;

  @override
  Stream<Response> request(Request request, [NextLink? forward]) async* {
    final idx = requestCount;
    requestCount += 1;
    final next = _script[idx];
    if (next is ServerException) {
      throw next;
    }
    yield next as Response;
  }
}

class _CapturingLink extends Link {
  _CapturingLink(this._handler);

  final Response Function(Request) _handler;

  @override
  Stream<Response> request(Request request, [NextLink? forward]) {
    return Stream<Response>.value(_handler(request));
  }
}
