import 'package:flutter_riverpod/legacy.dart';

/// selectedTagIdProvider holds the id of the tag the user is currently
/// browsing. Null means "no tag selected" — the list pane shows a
/// placeholder. Persisting selection across restarts is M5.B work.
final selectedTagIdProvider = StateProvider<String?>((ref) => null);

/// selectedPostIdProvider holds the id of the post the user has open in
/// the detail pane. Null means "no post selected" — the detail pane
/// shows a placeholder.
final selectedPostIdProvider = StateProvider<String?>((ref) => null);

/// selectedRoomIdProvider for chat. Null = no room selected.
final selectedRoomIdProvider = StateProvider<String?>((ref) => null);
