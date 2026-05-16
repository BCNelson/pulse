import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/core/auth_controller.dart';
import 'package:pulse/features/auth/login_screen.dart';

import '../_widget_test_helpers.dart';

void main() {
  testWidgets('LoginScreen renders email + password fields and Sign in button',
      (tester) async {
    await pumpScreen(
      tester,
      const LoginScreen(),
      overrides: [
        authControllerProvider.overrideWith(_TestAuth.new),
      ],
    );

    expect(tester.takeException(), isNull);
    expect(find.text('sign in'), findsOneWidget);
    expect(find.text('EMAIL'), findsOneWidget);
    expect(find.text('PASSWORD'), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
  });

  testWidgets('LoginScreen shows the lastError from AuthSignedOut after a '
      'failed submit', (tester) async {
    await pumpScreen(
      tester,
      const LoginScreen(),
      overrides: [
        authControllerProvider.overrideWith(
          () => _TestAuth(initial: const AuthSignedOut(lastError: 'bad creds')),
        ),
      ],
    );

    // Fill the form so client-side validation passes, then submit.
    await tester.enterText(find.byType(TextFormField).at(0), 'a@x.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'pw');
    await tester.tap(find.text('Sign in'));
    await tester.pump();

    expect(find.text('bad creds'), findsOneWidget);
  });
}

class _TestAuth extends AuthController {
  _TestAuth({AuthState? initial}) : _initial = initial;

  final AuthState? _initial;

  @override
  AuthState build() => _initial ?? const AuthSignedOut();

  @override
  Future<bool> login(String email, String password) async {
    // Always fails; preserves the lastError that the test seeded.
    state = AuthSignedOut(
      lastError: state is AuthSignedOut
          ? (state as AuthSignedOut).lastError ?? 'login failed'
          : 'login failed',
    );
    return false;
  }
}
