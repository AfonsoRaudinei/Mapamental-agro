import 'dart:convert';

/// Parâmetros extras do card operacional no canvas (fungicida, dessecação R8, plantio).
class OperacionalEstadioConfig {
  const OperacionalEstadioConfig({
    this.incluirAdubacao = false,
    this.diasRecuperacaoPosEmergente,
    this.totalAplicacoesFungicida,
    this.intervaloFungicidaDias,
    this.diasAntesR8,
    this.diasAntecipacaoColheita,
    this.fungicidaPaiEstadioId,
    this.aplicacaoIndice,
    this.geradoDoCronograma = false,
    this.dataSobrescritaManualmente = false,
    this.dataReferenciaCronograma,
  });

  final bool incluirAdubacao;
  final int? diasRecuperacaoPosEmergente;
  final int? totalAplicacoesFungicida;
  final int? intervaloFungicidaDias;
  final int? diasAntesR8;
  final int? diasAntecipacaoColheita;
  final String? fungicidaPaiEstadioId;
  final int? aplicacaoIndice;
  final bool geradoDoCronograma;
  final bool dataSobrescritaManualmente;
  final DateTime? dataReferenciaCronograma;

  bool get isSubcardFungicida =>
      fungicidaPaiEstadioId != null && aplicacaoIndice != null;

  OperacionalEstadioConfig copyWith({
    bool? incluirAdubacao,
    int? diasRecuperacaoPosEmergente,
    int? totalAplicacoesFungicida,
    int? intervaloFungicidaDias,
    int? diasAntesR8,
    int? diasAntecipacaoColheita,
    String? fungicidaPaiEstadioId,
    int? aplicacaoIndice,
    bool? geradoDoCronograma,
    bool? dataSobrescritaManualmente,
    DateTime? dataReferenciaCronograma,
  }) {
    return OperacionalEstadioConfig(
      incluirAdubacao: incluirAdubacao ?? this.incluirAdubacao,
      diasRecuperacaoPosEmergente:
          diasRecuperacaoPosEmergente ?? this.diasRecuperacaoPosEmergente,
      totalAplicacoesFungicida:
          totalAplicacoesFungicida ?? this.totalAplicacoesFungicida,
      intervaloFungicidaDias:
          intervaloFungicidaDias ?? this.intervaloFungicidaDias,
      diasAntesR8: diasAntesR8 ?? this.diasAntesR8,
      diasAntecipacaoColheita:
          diasAntecipacaoColheita ?? this.diasAntecipacaoColheita,
      fungicidaPaiEstadioId:
          fungicidaPaiEstadioId ?? this.fungicidaPaiEstadioId,
      aplicacaoIndice: aplicacaoIndice ?? this.aplicacaoIndice,
      geradoDoCronograma: geradoDoCronograma ?? this.geradoDoCronograma,
      dataSobrescritaManualmente:
          dataSobrescritaManualmente ?? this.dataSobrescritaManualmente,
      dataReferenciaCronograma:
          dataReferenciaCronograma ?? this.dataReferenciaCronograma,
    );
  }

  Map<String, Object?> toJson() => {
        'incluirAdubacao': incluirAdubacao,
        if (diasRecuperacaoPosEmergente != null)
          'diasRecuperacaoPosEmergente': diasRecuperacaoPosEmergente,
        if (totalAplicacoesFungicida != null)
          'totalAplicacoesFungicida': totalAplicacoesFungicida,
        if (intervaloFungicidaDias != null)
          'intervaloFungicidaDias': intervaloFungicidaDias,
        if (diasAntesR8 != null) 'diasAntesR8': diasAntesR8,
        if (diasAntecipacaoColheita != null)
          'diasAntecipacaoColheita': diasAntecipacaoColheita,
        if (fungicidaPaiEstadioId != null)
          'fungicidaPaiEstadioId': fungicidaPaiEstadioId,
        if (aplicacaoIndice != null) 'aplicacaoIndice': aplicacaoIndice,
        if (geradoDoCronograma) 'geradoDoCronograma': true,
        if (dataSobrescritaManualmente) 'dataSobrescritaManualmente': true,
        if (dataReferenciaCronograma != null)
          'dataReferenciaCronograma':
              dataReferenciaCronograma!.toIso8601String(),
      };

  static OperacionalEstadioConfig? fromJsonString(String? raw) {
    if (raw == null || raw.trim().isEmpty) return null;
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return OperacionalEstadioConfig(
        incluirAdubacao: map['incluirAdubacao'] == true,
        diasRecuperacaoPosEmergente: map['diasRecuperacaoPosEmergente'] as int?,
        totalAplicacoesFungicida: map['totalAplicacoesFungicida'] as int?,
        intervaloFungicidaDias: map['intervaloFungicidaDias'] as int?,
        diasAntesR8: map['diasAntesR8'] as int?,
        diasAntecipacaoColheita: map['diasAntecipacaoColheita'] as int?,
        fungicidaPaiEstadioId: map['fungicidaPaiEstadioId'] as String?,
        aplicacaoIndice: map['aplicacaoIndice'] as int?,
        geradoDoCronograma: map['geradoDoCronograma'] == true,
        dataSobrescritaManualmente:
            map['dataSobrescritaManualmente'] == true,
        dataReferenciaCronograma: _parseDate(map['dataReferenciaCronograma']),
      );
    } catch (_) {
      return null;
    }
  }

  String toJsonString() => jsonEncode(toJson());

  static DateTime? _parseDate(Object? raw) {
    if (raw is! String || raw.isEmpty) return null;
    return DateTime.tryParse(raw);
  }
}
