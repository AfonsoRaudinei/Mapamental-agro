import '../talhao_safra/tipo_operacional.dart';

/// Programa operacional persistido — liga talhão, regra de cálculo e card no canvas.
class ProgramaOperacionalEntity {
  const ProgramaOperacionalEntity({
    required this.id,
    required this.planoId,
    required this.talhaoId,
    required this.tipo,
    required this.regraCalculo,
    required this.ordem,
    this.programaPaiId,
    this.estadioId,
    this.aplicacaoIndice,
    this.incluirAdubacao = false,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String planoId;
  final String talhaoId;
  final TipoOperacional tipo;
  final RegraCalculoOperacional regraCalculo;
  final int ordem;
  final String? programaPaiId;
  final String? estadioId;
  final int? aplicacaoIndice;
  final bool incluirAdubacao;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get isAplicacaoFungicida =>
      tipo == TipoOperacional.fungicidaRecorrente &&
      programaPaiId != null &&
      aplicacaoIndice != null;

  bool get isProgramaFungicidaPai =>
      tipo == TipoOperacional.fungicidaRecorrente && programaPaiId == null;

  ProgramaOperacionalEntity copyWith({
    String? id,
    String? planoId,
    String? talhaoId,
    TipoOperacional? tipo,
    RegraCalculoOperacional? regraCalculo,
    int? ordem,
    String? programaPaiId,
    String? estadioId,
    int? aplicacaoIndice,
    bool? incluirAdubacao,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProgramaOperacionalEntity(
      id: id ?? this.id,
      planoId: planoId ?? this.planoId,
      talhaoId: talhaoId ?? this.talhaoId,
      tipo: tipo ?? this.tipo,
      regraCalculo: regraCalculo ?? this.regraCalculo,
      ordem: ordem ?? this.ordem,
      programaPaiId: programaPaiId ?? this.programaPaiId,
      estadioId: estadioId ?? this.estadioId,
      aplicacaoIndice: aplicacaoIndice ?? this.aplicacaoIndice,
      incluirAdubacao: incluirAdubacao ?? this.incluirAdubacao,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
