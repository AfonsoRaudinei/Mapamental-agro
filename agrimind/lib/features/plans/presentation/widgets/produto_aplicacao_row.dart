import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../domain/entities/produto_aplicacao_entity.dart';
import '../../../../core/utils/extensions.dart';

/// Linha de produto na Zona B do EstadioBlock.
///
/// Exibe:
/// ● NomeProduto  [⚠️ Manual]  [✏️] [🗑]
///   0,4 L/ha  ×  [80,0] ha  =  32,0 L
///   Motivo: "Estoque limitado"  ← só se override ativo
class ProdutoAplicacaoRow extends StatefulWidget {
  const ProdutoAplicacaoRow({
    super.key,
    required this.produto,
    required this.categoriaColor,
    required this.onEdit,
    required this.onDelete,
    required this.onAreaChanged,
  });

  final ProdutoAplicacaoEntity produto;

  /// Cor da categoria para o ponto colorido e total.
  final Color categoriaColor;

  final VoidCallback onEdit;
  final VoidCallback onDelete;

  /// Chamado quando o usuário edita a área inline.
  final void Function(double) onAreaChanged;

  @override
  State<ProdutoAplicacaoRow> createState() => _ProdutoAplicacaoRowState();
}

class _ProdutoAplicacaoRowState extends State<ProdutoAplicacaoRow> {
  late TextEditingController _areaCtrl;

  @override
  void initState() {
    super.initState();
    _areaCtrl = TextEditingController(
      text: widget.produto.areaHa.toStringAsFixed(1),
    );
  }

  @override
  void didUpdateWidget(ProdutoAplicacaoRow old) {
    super.didUpdateWidget(old);
    if (old.produto.areaHa != widget.produto.areaHa) {
      _areaCtrl.text = widget.produto.areaHa.toStringAsFixed(1);
    }
  }

  @override
  void dispose() {
    _areaCtrl.dispose();
    super.dispose();
  }

  /// Formata o total para exibição (ex: 32,0 L ou 1,2 kL).
  String _formatTotal() {
    final p = widget.produto;
    final t = p.totalFinal;
    final unit = p.doseUnidade.split('/').first;
    if (t >= 1000) {
      return '${(t / 1000).toStringAsFixed(2)} k$unit';
    }
    return '${t.toStringAsFixed(1)} $unit';
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.produto;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Linha 1: ponto + nome + badges + ações ─────────────────────
          Row(
            children: [
              // Ponto colorido da categoria
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(right: 6, top: 1),
                decoration: BoxDecoration(
                  color: widget.categoriaColor,
                  shape: BoxShape.circle,
                ),
              ),

              // Nome do produto
              Expanded(
                child: Text(
                  p.produtoNome,
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.appTextPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // Badge override
              if (p.isOverride)
                Container(
                  margin: const EdgeInsets.only(right: 4),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Text(
                    '⚠️ Manual',
                    style: AppTypography.label.copyWith(
                      color: AppColors.warning,
                    ),
                  ),
                ),

              // Botão editar
              _ActionBtn(
                icon: PhosphorIconsRegular.pencilSimple,
                onTap: widget.onEdit,
              ),

              // Botão excluir
              _ActionBtn(
                icon: PhosphorIconsRegular.trash,
                color: AppColors.error,
                onTap: widget.onDelete,
              ),
            ],
          ),

          // ── Linha 2: dose × [área editável] ha = total ─────────────────
          Padding(
            padding: const EdgeInsets.only(left: 14, top: 2),
            child: Row(
              children: [
                Text(
                  '${p.dose} ${p.doseUnidade}  ×',
                  style: AppTypography.caption.copyWith(
                    color: context.appTextSecondary,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                _InlineAreaField(
                  controller: _areaCtrl,
                  onChanged: (v) {
                    final parsed = double.tryParse(v.replaceAll(',', '.'));
                    if (parsed != null) widget.onAreaChanged(parsed);
                  },
                ),
                Text(
                  ' ha  =',
                  style: AppTypography.caption.copyWith(
                    color: context.appTextSecondary,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  _formatTotal(),
                  style: AppTypography.caption.copyWith(
                    color: p.isOverride
                        ? AppColors.warning
                        : widget.categoriaColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          // ── Linha 3: motivo do override ────────────────────────────────
          if (p.isOverride && p.overrideMotivo != null)
            Padding(
              padding: const EdgeInsets.only(left: 14, top: 2),
              child: Text(
                'Motivo: ${p.overrideMotivo}',
                style: AppTypography.label.copyWith(
                  color: context.appTextSecondary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ── Widgets internos ────────────────────────────────────────────────────────

class _ActionBtn extends StatelessWidget {
  const _ActionBtn({
    required this.icon,
    required this.onTap,
    this.color,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 36,
        height: 36,
        child: Center(
          child: PhosphorIcon(
            icon,
            size: 18,
            color: color ?? context.appTextSecondary,
          ),
        ),
      ),
    );
  }
}

class _InlineAreaField extends StatelessWidget {
  const _InlineAreaField({
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56,
      height: 28,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]')),
          LengthLimitingTextInputFormatter(7),
        ],
        style: AppTypography.caption.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w700,
        ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 4,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(color: context.appBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
              color: AppColors.primary,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
