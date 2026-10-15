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
    final label = labelOperacionalParaCard(
      novoTipo,
      incluirAdubacao: cfg.incluirAdubacao,
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

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_tipo == TipoOperacional.fungicidaRecorrente) ...[
            const SizedBox(height: 8),
            _intField(
              context,
              label: 'Dias de recuperação do pós-emergente',
              value: _config.diasRecuperacaoPosEmergente ?? 5,
              onChanged: (v) async {
                setState(
                  () => _config =
                      _config.copyWith(diasRecuperacaoPosEmergente: v),
                );
                await _persist(config: _config);
              },
            ),
            _intField(
              context,
              label: 'Nº de aplicações',
              value: _config.totalAplicacoesFungicida ?? 1,
              min: 1,
              onChanged: (v) async {
                setState(
                  () => _config = _config.copyWith(
                    totalAplicacoesFungicida: v,
                    intervaloFungicidaDias:
                        v <= 1 ? null : (_config.intervaloFungicidaDias ?? 14),
                  ),
                );
                await _persist(config: _config);
              },
            ),
            if ((_config.totalAplicacoesFungicida ?? 1) > 1)
              _intField(
                context,
                label: 'Intervalo entre aplicações (dias)',
                value: _config.intervaloFungicidaDias ?? 14,
                onChanged: (v) async {
                  setState(
                    () => _config =
                        _config.copyWith(intervaloFungicidaDias: v),
                  );
                  await _persist(config: _config);
                },
              ),
          ],
          if (_tipo == TipoOperacional.dessecacaoPreColheita) ...[
            const SizedBox(height: 8),
            _intField(
              context,
              label: 'Dias antes do R8',
              value: _config.diasAntesR8 ?? 12,
              onChanged: (v) async {
                setState(() => _config = _config.copyWith(diasAntesR8: v));
                await _persist(config: _config);
              },
            ),
            _intField(
              context,
              label: 'Antecipação da colheita (3–7 dias)',
              value: _config.diasAntecipacaoColheita ?? 5,
              min: 3,
              max: 7,
              onChanged: (v) async {
                setState(
                  () => _config =
                      _config.copyWith(diasAntecipacaoColheita: v.clamp(3, 7)),
                );
                await _persist(config: _config);
              },
            ),
            Text(
              'Antecipa a colheita em ${_config.diasAntecipacaoColheita ?? 5} dias',
              style: AppTypography.caption.copyWith(
                color: context.appTextSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _intField(
    BuildContext context, {
    required String label,
    required int value,
    required ValueChanged<int> onChanged,
    int min = 0,
    int? max,
  }) {
    final ctrl = TextEditingController(text: '$value');
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: TextField(
        controller: ctrl,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          isDense: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onSubmitted: (raw) {
          final parsed = int.tryParse(raw.trim());
          if (parsed == null) return;
          var v = parsed;
          if (v < min) v = min;
          if (max != null && v > max) v = max;
          onChanged(v);
        },
      ),
    );
  }
}
