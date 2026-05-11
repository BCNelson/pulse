import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/auth_controller.dart';
import '../../core/selection.dart';
import '../../design/atoms/pulse_status_bar.dart';
import '../../design/tokens.dart';
import '../../design/typography.dart';
import '../chat/chat_pane.dart';
import '../feed/post_list_pane.dart';
import '../feed/tag_tree_pane.dart';
import '../inbox/inbox_screen.dart';
import '../palette/command_palette_overlay.dart';
import '../post_detail/post_detail_pane.dart';
import '../impersonation/impersonation_banner.dart';
import '../settings/theme_picker_screen.dart';
import 'outbox_indicator.dart';

/// Breakpoint for switching between mobile single-pane stack and the
/// desktop/web three-pane layout. 720dp is roughly a tablet edge.
const _wideBreakpoint = 720.0;

enum ShellTab { inbox, feed, chat }

class _ShellTabNotifier extends Notifier<ShellTab> {
  @override
  ShellTab build() => ShellTab.inbox;
  void set(ShellTab t) => state = t;
}

final shellTabProvider =
    NotifierProvider<_ShellTabNotifier, ShellTab>(_ShellTabNotifier.new);

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
        bottomNavigationBar: const _PulseBottomNav(),
      ),
    );
  }
}

class _PulseBottomNav extends ConsumerWidget {
  const _PulseBottomNav();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    if (width >= _wideBreakpoint) return const SizedBox.shrink();
    final tab = ref.watch(shellTabProvider);
    final t = context.tokens;
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: t.hair)),
      ),
      child: BottomNavigationBar(
        currentIndex: tab.index,
        onTap: (i) =>
            ref.read(shellTabProvider.notifier).set(ShellTab.values[i]),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox_outlined),
            activeIcon: Icon(Icons.inbox),
            label: 'INBOX',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tag),
            activeIcon: Icon(Icons.tag),
            label: 'FEED',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum_outlined),
            activeIcon: Icon(Icons.forum),
            label: 'CHAT',
          ),
        ],
      ),
    );
  }
}

class _PulseAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const _PulseAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(40);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    return AppBar(
      toolbarHeight: 40,
      titleSpacing: 12,
      title: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: t.ink, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(
            'pulse',
            style: TextStyle(
              fontFamily: pulseMonoFamily,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.04 * 12,
              color: t.ink,
            ),
          ),
        ],
      ),
      actions: [
        const OutboxIndicator(),
        IconButton(
          tooltip: 'Themes',
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ThemePickerScreen()),
          ),
          icon: const Icon(Icons.palette_outlined, size: 18),
        ),
        IconButton(
          tooltip: 'Sign out',
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          onPressed: () => ref.read(authControllerProvider.notifier).logout(),
          icon: const Icon(Icons.logout, size: 18),
        ),
        const SizedBox(width: 8),
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
    final t = context.tokens;
    final tab = ref.watch(shellTabProvider);
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              SizedBox(
                width: 224,
                child: const TagTreePane(),
              ),
              VerticalDivider(width: 1, color: t.hair, thickness: 1),
              Expanded(
                child: switch (tab) {
                  ShellTab.inbox => const InboxScreen(),
                  ShellTab.feed => Row(
                      children: [
                        const SizedBox(width: 320, child: PostListPane()),
                        VerticalDivider(width: 1, color: t.hair, thickness: 1),
                        const Expanded(child: PostDetailPane()),
                      ],
                    ),
                  ShellTab.chat => const ChatPane(),
                },
              ),
            ],
          ),
        ),
        PulseStatusBar(
          left: tab == ShellTab.inbox
              ? '#inbox'
              : tab == ShellTab.feed
                  ? 'feed'
                  : 'chat',
          right: const [],
        ),
      ],
    );
  }
}

/// Mobile single-pane stack — the active bottom nav tab decides the body.
/// Feed retains its tag → list → detail provider-driven flow.
class _NarrowLayout extends ConsumerWidget {
  const _NarrowLayout();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = ref.watch(shellTabProvider);
    switch (tab) {
      case ShellTab.inbox:
        return const InboxScreen();
      case ShellTab.feed:
        return const _FeedStack();
      case ShellTab.chat:
        return const ChatPane();
    }
  }
}

class _FeedStack extends ConsumerWidget {
  const _FeedStack();

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
            toolbarHeight: 40,
            leading: BackButton(
              onPressed: () =>
                  ref.read(selectedPostIdProvider.notifier).state = null,
            ),
            title: Text('Post', style: pulseMono(context, size: 12)),
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
            toolbarHeight: 40,
            leading: BackButton(
              onPressed: () =>
                  ref.read(selectedTagIdProvider.notifier).state = null,
            ),
            title: Text('Posts', style: pulseMono(context, size: 12)),
          ),
          body: const PostListPane(),
        ),
      );
    }
    return const TagTreePane();
  }
}
