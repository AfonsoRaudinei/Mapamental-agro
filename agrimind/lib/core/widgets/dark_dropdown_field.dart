import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Dropdown legível no modo black — corrige texto escuro sobre fundo escuro.
class DarkDropdownField<T> extends StatelessWidget {
  const DarkDropdownField({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.label,
    this.hint,
  });

  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final String? hint;

  static TextStyle get _valueStyle => const TextStyle(
        color: AppColors.primary,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(
              color: AppColors.onSurfaceMuted,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
        ],
        DropdownButtonFormField<T>(
          value: value,
          items: items,
          onChanged: onChanged,
          hint: hint != null
              ? Text(hint!, style: const TextStyle(color: AppColors.onSurfaceDim))
              : null,
          style: _valueStyle,
          dropdownColor: AppColors.surfaceElevated,
          iconEnabledColor: AppColors.primary,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.surfaceElevated,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
          ),
        ),
      ],
    );
  }
}
