import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../design/theme_controller.dart';
import '../../design/themes.dart';
import '../../design/tokens.dart';
import '../../design/typography.dart';

class ThemePickerScreen extends ConsumerWidget {
  const ThemePickerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(pulseThemeControllerProvider);
    final t = context.tokens;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        title: Text('THEMES', style: pulseMono(context, size: 12)),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 4),
        children: [
          for (final key in PulseThemeKey.values)
            _ThemeRow(
              themeKey: key,
              selected: key == current,
              onTap: () =>
                  ref.read(pulseThemeControllerProvider.notifier).select(key),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 14, 22, 12),
            child: Text(
              '12 themes · rebinds the same tokens · all bundled',
              style: TextStyle(
                fontFamily: pulseMonoFamily,
                fontSize: 10,
                color: t.ink3,
                letterSpacing: 0.08 * 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ThemeRow extends StatelessWidget {
  const _ThemeRow({
    required this.themeKey,
    required this.selected,
    required this.onTap,
  });

  final PulseThemeKey themeKey;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // Build the candidate theme's tokens by reading from a temporary
    // ThemeData wrapper. We can't access raw tokens without the theme
    // applied, so instead we render swatches by name lookup using the
    // public `pulseTheme()` factory and pulling its [PulseTokens].
    final candidate = pulseTheme(themeKey);
    final tokens = candidate.extension<PulseTokens>()!;
    final t = context.tokens;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? t.paper2 : Colors.transparent,
          border: Border(bottom: BorderSide(color: t.hair2)),
        ),
        child: Row(
          children: [
            // Swatch chip — a tiny preview of paper / ink / accents.
            Container(
              width: 56,
              height: 32,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                border: Border.all(color: t.hair),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Expanded(child: Container(color: tokens.paper)),
                  Expanded(child: Container(color: tokens.paper2)),
                  Expanded(child: Container(color: tokens.amber)),
                  Expanded(child: Container(color: tokens.green)),
                  Expanded(child: Container(color: tokens.blue)),
                  Expanded(child: Container(color: tokens.ink)),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    themeKey.label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                      color: t.ink,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    themeKey.tagline,
                    style: TextStyle(
                      fontFamily: pulseMonoFamily,
                      fontSize: 11,
                      color: t.ink3,
                      letterSpacing: 0.02 * 11,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            if (selected) Icon(Icons.check, size: 18, color: t.ink),
          ],
        ),
      ),
    );
  }
}
