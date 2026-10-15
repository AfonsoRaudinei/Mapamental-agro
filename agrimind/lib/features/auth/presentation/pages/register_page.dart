import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/validators.dart';
import '../providers/auth_provider.dart';
import '../auth_error_mapper.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_text_field.dart';
import '../../../../core/utils/extensions.dart';

/// Tela de cadastro com Supabase Auth.
class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _senhaCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _emailCtrl.dispose();
    _senhaCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    await ref.read(authNotifierProvider.notifier).registerWithEmail(
          email: _emailCtrl.text.trim(),
          senha: _senhaCtrl.text,
          nome: _nomeCtrl.text.trim(),
        );
    if (!mounted) return;
    final s = ref.read(authNotifierProvider);
    if (s.hasError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AuthErrorMapper.message(s.error)),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authNotifierProvider).isLoading;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: context.appTextPrimary),
          onPressed: () => context.pop(),
        ),
        title: const Text('Criar conta', style: AppTypography.h3),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.md),
                const Text('Crie sua conta', style: AppTypography.h2),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Preencha os dados abaixo para começar',
                  style:
                      TextStyle(fontSize: 16, color: context.appTextSecondary),
                ),
                const SizedBox(height: AppSpacing.xl),
                AuthTextField(
                  label: 'Nome completo',
                  controller: _nomeCtrl,
                  prefixIcon: Icons.person_outline,
                  validator: Validators.nome,
                  autofillHints: const [AutofillHints.name],
                ),
                const SizedBox(height: AppSpacing.md),
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
                  autofillHints: const [AutofillHints.newPassword],
                ),
                const SizedBox(height: AppSpacing.md),
                AuthTextField(
                  label: 'Confirmar senha',
                  controller: _confirmCtrl,
                  isPassword: true,
                  prefixIcon: Icons.lock_outline,
                  validator: (v) =>
                      Validators.confirmarSenha(v, _senhaCtrl.text),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: _register,
                ),
                const SizedBox(height: AppSpacing.xl),
                AuthPrimaryButton(
                  label: 'Criar conta',
                  onPressed: isLoading ? null : _register,
                  isLoading: isLoading,
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Já tem conta? ',
                      style: TextStyle(color: context.appTextSecondary),
                    ),
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: const Text(
                        'Entrar',
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
