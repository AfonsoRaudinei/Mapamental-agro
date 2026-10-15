import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/database/database_service.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

/// Implementação do [AuthRepository] usando Supabase Auth.
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._datasource);
  final AuthRemoteDatasource _datasource;

  @override
  Stream<UserEntity?> get authStateChanges {
    return _datasource.authStateChanges.asyncMap((user) async {
      if (user == null) {
        await DatabaseService.clearUserSession();
        return null;
      }
      await DatabaseService.bindOwner(user.id);
      return _mapUser(user);
    });
  }

  @override
  Future<UserEntity?> get currentUser async {
    final user = _datasource.currentUser;
    if (user != null) {
      await DatabaseService.bindOwner(user.id);
    }
    return user != null ? _mapUser(user) : null;
  }

  @override
  Future<UserEntity> loginWithEmail({
    required String email,
    required String senha,
  }) async {
    final user = await _datasource.loginWithEmail(email: email, senha: senha);
    await DatabaseService.bindOwner(user.id);
    return _mapUser(user);
  }

  @override
  Future<UserEntity> registerWithEmail({
    required String email,
    required String senha,
    required String nome,
  }) async {
    final user = await _datasource.registerWithEmail(
      email: email,
      senha: senha,
      nome: nome,
    );
    await DatabaseService.bindOwner(user.id);
    return _mapUser(user);
  }

  @override
  Future<UserEntity> loginWithGoogle() async {
    final user = await _datasource.loginWithGoogle();
    await DatabaseService.bindOwner(user.id);
    return _mapUser(user);
  }

  @override
  Future<UserEntity> loginWithApple() async {
    final user = await _datasource.loginWithApple();
    await DatabaseService.bindOwner(user.id);
    return _mapUser(user);
  }

  @override
  Future<void> recoverPassword(String email) =>
      _datasource.recoverPassword(email);

  @override
  Future<void> logout() async {
    await _datasource.logout();
    await DatabaseService.clearUserSession();
  }

  @override
  Future<void> deleteAccount() async {
    await _datasource.deleteAccount();
    await DatabaseService.clearUserSession();
  }

  UserEntity _mapUser(User user) {
    final now = DateTime.now();
    final metadata = user.userMetadata ?? const <String, dynamic>{};
    return UserEntity(
      id: user.id,
      nome: (metadata['full_name'] ?? metadata['name'] ?? 'Usuário').toString(),
      email: user.email ?? '',
      avatarUrl: metadata['avatar_url']?.toString(),
      createdAt: DateTime.tryParse(user.createdAt) ?? now,
      updatedAt: now,
    );
  }
}
