import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../graphql/operations/__generated__/login.req.gql.dart';
import '../graphql/operations/__generated__/logout.req.gql.dart';
import 'auth_storage.dart';
import 'ferry_client.dart';

/// AuthState captures everything the UI needs to render auth-aware
/// screens: ready (loading bootstrap), authenticated (token + email),
/// or unauthenticated. The token is also exposed to the ferry client
/// via the controller's [token] getter.
sealed class AuthState {
  const AuthState();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSignedOut extends AuthState {
  const AuthSignedOut({this.lastError});
  final String? lastError;
}

class AuthSignedIn extends AuthState {
  const AuthSignedIn({required this.token, required this.email});
  final String token;
  final String email;
}

/// AuthController owns session state. It boots by reading the secure
/// storage; if a token is present we trust it (the server validates on
/// the next request). Logout clears storage and the state.
class AuthController extends Notifier<AuthState> {
  late final AuthStorage _storage;

  String? get token => switch (state) { AuthSignedIn s => s.token, _ => null };

  @override
  AuthState build() {
    _storage = AuthStorage();
    _restore();
    return const AuthLoading();
  }

  Future<void> _restore() async {
    final token = await _storage.readToken();
    final email = await _storage.readEmail();
    if (token != null && email != null) {
      state = AuthSignedIn(token: token, email: email);
    } else {
      state = const AuthSignedOut();
    }
  }

  Future<bool> login(String email, String password) async {
    final client = ref.read(ferryClientProvider);
    final req = GLoginReq((b) => b
      ..vars.email = email
      ..vars.password = password);
    final resp = await client.request(req).first;
    if (resp.hasErrors) {
      state = AuthSignedOut(
        lastError: resp.graphqlErrors?.map((e) => e.message).join('\n') ??
            resp.linkException?.toString() ??
            'login failed',
      );
      return false;
    }
    final data = resp.data;
    if (data == null) {
      state = const AuthSignedOut(lastError: 'no data returned');
      return false;
    }
    await _storage.save(token: data.login.token, email: email);
    state = AuthSignedIn(token: data.login.token, email: email);
    return true;
  }

  Future<void> logout() async {
    final t = token;
    if (t != null) {
      // Best-effort server-side logout. Don't block clearing local state.
      try {
        final client = ref.read(ferryClientProvider);
        await client.request(GLogoutReq()).first;
      } catch (_) {}
    }
    await _storage.clear();
    state = const AuthSignedOut();
  }
}

final authControllerProvider =
    NotifierProvider<AuthController, AuthState>(AuthController.new);
