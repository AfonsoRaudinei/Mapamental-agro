import 'package:freezed_annotation/freezed_annotation.dart';

import 'estadio_tipo.dart';
import 'operacional_estadio_config.dart';
import 'produto_aplicacao_entity.dart';
import '../talhao_safra/tipo_operacional.dart';

part 'estadio_entity.freezed.dart';

/// Entidade Estádio fenológico dentro de um Plano.
///
/// Códigos disponíveis:
/// VE, VC, V1–V7, R1, R2, R3, R4, R5.1, R5.3, R5.5, R6, R7, R8
///
/// Observação: `Operacional` é um bloco especial fora da sequência fenológica.
@freezed
class EstadioEntity with _$EstadioEntity {
  const factory EstadioEntity({
    required String id,
    required String planoId,
    required String codigo, // 'VE','VC','V1'...'R8' ou 'Operacional'
    @Default(EstadioTipo.fenologico) EstadioTipo tipo,
    required String label, // editável pelo técnico (padrão = codigo)
    required int ordem,
    DateTime? dataAplicacao,
    String? imageLocalPath,
    String? observacao,
    TipoOperacional? tipoOperacional,
    OperacionalEstadioConfig? operacionalConfig,
    required DateTime createdAt,
    // Produtos eager-loaded para o canvas
    @Default([]) List<ProdutoAplicacaoEntity> produtos,
  }) = _EstadioEntity;
}

extension EstadioEntityX on EstadioEntity {
  bool get isOperacional =>
      tipo == EstadioTipo.operacional || codigo == 'Operacional';

  bool get isSementes =>
      tipo == EstadioTipo.sementes || codigo == 'Sementes';

  bool get isFenologico => tipo == EstadioTipo.fenologico && !isSementes;

  bool get isSubcardFungicida =>
      operacionalConfig?.isSubcardFungicida ?? false;

  bool get operacionalTipoIndefinido =>
      isOperacional &&
      (tipoOperacional == null || tipoOperacional == TipoOperacional.indefinido);
}

