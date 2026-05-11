import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ferry_client.dart';
import '../../design/atoms/pulse_button.dart';
import '../../design/tokens.dart';
import '../../design/typography.dart';
import '../../graphql/operations/__generated__/impersonation.req.gql.dart';

/// ImpersonationBanner shows a prominent strip across the top of the
/// shell while the viewer is acting on someone else's behalf. Loud by
/// design — uses the theme's amber (urgency) tokens.
class ImpersonationBanner extends ConsumerWidget {
  const ImpersonationBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final client = ref.watch(ferryClientProvider);
    return StreamBuilder(
      stream: client.request(GViewerImpersonationStateReq()),
      builder: (context, snap) {
        final state = snap.data?.data?.viewerImpersonationState;
        if (state == null || !state.isImpersonating) {
          return const SizedBox.shrink();
        }
        return Container(
          decoration: BoxDecoration(
            color: t.amber,
            border: Border(bottom: BorderSide(color: t.ink)),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              child: Row(
                children: [
                  Text(
                    'IMPERSONATING',
                    style: TextStyle(
                      fontFamily: pulseMonoFamily,
                      fontSize: 10,
                      letterSpacing: 0.10 * 10,
                      color: t.ink,
                      fontWeight: FontWeight.w700,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'acting as ${state.effective?.displayName ?? "?"} · '
                      'actual ${state.acting?.displayName ?? "?"}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: pulseMonoFamily,
                        fontSize: 11,
                        color: t.ink,
                        height: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  PulseButton(
                    label: 'Stop',
                    icon: Icons.exit_to_app,
                    onPressed: () {
                      // ignore: invalid_use_of_protected_member
                      client.requestController.add(GEndImpersonationReq());
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
