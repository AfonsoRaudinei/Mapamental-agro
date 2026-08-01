import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/extensions.dart';

/// Seletor visual de ícone do app.
/// Exibe duas opções: "Principal" e "Clássico".
class IconSelector extends StatelessWidget {
  const IconSelector({
    super.key,
    required this.selectedKey,
    required this.onChanged,
  });

  final String selectedKey;
  final ValueChanged<String> onChanged;

  static const List<_IconOption> _options = [
    _IconOption(
      key: 'principal',
      label: 'Principal',
      assetPath: 'assets/icons/icon_principal.png',
    ),
    _IconOption(
      key: 'classico',
      label: 'Clássico',
      assetPath: 'assets/icons/icon_classico.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          for (final option in _options) ...[
            Expanded(
              child: _IconOptionCard(
                option: option,
                isSelected: selectedKey == option.key,
                onTap: () => onChanged(option.key),
              ),
            ),
            if (option != _options.last) const SizedBox(width: AppSpacing.sm),
          ],
        ],
      ),
    );
  }
}

class _IconOption {
  const _IconOption({
    required this.key,
    required this.label,
    required this.assetPath,
  });

  final String key;
  final String label;
  final String assetPath;
}

class _IconOptionCard extends StatelessWidget {
  const _IconOptionCard({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  final _IconOption option;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryLight : context.appSurface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : context.appBorder,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Preview do ícone — fallback para container colorido se asset não existir
            ClipRounded(
              child: _IconPreview(assetPath: option.assetPath),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              option.label,
              style: AppTypography.label.copyWith(
                color:
                    isSelected ? AppColors.primary : context.appTextSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(height: 2),
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Exibe o ícone do app a partir de um asset, ou caixa colorida como fallback.
class _IconPreview extends StatelessWidget {
  const _IconPreview({required this.assetPath});

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.primaryLight,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          assetPath,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: AppColors.primary,
            child: const Center(
              child: Text(
                'A',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Helper para arredondar bordas de um filho.
class ClipRounded extends StatelessWidget {
  const ClipRounded({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => child;
}
