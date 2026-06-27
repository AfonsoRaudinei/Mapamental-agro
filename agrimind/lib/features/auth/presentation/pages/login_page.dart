import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/validators.dart';
import '../providers/auth_provider.dart';
import '../auth_error_mapper.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/social_sign_in_button.dart';
import '../../../../core/utils/extensions.dart';

/// Tela de login com Supabase Auth.
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _senhaCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _senhaCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    await ref.read(authNotifierProvider.notifier).loginWithEmail(
          email: _emailCtrl.text.trim(),
          senha: _senhaCtrl.text,
        );
    if (!mounted) return;
    final s = ref.read(authNotifierProvider);
    if (s.hasError) _showError(AuthErrorMapper.message(s.error));
  }

  Future<void> _loginWithGoogle() async {
    await ref.read(authNotifierProvider.notifier).loginWithGoogle();
    if (!mounted) return;
    final s = ref.read(authNotifierProvider);
    if (s.hasError && !AuthErrorMapper.isCancellation(s.error)) {
      _showError(AuthErrorMapper.message(s.error));
    }
  }

  Future<void> _loginWithApple() async {
    await ref.read(authNotifierProvider.notifier).loginWithApple();
    if (!mounted) return;
    final s = ref.read(authNotifierProvider);
    if (s.hasError && !AuthErrorMapper.isCancellation(s.error)) {
      _showError(AuthErrorMapper.message(s.error));
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: AppColors.error,
      behavior: SnackBarBehavior.floating,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authNotifierProvider).isLoading;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.xl),
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(Icons.eco_rounded,
                      color: Colors.white, size: 32),
                ),
                const SizedBox(height: AppSpacing.lg),
                const Text('Entrar', style: AppTypography.h1),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Acesse sua conta AgriMind',
                  style:
                      TextStyle(fontSize: 16, color: context.appTextSecondary),
                ),
                const SizedBox(height: AppSpacing.xxl),
                AuthTextField(
                  label: 'E-mail',
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                  validator: Validators.email,
                  autofillHints: const [AutofillHints.email],
                ),
                const SizedBox(height: AppSpacing.md),
                AuthTextField(
                  label: 'Senha',
                  controller: _senhaCtrl,
                  isPassword: true,
                  prefixIcon: Icons.lock_outline,
                  validator: Validators.senha,
                  autofillHints: const [AutofillHints.password],
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: _login,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => context.push(AppRoutes.recover),
                    child: Text(
                      'Esqueceu a senha?',
                      style: TextStyle(color: AppColors.primary, fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                AuthPrimaryButton(
                  label: 'Entrar',
                  onPressed: isLoading ? null : _login,
                  isLoading: isLoading,
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  children: [
                    Expanded(child: Divider(color: context.appBorder)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                      child: Text(
                        'ou continue com',
                        style: TextStyle(
                            color: context.appTextSecondary, fontSize: 13),
                      ),
                    ),
                    Expanded(child: Divider(color: context.appBorder)),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                SocialSignInButton(
                  type: SocialSignInType.apple,
                  onPressed: isLoading ? null : _loginWithApple,
                  isLoading: isLoading,
                ),
                const SizedBox(height: AppSpacing.sm),
                SocialSignInButton(
                  type: SocialSignInType.google,
                  onPressed: isLoading ? null : _loginWithGoogle,
                  isLoading: isLoading,
                ),
                const SizedBox(height: AppSpacing.xl),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Não tem conta? ',
                      style: TextStyle(color: context.appTextSecondary),
                    ),
                    GestureDetector(
                      onTap: () => context.push(AppRoutes.register),
                      child: const Text(
                        'Criar conta',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
