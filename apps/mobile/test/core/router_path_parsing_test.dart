import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

/// These tests exercise the go_router pattern shapes from
/// lib/core/router.dart against the live go_router matcher. They guard
/// the three URL shapes:
///   `/feed/t/<slugs>`           -> tag-only
///   `/feed/p/<id>`              -> post-only
///   `/feed/t/<slugs>/p/<id>`    -> post under tag
const _idRe = r'[0-9A-HJ-NP-TV-Za-hj-np-tv-zIiLlOo]{12}';

GoRouter _buildRouter() => GoRouter(
      initialLocation: '/feed',
      routes: [
        GoRoute(
          path: '/feed',
          builder: (_, __) => const _Stub(),
          routes: [
            GoRoute(
              path: 't/:tagPath(.+)/p/:postId($_idRe)',
              builder: (_, __) => const _Stub(),
            ),
            GoRoute(
              path: 'p/:postId($_idRe)',
              builder: (_, __) => const _Stub(),
            ),
            GoRoute(
              path: r't/:tagPath(.+)',
              builder: (_, __) => const _Stub(),
            ),
          ],
        ),
      ],
    );

class _Stub extends StatelessWidget {
  const _Stub();
  @override
  Widget build(BuildContext context) => const Placeholder();
}

Future<Map<String, String>> _navigateAndReadParams(
    WidgetTester tester, String location) async {
  final router = _buildRouter();
  await tester.pumpWidget(MaterialApp.router(routerConfig: router));
  router.go(location);
  await tester.pumpAndSettle();
  return Map<String, String>.from(
      router.routerDelegate.currentConfiguration.pathParameters);
}

void main() {
  testWidgets('matches /feed/t/<single-slug>', (tester) async {
    final p = await _navigateAndReadParams(tester, '/feed/t/programming');
    expect(p['tagPath'], 'programming');
    expect(p['postId'], isNull);
  });

  testWidgets('matches /feed/t/<multi-segment-slug>', (tester) async {
    final p =
        await _navigateAndReadParams(tester, '/feed/t/programming/rust/embedded');
    expect(p['tagPath'], 'programming/rust/embedded');
  });

  testWidgets('matches /feed/p/<12-char-id>', (tester) async {
    final p = await _navigateAndReadParams(tester, '/feed/p/P1XB7NE7X7RV');
    expect(p['postId'], 'P1XB7NE7X7RV');
    expect(p['tagPath'], isNull);
  });

  testWidgets('matches /feed/t/<slugs>/p/<12-char-id>', (tester) async {
    final p = await _navigateAndReadParams(
        tester, '/feed/t/a/b/c/p/P1XB7NE7X7RV');
    expect(p['tagPath'], 'a/b/c');
    expect(p['postId'], 'P1XB7NE7X7RV');
  });

  testWidgets('lowercase body in id slot still routes (case-insensitive)',
      (tester) async {
    final p = await _navigateAndReadParams(tester, '/feed/p/p1xb7ne7x7rv');
    expect(p['postId'], 'p1xb7ne7x7rv');
  });

  testWidgets('tag slug literally "p" parses as tag, not post', (tester) async {
    final p = await _navigateAndReadParams(tester, '/feed/t/p');
    expect(p['tagPath'], 'p');
    expect(p['postId'], isNull);
  });
}
