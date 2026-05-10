import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/auth_controller.dart';
import '../../core/selection.dart';
import '../chat/chat_pane.dart';
import '../feed/post_list_pane.dart';
import '../feed/tag_tree_pane.dart';
import '../notifications/notifications_button.dart';
import '../palette/command_palette_overlay.dart';
import 'outbox_indicator.dart';
import '../post_detail/post_detail_pane.dart';
import '../impersonation/impersonation_banner.dart';

/// Breakpoint for switching between mobile single-pane stack and the
/// desktop/web three-pane layout. 720dp is roughly a tablet edge.
const _wideBreakpoint = 720.0;

class ThreePaneShell extends ConsumerWidget {
  const ThreePaneShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommandPaletteOverlay(
      child: Scaffold(
        appBar: const _PulseAppBar(),
        body: Column(
          children: const [
            ImpersonationBanner(),
            Expanded(child: _ResponsiveBody()),
          ],
        ),
      ),
    );
  }
}

class _PulseAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const _PulseAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: const Text('Pulse'),
      actions: [
        const OutboxIndicator(),
        const NotificationsButton(),
        IconButton(
          tooltip: 'Sign out',
          onPressed: () => ref.read(authControllerProvider.notifier).logout(),
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }
}

class _ResponsiveBody extends ConsumerWidget {
  const _ResponsiveBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= _wideBreakpoint) {
          return const _WideLayout();
        }
        return const _NarrowLayout();
      },
    );
  }
}

/// Three-pane layout for tablet/desktop/web. Mobile-narrow falls back
/// to a stack-of-pages model in [_NarrowLayout].
class _WideLayout extends ConsumerWidget {
  const _WideLayout();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        SizedBox(
          width: 260,
          child: Material(
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            child: const TagTreePane(),
          ),
        ),
        const VerticalDivider(width: 1),
        const SizedBox(
          width: 320,
          child: PostListPane(),
        ),
        const VerticalDivider(width: 1),
        const Expanded(child: PostDetailPane()),
      ],
    );
  }
}

/// Mobile single-pane stack — the user navigates tag → list → detail
/// linearly. We model this as a switching child rather than a
/// Navigator stack to keep the app shell flat; back navigation pops
/// through providers.
class _NarrowLayout extends ConsumerWidget {
  const _NarrowLayout();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTag = ref.watch(selectedTagIdProvider);
    final selectedPost = ref.watch(selectedPostIdProvider);
    if (selectedPost != null) {
      return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) {
            ref.read(selectedPostIdProvider.notifier).state = null;
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () =>
                  ref.read(selectedPostIdProvider.notifier).state = null,
            ),
            title: const Text('Post'),
          ),
          body: const PostDetailPane(),
        ),
      );
    }
    if (selectedTag != null) {
      return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) {
            ref.read(selectedTagIdProvider.notifier).state = null;
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () =>
                  ref.read(selectedTagIdProvider.notifier).state = null,
            ),
            title: const Text('Posts'),
          ),
          body: const PostListPane(),
        ),
      );
    }
    return const TagTreePane();
  }
}

/// ChatShell mirrors ThreePaneShell for the chat tab. Kept separate so
/// the M5.A feed half can ship without entangling chat code.
class ChatShell extends ConsumerWidget {
  const ChatShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          const NotificationsButton(),
          IconButton(
            tooltip: 'Sign out',
            onPressed: () =>
                ref.read(authControllerProvider.notifier).logout(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: const [
          ImpersonationBanner(),
          Expanded(child: ChatPane()),
        ],
      ),
    );
  }
}
