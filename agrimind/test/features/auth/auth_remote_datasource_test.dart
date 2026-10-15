import 'package:agrimind/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  test('reconhece cancelamento de OAuth', () {
    expect(
      isAuthFlowCancellation(PlatformException(code: 'popup-closed-by-user')),
      isTrue,
    );
  });

  test('não classifica erro de autenticação como cancelamento', () {
    expect(
      isAuthFlowCancellation(
        const AuthException('Credenciais inválidas',
            code: 'invalid_credentials'),
      ),
      isFalse,
    );
  });
}
