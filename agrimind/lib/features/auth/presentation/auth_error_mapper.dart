import 'package:flutter/services.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/datasources/auth_remote_datasource.dart';

abstract final class AuthErrorMapper {
  static bool isCancellation(Object? error) =>
      error is AuthFlowCancelledException ||
      (error != null && isAuthFlowCancellation(error));

  static String message(Object? error) {
    final code = switch (error) {
      AuthException(:final code) => code,
      PlatformException(:final code) => code,
      _ => null,
    };

    if (code != null) {
      return switch (code.toLowerCase()) {
        'invalid_credentials' ||
        'invalid-credential' =>
          'E-mail ou senha incorretos.',
        'email_address_invalid' => 'E-mail inválido.',
        'user_already_exists' || 'email_exists' => 'E-mail já cadastrado.',
        'weak_password' => 'A senha informada é muito fraca.',
        'user_banned' => 'Esta conta foi desativada.',
        'over_request_rate_limit' =>
          'Muitas tentativas. Aguarde e tente novamente.',
        'email_provider_disabled' ||
        'provider_disabled' =>
          'Este método de acesso ainda não está habilitado no Supabase.',
        'email_confirmation_required' =>
          'Desative a confirmação de e-mail no Supabase para acesso imediato.',
        'bad_jwt' ||
        'validation_failed' =>
          'A configuração de autenticação do aplicativo está inválida.',
        'keychain-error' =>
          'O iPhone não conseguiu acessar a sessão salva. Tente novamente.',
        'internal-error' =>
          'O serviço de autenticação encontrou um erro interno. Tente novamente.',
        'requires-recent-login' =>
          'Entre novamente antes de excluir sua conta.',
        _ => 'Não foi possível concluir a autenticação. Código: $code.',
      };
    }
    return 'Não foi possível concluir a autenticação. Tente novamente.';
  }

  static String diagnostic(Object? error) {
    return switch (error) {
      AuthException(:final code, :final message) =>
        'AuthException(${code ?? 'sem código'}): $message',
      SignInWithAppleAuthorizationException(:final code, :final message) =>
        'AppleAuthorizationException(${code.name}): $message',
      PlatformException(:final code, :final message, :final details) =>
        'PlatformException($code): ${message ?? details ?? 'sem detalhes'}',
      _ => '${error.runtimeType}: $error',
    };
  }
}
