import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/core/prefs_provider.dart';
import 'package:pulse/core/router.dart';
import 'package:pulse/core/selection.dart';
import 'package:pulse/core/ui_state_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Lets the test drive `currentPostIdProvider` independently of a real
/// GoRouter. `replyingToCommentProvider` watches `currentPostIdProvider`,
/// so toggling this is the test's lever for "switch to a different post".
final _testPostIdProvider = StateProvider<String?>((ref) => null);

ProviderContainer _container({String? initialPostId}) {
  final container = ProviderContainer(
    overrides: [
      currentPostIdProvider.overrideWith(
        (ref) => ref.watch(_testPostIdProvider),
      ),
    ],
  );
  addTearDown(container.dispose);
  if (initialPostId != null) {
    container.read(_testPostIdProvider.notifier).state = initialPostId;
  }
  return container;
}

void main() {
  group('replyingToCommentProvider', () {
    test('restores previously-saved reply target from prefs', () async {
      const target = ReplyTarget(
        commentId: 'c-1',
        authorDisplayName: 'alice',
        body: 'hi',
      );
      SharedPreferences.setMockInitialValues({
        UiStateStorage.replyTargetKey('post-42'): jsonEncode(target.toJson()),
      });
      final container = _container(initialPostId: 'post-42');
      await container.read(sharedPreferencesProvider.future);

      final restored = container.read(replyingToCommentProvider);
      expect(restored, isNotNull);
      expect(restored!.commentId, 'c-1');
      expect(restored.authorDisplayName, 'alice');
      expect(restored.body, 'hi');
    });

    test('set() writes through to prefs keyed by current post id',
        () async {
      SharedPreferences.setMockInitialValues({});
      final container = _container(initialPostId: 'post-7');
      final prefs = await container.read(sharedPreferencesProvider.future);

      container.read(replyingToCommentProvider.notifier).set(
            const ReplyTarget(
              commentId: 'c-9',
              authorDisplayName: 'bob',
            ),
          );
      await Future<void>.delayed(Duration.zero);

      final stored = prefs.getString(UiStateStorage.replyTargetKey('post-7'));
      expect(stored, isNotNull);
      final decoded = jsonDecode(stored!) as Map<String, dynamic>;
      expect(decoded['commentId'], 'c-9');
      expect(decoded['authorDisplayName'], 'bob');
    });

    test('clearing set(null) removes the prefs entry', () async {
      const initial = ReplyTarget(
        commentId: 'c-2',
        authorDisplayName: 'carol',
      );
      SharedPreferences.setMockInitialValues({
        UiStateStorage.replyTargetKey('post-1'): jsonEncode(initial.toJson()),
      });
      final container = _container(initialPostId: 'post-1');
      final prefs = await container.read(sharedPreferencesProvider.future);
      // Sanity: the saved target should be visible before we clear.
      expect(container.read(replyingToCommentProvider), isNotNull);

      container.read(replyingToCommentProvider.notifier).set(null);
      await Future<void>.delayed(Duration.zero);

      expect(prefs.getString(UiStateStorage.replyTargetKey('post-1')), isNull);
    });

    test('reply target attaches to the post, not the global session',
        () async {
      const target = ReplyTarget(
        commentId: 'c-3',
        authorDisplayName: 'dan',
      );
      SharedPreferences.setMockInitialValues({
        UiStateStorage.replyTargetKey('post-a'): jsonEncode(target.toJson()),
      });
      final container = _container(initialPostId: 'post-a');
      await container.read(sharedPreferencesProvider.future);

      // post-a has a saved reply target.
      expect(container.read(replyingToCommentProvider), isNotNull);

      // Switch to post-b — no reply state should leak across.
      container.read(_testPostIdProvider.notifier).state = 'post-b';
      expect(container.read(replyingToCommentProvider), isNull);

      // Back to post-a — should restore from prefs.
      container.read(_testPostIdProvider.notifier).state = 'post-a';
      final restored = container.read(replyingToCommentProvider);
      expect(restored, isNotNull);
      expect(restored!.commentId, 'c-3');
    });
  });
}
