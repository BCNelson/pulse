import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/server_config_controller.dart';
import '../../design/atoms/pulse_button.dart';
import '../../design/tokens.dart';
import '../../design/typography.dart';

/// First-run screen shown when neither a build-time PULSE_SERVER_URL
/// nor a persisted base URL is available. Accepts forms like
/// `https://pulse.example.com`, `pulse.example.com:8080`, or a bare
/// `pulse.example.com` (defaults to https on port 443).
class ServerUrlScreen extends ConsumerStatefulWidget {
  const ServerUrlScreen({super.key});

  @override
  ConsumerState<ServerUrlScreen> createState() => _ServerUrlScreenState();
}

class _ServerUrlScreenState extends ConsumerState<ServerUrlScreen> {
  final _urlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    final ok = await ref
        .read(serverConfigControllerProvider.notifier)
        .submit(_urlController.text);
    if (!mounted) return;
    setState(() {
      _busy = false;
      if (!ok) {
        final state = ref.read(serverConfigControllerProvider);
        _error = state is ServerConfigMissing
            ? (state.lastError ?? 'invalid URL')
            : 'invalid URL';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Scaffold(
      backgroundColor: t.paper,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: t.ink,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'pulse',
                        style: TextStyle(
                          fontFamily: pulseMonoFamily,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.04 * 18,
                          color: t.ink,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'connect',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: t.ink,
                      letterSpacing: -0.012 * 28,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'point this app at your pulse server',
                    style: TextStyle(
                      fontFamily: pulseMonoFamily,
                      fontSize: 11,
                      color: t.ink3,
                      letterSpacing: 0.04 * 11,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _Label(label: 'SERVER URL'),
                  TextFormField(
                    controller: _urlController,
                    autofocus: true,
                    keyboardType: TextInputType.url,
                    autocorrect: false,
                    style: TextStyle(fontSize: 13, color: t.ink),
                    decoration: const InputDecoration(
                      hintText: 'https://pulse.example.com',
                    ),
                    onFieldSubmitted: (_) => _submit(),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'server URL required'
                        : null,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'e.g. https://pulse.example.com, my-server.lan:8080, or pulse.example.com',
                    style: TextStyle(
                      fontFamily: pulseMonoFamily,
                      fontSize: 10,
                      color: t.ink3,
                      letterSpacing: 0.04 * 10,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        _error!,
                        style: TextStyle(
                          fontFamily: pulseMonoFamily,
                          fontSize: 11,
                          color: t.amberInk,
                        ),
                      ),
                    ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: PulseButton(
                      label: _busy ? 'Connecting…' : 'Continue',
                      variant: PulseButtonVariant.primary,
                      onPressed: _busy ? null : _submit,
                      kbdHint: '↩',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: pulseMonoFamily,
          fontSize: 10,
          color: t.ink3,
          letterSpacing: 0.08 * 10,
        ),
      ),
    );
  }
}
