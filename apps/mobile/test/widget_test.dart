import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/core/auth_controller.dart';
import 'package:pulse/core/prefs_provider.dart';
import 'package:pulse/core/server_config_controller.dart';
import 'package:pulse/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('PulseApp does not make the whole app selectable',
      (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authControllerProvider.overrideWith(_TestAuthController.new),
          serverConfigControllerProvider.overrideWith(
            _TestServerConfigController.new,
          ),
          sharedPreferencesProvider.overrideWith((ref) async => prefs),
        ],
        child: const PulseApp(),
      ),
    );

    // Settle through: prefs.isLoading -> /_loading splash, prefs resolves,
    // redirect re-fires -> /setup -> ServerUrlScreen.
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('connect'), findsOneWidget);
    expect(find.byType(SelectionArea), findsNothing);
  });
}

class _TestAuthController extends AuthController {
  @override
  AuthState build() => const AuthSignedOut();
}

class _TestServerConfigController extends ServerConfigController {
  @override
  ServerConfigState build() => const ServerConfigMissing();
}
