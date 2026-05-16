import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/design/themes.dart';
// ignore: depend_on_referenced_packages — transitive via flutter_riverpod
import 'package:riverpod/misc.dart' show Override;

/// Pumps `screen` inside a ProviderScope + MaterialApp with the bone
/// theme so `context.tokens` resolves. Use `overrides` to inject fake
/// notifiers / values for the providers `screen` watches. Sized to a
/// realistic phone window by default; pass `size` for wide-layout tests.
Future<void> pumpScreen(
  WidgetTester tester,
  Widget screen, {
  List<Override> overrides = const [],
  Size size = const Size(390, 844),
}) async {
  await tester.binding.setSurfaceSize(size);
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    ProviderScope(
      overrides: overrides,
      child: MaterialApp(
        theme: pulseTheme(PulseThemeKey.bone),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: screen,
      ),
    ),
  );
  // Pump one extra frame so providers that schedule work in `build`
  // (e.g. _restore() futures) get their first tick — but don't
  // pumpAndSettle, which deadlocks on never-emitting subscription
  // streams that some screens hold.
  await tester.pump();
}

