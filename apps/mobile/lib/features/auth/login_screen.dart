import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/auth_controller.dart';
import '../../design/atoms/pulse_button.dart';
import '../../design/tokens.dart';
import '../../design/typography.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    final ok = await ref.read(authControllerProvider.notifier).login(
          _emailController.text.trim(),
          _passwordController.text,
        );
    if (!mounted) return;
    setState(() {
      _busy = false;
      if (!ok) {
        final state = ref.read(authControllerProvider);
        _error = state is AuthSignedOut ? state.lastError : 'login failed';
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
                    'sign in',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: t.ink,
                      letterSpacing: -0.012 * 28,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'workplace · posts · chat',
                    style: TextStyle(
                      fontFamily: pulseMonoFamily,
                      fontSize: 11,
                      color: t.ink3,
                      letterSpacing: 0.04 * 11,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _Label(label: 'EMAIL'),
                  TextFormField(
                    controller: _emailController,
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    style: TextStyle(fontSize: 13, color: t.ink),
                    decoration: const InputDecoration(),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'email required'
                        : null,
                  ),
                  const SizedBox(height: 14),
                  _Label(label: 'PASSWORD'),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    autofillHints: const [AutofillHints.password],
                    style: TextStyle(fontSize: 13, color: t.ink),
                    decoration: const InputDecoration(),
                    onFieldSubmitted: (_) => _submit(),
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'password required' : null,
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
                      label: _busy ? 'Signing in…' : 'Sign in',
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
