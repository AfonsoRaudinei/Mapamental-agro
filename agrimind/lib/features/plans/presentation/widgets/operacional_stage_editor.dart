import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/extensions.dart';
import '../../domain/entities/estadio_entity.dart';
import '../../domain/entities/operacional_estadio_config.dart';
import '../../domain/talhao_safra/mapear_tipo_operacional_label.dart';
import '../../domain/talhao_safra/tipo_operacional.dart';
import 'operacional_tipo_dropdown.dart';

/// Campos condicionais do card operacional (tipo no header via [OperacionalTipoDropdown]).
class OperacionalStageEditor extends StatefulWidget {
  const OperacionalStageEditor({
    super.key,
    required this.estadio,
    required this.onSave,
    this.onSyncFungicidaSubcards,
  });

  final EstadioEntity estadio;
  final OperacionalEstadioSave onSave;
  final Future<void> Function(EstadioEntity pai)? onSyncFungicidaSubcards;

  @override
  State<OperacionalStageEditor> createState() => _OperacionalStageEditorState();
}

class _OperacionalStageEditorState extends State<OperacionalStageEditor> {
  late TipoOperacional? _tipo;
  late OperacionalEstadioConfig _config;

  @override
  void initState() {
    super.initState();
    _syncFromEstadio();
  }

  @override
  void didUpdateWidget(covariant OperacionalStageEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.estadio.id != widget.estadio.id ||
        oldWidget.estadio.tipoOperacional != widget.estadio.tipoOperacional ||
        oldWidget.estadio.operacionalConfig != widget.estadio.operacionalConfig) {
      _syncFromEstadio();
    }
  }

  void _syncFromEstadio() {
    _tipo = widget.estadio.tipoOperacional;
    _config = widget.estadio.operacionalConfig ?? const OperacionalEstadioConfig();
  }

  Future<void> _persist({OperacionalEstadioConfig? config}) async {
    final novoTipo = _tipo;
    if (novoTipo == null || novoTipo == TipoOperacional.indefinido) return;

    final cfg = config ?? _config;
    final label = labelOperacionalComAplicacao(
      novoTipo,
      incluirAdubacao: cfg.incluirAdubacao,
      aplicacaoIndice: cfg.aplicacaoIndice,
    );
    final atualizado = widget.estadio.copyWith(
      operacionalConfig: cfg,
      label: label,
    );
    await widget.onSave(atualizado);

    if (widget.onSyncFungicidaSubcards != null) {
      await widget.onSyncFungicidaSubcards!(atualizado);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.estadio.isSubcardFungicida) {
      return const SizedBox.shrink();
    }

    final indefinido =
        widget.estadio.isOperacional && widget.estadio.operacionalTipoIndefinido;
    if (indefinido) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
        child: Text(
          'Não foi possível identificar o tipo salvo (“${widget.estadio.label}”). '
          'Escolha um tipo no menu do título — os produtos permanecem.',
          style: AppTypography.caption.copyWith(
            color: AppColors.warning,
            height: 1.35,
          ),
        ),
      );
    }

    if (_tipo == null || _tipo == TipoOperacional.indefinido) {
      return const SizedBox.shrink();
    }

    // Plantio é configurado só no módulo Clientes (talhões), não no canvas do plano.
    if (_tipo == TipoOperacional.plantio) {
      return const SizedBox.shrink();
    }

    // Dias de recuperação, nº de aplicações e intervalo do fungicida são
    // regulagem de cronograma — ficam só no módulo Clientes → Cronograma
    // Agrícola, não no canvas do plano.
    if (_tipo == TipoOperacional.fungicidaRecorrente) {
      return const SizedBox.shrink();
    }

    // Dias antes do R8 e antecipação da colheita também são regulagem de
    // cronograma — mesma regra acima, ficam só no módulo Clientes.
    if (_tipo == TipoOperacional.dessecacaoPreColheita) {
      return const SizedBox.shrink();
    }

    // Nenhum outro tipo operacional/fenológico tem campos de regulagem
    // neste editor — o card aqui é só tipo + produtos por momento.
    return const SizedBox.shrink();
  }
}
