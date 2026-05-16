import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/auth_controller.dart';
import '../../design/atoms/pulse_status_bar.dart';
import '../../design/tokens.dart';
import '../../design/typography.dart';
import '../impersonation/impersonation_banner.dart';
import '../mention_preview/mention_preview_overlay.dart';
import '../palette/command_palette_overlay.dart';
import 'outbox_indicator.dart';

/// 720dp matches the responsive breakpoint used inside individual panes
/// (feed, chat) so the rail/bottom-nav decision lines up with the
/// per-pane wide/narrow layout decision.
const _wideBreakpoint = 720.0;

/// Chrome around [StatefulShellRoute.indexedStack]. Renders the app bar,
/// impersonation banner, the navigation shell's active branch, the
/// status bar, and either the bottom nav (narrow) or the side rail (wide).
///
/// This widget is the shell route's `builder` — it receives the active
/// [StatefulNavigationShell] from go_router and drives tab switching
/// via [StatefulNavigationShell.goBranch].
class ScaffoldWithNavBar extends ConsumerWidget {
  const ScaffoldWithNavBar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommandPaletteOverlay(
      child: MentionPreviewOverlay(
        child: Scaffold(
          appBar: const _PulseAppBar(),
          body: Column(
            children: [
              const ImpersonationBanner(),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth >= _wideBreakpoint) {
                      return _WideChrome(navigationShell: navigationShell);
                    }
                    return navigationShell;
                  },
                ),
              ),
            ],
          ),
          bottomNavigationBar:
              _MaybeBottomNav(navigationShell: navigationShell),
        ),
      ),
    );
  }
}

class _WideChrome extends StatelessWidget {
  const _WideChrome({required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              _WideNavRail(navigationShell: navigationShell),
              VerticalDivider(width: 1, color: t.hair, thickness: 1),
              Expanded(child: navigationShell),
            ],
          ),
        ),
        PulseStatusBar(
          left: _statusLabel(navigationShell.currentIndex),
          right: const [],
        ),
      ],
    );
  }
}

String _statusLabel(int index) => switch (index) {
      0 => '#inbox',
      1 => 'feed',
      2 => 'chat',
      _ => '',
    };

class _WideNavRail extends StatelessWidget {
  const _WideNavRail({required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: (i) => navigationShell.goBranch(
        i,
        initialLocation: i == navigationShell.currentIndex,
      ),
      labelType: NavigationRailLabelType.selected,
      minWidth: 52,
      useIndicator: false,
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.inbox_outlined),
          selectedIcon: Icon(Icons.inbox),
          label: Text('INBOX'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.tag),
          selectedIcon: Icon(Icons.tag),
          label: Text('FEED'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.forum_outlined),
          selectedIcon: Icon(Icons.forum),
          label: Text('CHAT'),
        ),
      ],
    );
  }
}

class _MaybeBottomNav extends StatelessWidget {
  const _MaybeBottomNav({required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= _wideBreakpoint) return const SizedBox.shrink();
    final t = context.tokens;
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: t.hair)),
      ),
      child: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (i) => navigationShell.goBranch(
          i,
          initialLocation: i == navigationShell.currentIndex,
        ),
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
          onPressed: () => context.push('/settings/theme'),
          icon: const Icon(Icons.palette_outlined, size: 18),
        ),
        IconButton(
          tooltip: 'Cache',
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          onPressed: () => context.push('/settings/cache'),
          icon: const Icon(Icons.storage_outlined, size: 18),
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
