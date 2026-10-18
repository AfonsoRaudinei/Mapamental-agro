import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/extensions.dart';

/// Aviso quando a fazenda não tem plano ativo — cronograma legado (calculadora).
class CronogramaModoAvulsoBanner extends StatelessWidget {
  const CronogramaModoAvulsoBanner({super.key});

  static const String titulo = 'Sem plano ativo nesta fazenda';
  static const String corpo =
      'Você está no modo avulso: só calcula datas aqui. Não vincula roteiro '
      'operacional ao talhão nem salva no plano. Para o fluxo completo '
      '(atribuir roteiro, cards e cronograma na ficha do talhão), crie um '
      'plano vinculado a esta fazenda.';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: context.isDark ? 0.18 : 0.12),
        borderRadius: BorderRadius.circular(AppSpacing.md),
        border: Border.all(
          color: AppColors.warning.withValues(alpha: 0.45),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PhosphorIcon(
                PhosphorIconsRegular.info,
                size: 20,
                color: AppColors.warning,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  titulo,
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.w700,
                    color: context.appTextPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            corpo,
            style: AppTypography.caption.copyWith(
              color: context.appTextSecondary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          CupertinoButton.filled(
            padding: const EdgeInsets.symmetric(vertical: 10),
            onPressed: () => context.push(AppRoutes.planNew),
            child: const Text('Criar plano para esta fazenda'),
          ),
        ],
      ),
    );
  }
}
