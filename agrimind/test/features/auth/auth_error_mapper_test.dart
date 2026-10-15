import 'package:agrimind/features/auth/domain/errors/auth_flow_exception.dart';
import 'package:agrimind/features/auth/presentation/auth_error_mapper.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  test('mapeia credencial inválida sem expor erro técnico', () {
    const error = AuthException('Invalid login', code: 'invalid_credentials');
    expect(AuthErrorMapper.message(error), 'E-mail ou senha incorretos.');
  });

  test('reconhece cancelamento de login social', () {
    expect(
      AuthErrorMapper.isCancellation(const AuthFlowCancelledException()),
      isTrue,
    );
  });

  test('explica quando o provedor não está habilitado', () {
    const error = AuthException('Disabled', code: 'provider_disabled');
    expect(
      AuthErrorMapper.message(error),
      'Este método de acesso ainda não está habilitado no Supabase.',
    );
  });

  test('reconhece cancelamento nativo com grafia britânica', () {
    final error = PlatformException(code: 'web-context-cancelled');
    expect(AuthErrorMapper.isCancellation(error), isTrue);
  });

  test('preserva código desconhecido para diagnóstico', () {
    const error =
        AuthException('Unexpected', code: 'unexpected_provider_error');
    expect(
      AuthErrorMapper.message(error),
      'Não foi possível concluir a autenticação. Código: unexpected_provider_error.',
    );
  });
}
