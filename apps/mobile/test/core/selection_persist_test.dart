import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/core/prefs_provider.dart';
import 'package:pulse/core/selection.dart';
import 'package:pulse/core/ui_state_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('selection persistence', () {
    test('restores previously-saved selectedPostId from prefs', () async {
      SharedPreferences.setMockInitialValues({
        UiStateStorage.selectedPostIdKey: 'post-42',
      });
      final container = ProviderContainer();
      addTearDown(container.dispose);
      // Resolve prefs future before reading the synchronous notifier.
      await container.read(sharedPreferencesProvider.future);
      expect(container.read(selectedPostIdProvider), 'post-42');
    });

    test('set() writes through to prefs', () async {
      SharedPreferences.setMockInitialValues({});
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final prefs = await container.read(sharedPreferencesProvider.future);

      container.read(selectedPostIdProvider.notifier).set('post-7');
      // writeString is async; pump the event loop so the write completes.
      await Future<void>.delayed(Duration.zero);
      expect(prefs.getString(UiStateStorage.selectedPostIdKey), 'post-7');

      container.read(selectedPostIdProvider.notifier).set(null);
      await Future<void>.delayed(Duration.zero);
      expect(prefs.getString(UiStateStorage.selectedPostIdKey), isNull);
    });

    test('reply target persists per post', () async {
      SharedPreferences.setMockInitialValues({
        UiStateStorage.selectedPostIdKey: 'post-a',
      });
      final container = ProviderContainer();
      addTearDown(container.dispose);
      await container.read(sharedPreferencesProvider.future);

      container.read(replyingToCommentProvider.notifier).set(
            const ReplyTarget(
              commentId: 'c-1',
              authorDisplayName: 'alice',
              body: 'hi',
            ),
          );
      await Future<void>.delayed(Duration.zero);

      // Switch posts. New post should have no saved reply target.
      container.read(selectedPostIdProvider.notifier).set('post-b');
      expect(container.read(replyingToCommentProvider), isNull);

      // Switch back. Should restore the earlier target.
      container.read(selectedPostIdProvider.notifier).set('post-a');
      final restored = container.read(replyingToCommentProvider);
      expect(restored, isNotNull);
      expect(restored!.commentId, 'c-1');
      expect(restored.authorDisplayName, 'alice');
    });
  });
}
