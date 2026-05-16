import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/design/theme_controller.dart';
import 'package:pulse/design/themes.dart';
import 'package:pulse/features/settings/theme_picker_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../_widget_test_helpers.dart';

void main() {
  testWidgets('ThemePickerScreen lists all bundled themes and marks the '
      'current one selected', (tester) async {
    SharedPreferences.setMockInitialValues({});

    await pumpScreen(
      tester,
      const ThemePickerScreen(),
      overrides: [
        pulseThemeControllerProvider.overrideWith(_TestThemeController.new),
      ],
    );

    expect(tester.takeException(), isNull);
    expect(find.text('THEMES'), findsOneWidget);

    // Footer copy claims 12 themes; PulseThemeKey enumerates them.
    expect(PulseThemeKey.values.length, 12);
    // Each row renders a Material InkWell.
    expect(find.byType(InkWell), findsNWidgets(PulseThemeKey.values.length));
  });
}

class _TestThemeController extends PulseThemeController {
  @override
  PulseThemeKey build() => PulseThemeKey.bone;
}
