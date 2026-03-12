import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(authServiceProvider));
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _service;
  
  AuthNotifier(this._service) : super(_service.state) {
    _service.addListener(() {
      state = _service.state;
    });
  }

  Future<void> signUp(String email, String password) async {
    await _service.signUpWithEmail(email, password);
  }

  Future<void> signIn(String email, String password) async {
    await _service.signInWithEmail(email, password);
  }

  Future<void> signInWithGoogle() async {
    await _service.signInWithGoogle();
  }

  Future<void> signOut() async {
    await _service.signOut();
  }
}

final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authStateProvider) == AuthState.authenticated;
});
