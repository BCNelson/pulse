import 'package:ferry/ferry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ferry_client.dart';
import '../../graphql/operations/__generated__/posts.req.gql.dart';
import 'cached_tag_feed_provider.dart';
import 'post_changed_listener.dart';

/// Per-tag feed settings surfaced by the last server response, plus the
/// tag's hasChildren flag (so the UI knows whether the toggle is even
/// meaningful). `includeSubTags` is null until the first fetch lands.
class FeedSettingsState {
  const FeedSettingsState({this.includeSubTags, this.hasChildren = false});

  final bool? includeSubTags;
  final bool hasChildren;

  FeedSettingsState copyWith({bool? includeSubTags, bool? hasChildren}) =>
      FeedSettingsState(
        includeSubTags: includeSubTags ?? this.includeSubTags,
        hasChildren: hasChildren ?? this.hasChildren,
      );
}

class FeedSettingsController extends Notifier<FeedSettingsState> {
  FeedSettingsController(this.tagId);

  /// The tag (typed Crockford id or slug path) this controller is bound
  /// to. Riverpod's family builder passes it via the constructor.
  final String tagId;

  @override
  FeedSettingsState build() => const FeedSettingsState();

  /// Called by [cachedTagFeedProvider] after a successful fetch so the
  /// UI reflects whatever the server has saved.
  void hydrate({required bool includeSubTags, required bool hasChildren}) {
    state = state.copyWith(
      includeSubTags: includeSubTags,
      hasChildren: hasChildren,
    );
  }

  /// Flip the saved pref on the server, then invalidate the feed and
  /// realtime subscription so they reconnect with the new server-side
  /// state (the server reads myFeedSettings when no override is passed,
  /// so the next fetch picks up the new value automatically).
  Future<void> setIncludeSubTags(bool value) async {
    final prev = state.includeSubTags;
    state = state.copyWith(includeSubTags: value);
    final client = ref.read(ferryClientProvider);
    final req = GSetTagFeedSettingsReq(
      (b) => b
        ..vars.input.tagId = tagId
        ..vars.input.includeDescendants = value
        ..fetchPolicy = FetchPolicy.NoCache,
    );
    try {
      final resp = await client.request(req).first;
      if (resp.hasErrors) {
        state = state.copyWith(includeSubTags: prev);
        return;
      }
      ref.invalidate(cachedTagFeedProvider(tagId));
      ref.invalidate(postChangedListenerProvider(tagId));
    } catch (_) {
      state = state.copyWith(includeSubTags: prev);
    }
  }
}

final feedSettingsProvider = NotifierProvider.autoDispose
    .family<FeedSettingsController, FeedSettingsState, String>(
  FeedSettingsController.new,
);
