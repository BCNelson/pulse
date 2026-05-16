import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/prefs_provider.dart';
import '../../core/ui_state_storage.dart';

const double feedListDefaultWidth = 320;
const double feedListMinWidth = 240;
const double feedDetailMinWidth = 320;

/// Persisted width (in dp) of the post-list pane in the wide feed
/// layout, when a post detail is open. The splitter widget clamps to
/// the live available width before calling [set], so values written
/// here have already been bounded by [feedListMinWidth] and
/// `available - feedDetailMinWidth`.
class FeedListWidthNotifier extends Notifier<double> {
  @override
  double build() {
    final stored =
        ref.read(uiStateStorageProvider).readDouble(UiStateStorage.feedListWidthKey);
    return stored ?? feedListDefaultWidth;
  }

  void set(double width) {
    if (width == state) return;
    state = width;
    ref
        .read(uiStateStorageProvider)
        .writeDouble(UiStateStorage.feedListWidthKey, width);
  }
}

final feedListWidthProvider =
    NotifierProvider<FeedListWidthNotifier, double>(FeedListWidthNotifier.new);
