import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/core/router.dart';
import 'package:pulse/features/chat/chat_pane.dart';

import '../_widget_test_helpers.dart';

void main() {
  testWidgets('ChatPane shows the room-list placeholder when no room is '
      'selected', (tester) async {
    await pumpScreen(
      tester,
      const ChatPane(),
      overrides: [
        currentRoomIdProvider.overrideWithValue(null),
      ],
    );

    expect(tester.takeException(), isNull);
    expect(find.text('Chat'), findsOneWidget);
    // M5.B+ placeholder text identifies the room-list pane.
    expect(
      find.textContaining('Room list lands in M5.B+'),
      findsOneWidget,
    );
  });
}
