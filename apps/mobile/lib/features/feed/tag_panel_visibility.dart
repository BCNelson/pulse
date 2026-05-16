import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Whether the tag tree pane is visible in the wide feed layout.
/// Toggled by re-tapping the FEED entry in the side nav rail when the
/// URL is already at `/feed` exactly. Lives outside the widget tree so
/// it survives `FeedScreen` remounts caused by sub-route navigation.
class TagPanelVisibilityNotifier extends Notifier<bool> {
  @override
  bool build() => true;

  void toggle() => state = !state;
}

final tagPanelVisibleProvider =
    NotifierProvider<TagPanelVisibilityNotifier, bool>(
  TagPanelVisibilityNotifier.new,
);
