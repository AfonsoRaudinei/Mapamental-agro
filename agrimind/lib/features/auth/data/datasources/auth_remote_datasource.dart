import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/errors/auth_flow_exception.dart';

bool isAuthFlowCancellation(Object error) {
  final code = switch (error) {
    AuthException(:final code) => code,
    PlatformException(:final code) => code,
    SignInWithAppleAuthorizationException(:final code) => code.name,
    _ => null,
  };

  return AuthCancellationCodes.contains(code);
}

/// Datasource remoto para autenticação via Supabase Auth.
class AuthRemoteDatasource {
  AuthRemoteDatasource({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;
  GoTrueClient get _auth => _client.auth;

  Stream<User?> get authStateChanges =>
      _auth.onAuthStateChange.map((event) => event.session?.user);

  /// Usuário atual do Supabase (pode ser null).
  User? get currentUser => _auth.currentUser;

  /// Login com e-mail e senha.
  Future<User> loginWithEmail({
    required String email,
    required String senha,
  }) async {
    final response = await _auth.signInWithPassword(
      email: email.trim(),
      password: senha,
    );
    return _requireUser(response.user);
  }

  /// Cadastro com e-mail, senha e atualiza displayName.
  Future<User> registerWithEmail({
    required String email,
    required String senha,
    required String nome,
  }) async {
    final response = await _auth.signUp(
      email: email.trim(),
      password: senha,
      data: {'full_name': nome.trim()},
    );
    if (response.session == null) {
      throw const AuthException(
        'Cadastro criado, mas a confirmação de e-mail está habilitada.',
        code: 'email_confirmation_required',
      );
    }
    return _requireUser(response.user);
  }

  /// Login com Google via Supabase OAuth.
  Future<User> loginWithGoogle() async {
    try {
      final launched = await _auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'com.cultivamind.agrimind://login-callback',
      );
      if (!launched) throw const AuthFlowCancelledException();
      return await _waitForSocialLogin();
    } on Object catch (error) {
      if (isAuthFlowCancellation(error)) {
        throw const AuthFlowCancelledException();
      }
      rethrow;
    }
  }

  /// Login com Apple via token nativo e Supabase Auth.
  Future<User> loginWithApple() async {
    try {
      final rawNonce = _generateNonce();
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName
        ],
        nonce: sha256.convert(utf8.encode(rawNonce)).toString(),
      );
      final token = credential.identityToken;
      if (token == null) {
        throw const AuthException(
            'A Apple não retornou um token de identidade.');
      }
      final response = await _auth.signInWithIdToken(
        provider: OAuthProvider.apple,
        idToken: token,
        nonce: rawNonce,
      );
      return _requireUser(response.user);
    } on Object catch (error) {
      if (isAuthFlowCancellation(error)) {
        throw const AuthFlowCancelledException();
      }
      rethrow;
    }
  }

  /// Envia e-mail de recuperação de senha.
  Future<void> recoverPassword(String email) => _auth.resetPasswordForEmail(
        email.trim(),
        redirectTo: 'com.cultivamind.agrimind://reset-password',
      );

  /// Logout da sessão Supabase.
  Future<void> logout() => _auth.signOut();

  Future<void> deleteAccount() async {
    if (_auth.currentUser == null) return;
    await _client.rpc<void>('delete_current_user');
    await _auth.signOut();
  }

  Future<User> _waitForSocialLogin() async {
    final current = _auth.currentUser;
    if (current != null) return current;
    try {
      return await authStateChanges
          .where((user) => user != null)
          .cast<User>()
          .first
          .timeout(const Duration(minutes: 2));
    } on TimeoutException {
      throw const AuthFlowCancelledException();
    }
  }

  String _generateNonce([int length = 32]) {
    const chars =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => chars[random.nextInt(chars.length)])
        .join();
  }

  User _requireUser(User? user) {
    if (user == null) {
      throw const AuthException(
        'A autenticação foi concluída sem retornar um usuário.',
        code: 'missing_user',
      );
    }
    return user;
  }
}
