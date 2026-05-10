import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ferry_client.dart';
import '../../graphql/operations/__generated__/impersonation.req.gql.dart';

/// ImpersonationBanner shows a prominent red bar across the top of the
/// shell while the viewer is acting on someone else's behalf. The
/// architecture flags the visual treatment as "deliberately loud".
class ImpersonationBanner extends ConsumerWidget {
  const ImpersonationBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final client = ref.watch(ferryClientProvider);
    return StreamBuilder(
      stream: client.request(GViewerImpersonationStateReq()),
      builder: (context, snap) {
        final state = snap.data?.data?.viewerImpersonationState;
        if (state == null || !state.isImpersonating) {
          return const SizedBox.shrink();
        }
        return Material(
          color: Colors.red.shade700,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber, color: Colors.white),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Acting as ${state.effective?.displayName ?? "?"} '
                      '— actual ${state.acting?.displayName ?? "?"}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      // ignore: invalid_use_of_protected_member
                      client.requestController.add(GEndImpersonationReq());
                    },
                    icon: const Icon(Icons.exit_to_app, color: Colors.white),
                    label: const Text(
                      'Stop',
                      style: TextStyle(color: Colors.white),
                    ),
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
