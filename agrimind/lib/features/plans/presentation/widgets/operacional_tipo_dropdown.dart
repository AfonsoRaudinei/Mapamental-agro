import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/extensions.dart';
import '../../domain/entities/estadio_entity.dart';
import '../../domain/entities/operacional_estadio_config.dart';
import '../../domain/entities/plano_entity.dart';
import '../../domain/talhao_safra/mapear_tipo_operacional_label.dart';
import '../../domain/talhao_safra/roteiro_plano_template.dart';
import '../../domain/talhao_safra/tipo_operacional.dart';

typedef OperacionalEstadioSave = Future<void> Function(EstadioEntity atualizado);

/// Dropdown inline do tipo operacional (substitui action sheet no header do card).
///
/// A seta de seleção só fica disponível com o card expandido ([isExpanded]);
/// recolhido, mostra apenas o rótulo atual (sem afordance de toque).
class OperacionalTipoDropdown extends StatefulWidget {
  const OperacionalTipoDropdown({
    super.key,
    required this.estadio,
    required this.onSave,
    required this.tipos,
    required this.plano,
    required this.isExpanded,
    this.hintText = 'Selecione o tipo de operação',
    this.onSyncFungicidaSubcards,
    this.dense = false,
  });

  final EstadioEntity estadio;
  final OperacionalEstadioSave onSave;
  final List<TipoOperacional> tipos;
  final PlanoEntity plano;
  final bool isExpanded;
  final String hintText;
  final Future<void> Function(EstadioEntity pai)? onSyncFungicidaSubcards;
  final bool dense;

  @override
  State<OperacionalTipoDropdown> createState() => _OperacionalTipoDropdownState();
}

class _OperacionalTipoDropdownState extends State<OperacionalTipoDropdown> {
  TipoOperacional? _tipo;
  OperacionalEstadioConfig _config = const OperacionalEstadioConfig();

  @override
  void initState() {
    super.initState();
    _syncFromEstadio();
  }

  @override
  void didUpdateWidget(covariant OperacionalTipoDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.estadio.id != widget.estadio.id ||
        oldWidget.estadio.tipoOperacional != widget.estadio.tipoOperacional ||
        oldWidget.estadio.operacionalConfig != widget.estadio.operacionalConfig) {
      _syncFromEstadio();
    }
  }

  void _syncFromEstadio() {
    final t = widget.estadio.tipoOperacional;
    _tipo = t == TipoOperacional.indefinido ? null : t;
    if (_tipo != null && !widget.tipos.contains(_tipo)) {
      _tipo = null;
    }
    _config = widget.estadio.operacionalConfig ?? const OperacionalEstadioConfig();
  }

  Future<bool?> _confirmIncluirAdubacao() {
    return showCupertinoDialog<bool>(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('Adubação no plantio'),
        content: const Text(
          'Incluir adubação na mesma data do plantio neste card?',
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Separado depois'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Incluir'),
          ),
        ],
      ),
    );
  }

  Future<void> _persist({
    TipoOperacional? tipo,
    OperacionalEstadioConfig? config,
  }) async {
    final novoTipo = tipo ?? _tipo;
    if (novoTipo == null || novoTipo == TipoOperacional.indefinido) return;

    final cfg = config ?? _config;
    final label = labelOperacionalComAplicacao(
      novoTipo,
      incluirAdubacao: cfg.incluirAdubacao,
      aplicacaoIndice: cfg.aplicacaoIndice,
    );

    final atualizado = widget.estadio.copyWith(
      tipoOperacional: novoTipo,
      operacionalConfig: cfg,
      label: label,
    );
    await widget.onSave(atualizado);

    if (widget.onSyncFungicidaSubcards != null) {
      await widget.onSyncFungicidaSubcards!(atualizado);
    }
  }

  Future<void> _onTipoChanged(TipoOperacional? escolhido) async {
    if (escolhido == null) return;

    var cfg = _config;
    if (escolhido == TipoOperacional.plantio &&
        widget.tipos.contains(TipoOperacional.plantio)) {
      final incluirAdubacao = await _confirmIncluirAdubacao() ?? false;
      cfg = OperacionalEstadioConfig(incluirAdubacao: incluirAdubacao);
    } else if (escolhido == TipoOperacional.fungicidaRecorrente) {
      cfg = _config.copyWith(
        diasRecuperacaoPosEmergente: _config.diasRecuperacaoPosEmergente ?? 5,
        totalAplicacoesFungicida: _config.totalAplicacoesFungicida ?? 1,
        aplicacaoIndice:
            widget.estadio.operacionalConfig?.aplicacaoIndice ??
                _proximoIndiceFungicida(),
      );
    } else if (escolhido == TipoOperacional.dessecacaoPreColheita) {
      cfg = _config.copyWith(
        diasAntesR8: _config.diasAntesR8 ?? 12,
        diasAntecipacaoColheita: _config.diasAntecipacaoColheita ?? 5,
      );
    }

    setState(() {
      _tipo = escolhido;
      _config = cfg;
    });
    await _persist(tipo: escolhido, config: cfg);
  }

  /// Próximo índice livre entre os cards fungicida-recorrente do roteiro
  /// (ex.: V7 vira 1, o próximo card que virar fungicida vira 2...).
  int _proximoIndiceFungicida() {
    final irmaos = templatesFungicidaRoteiro(widget.plano.estadios)
        .where((e) => e.id != widget.estadio.id);
    var maxIndice = 0;
    for (final e in irmaos) {
      final idx = e.operacionalConfig?.aplicacaoIndice ?? 0;
      if (idx > maxIndice) maxIndice = idx;
    }
    return maxIndice + 1;
  }

  String _labelAtual(TipoOperacional tipo) {
    final indice = tipo == _tipo ? _config.aplicacaoIndice : null;
    return labelOperacionalComAplicacao(
      tipo,
      incluirAdubacao: _config.incluirAdubacao,
      aplicacaoIndice: indice,
    );
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = AppTypography.h3.copyWith(
      fontSize: widget.dense ? 17 : 17,
      fontWeight: FontWeight.w700,
      color: context.appTextPrimary,
    );
    final hintStyle = titleStyle.copyWith(
      color: context.appTextSecondary,
      fontWeight: FontWeight.w600,
    );

    if (!widget.isExpanded) {
      // Recolhido: só leitura — a seta de seleção só aparece ao expandir.
      return Text(
        _tipo == null ? widget.hintText : _labelAtual(_tipo!),
        style: _tipo == null ? hintStyle : titleStyle,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );
    }

    return DropdownButtonHideUnderline(
      child: DropdownButton<TipoOperacional>(
        value: _tipo,
        isExpanded: true,
        hint: Text(widget.hintText, style: hintStyle),
        icon: Icon(
          Icons.arrow_drop_down,
          color: context.appTextSecondary,
          size: 22,
        ),
        style: titleStyle,
        borderRadius: BorderRadius.circular(8),
        selectedItemBuilder: (context) => widget.tipos
            .map(
              (tipo) => Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _labelAtual(tipo),
                  style: titleStyle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
            .toList(),
        items: widget.tipos
            .map(
              (tipo) => DropdownMenuItem(
                value: tipo,
                child: Text(
                  tipo.label,
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.appTextPrimary,
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: _onTipoChanged,
      ),
    );
  }
}
