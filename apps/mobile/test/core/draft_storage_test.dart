import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/core/draft_storage.dart';
import 'package:pulse/core/ui_state_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('DraftStorage', () {
    late DraftStorage drafts;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      drafts = DraftStorage(UiStateStorage(prefs));
    });

    test('round-trips a root-level draft', () async {
      expect(drafts.read('post1', null), isNull);
      await drafts.write('post1', null, 'hello');
      expect(drafts.read('post1', null), 'hello');
    });

    test('keeps reply-target and root drafts on the same post separate',
        () async {
      await drafts.write('post1', null, 'top-level');
      await drafts.write('post1', 'comment1', 'reply text');
      expect(drafts.read('post1', null), 'top-level');
      expect(drafts.read('post1', 'comment1'), 'reply text');
    });

    test('does not leak across posts', () async {
      await drafts.write('post1', null, 'a');
      expect(drafts.read('post2', null), isNull);
    });

    test('clear removes a single draft', () async {
      await drafts.write('post1', null, 'keep');
      await drafts.write('post1', 'comment1', 'discard');
      await drafts.clear('post1', 'comment1');
      expect(drafts.read('post1', null), 'keep');
      expect(drafts.read('post1', 'comment1'), isNull);
    });

    test('writing empty string clears the entry', () async {
      await drafts.write('post1', null, 'draft');
      await drafts.write('post1', null, '');
      expect(drafts.read('post1', null), isNull);
    });
  });
}
