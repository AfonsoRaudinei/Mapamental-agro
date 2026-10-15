import '../entities/estadio_entity.dart';
import '../entities/operacional_estadio_config.dart';

/// Metadados de ligação estádio ↔ cronograma (JSON em [OperacionalEstadioConfig]).
class EstadioCronogramaMetadata {
  const EstadioCronogramaMetadata({
    this.geradoDoCronograma = false,
    this.dataSobrescritaManualmente = false,
    this.dataReferenciaCronograma,
  });

  final bool geradoDoCronograma;
  final bool dataSobrescritaManualmente;
  final DateTime? dataReferenciaCronograma;

  EstadioCronogramaMetadata copyWith({
    bool? geradoDoCronograma,
    bool? dataSobrescritaManualmente,
    DateTime? dataReferenciaCronograma,
  }) {
    return EstadioCronogramaMetadata(
      geradoDoCronograma: geradoDoCronograma ?? this.geradoDoCronograma,
      dataSobrescritaManualmente:
          dataSobrescritaManualmente ?? this.dataSobrescritaManualmente,
      dataReferenciaCronograma:
          dataReferenciaCronograma ?? this.dataReferenciaCronograma,
    );
  }
}

EstadioCronogramaMetadata lerMetadataCronograma(EstadioEntity estadio) {
  final cfg = estadio.operacionalConfig;
  if (cfg == null) {
    return _fromObservacaoLegada(estadio.observacao);
  }
  return EstadioCronogramaMetadata(
    geradoDoCronograma: cfg.geradoDoCronograma,
    dataSobrescritaManualmente: cfg.dataSobrescritaManualmente,
    dataReferenciaCronograma: cfg.dataReferenciaCronograma,
  );
}

EstadioCronogramaMetadata _fromObservacaoLegada(String? obs) {
  if (obs == null || !obs.contains('auto=1')) {
    return const EstadioCronogramaMetadata();
  }
  return const EstadioCronogramaMetadata(geradoDoCronograma: true);
}

bool estadioDivergeDoCronograma(EstadioEntity estadio) {
  final meta = lerMetadataCronograma(estadio);
  if (!meta.geradoDoCronograma) return false;
  if (meta.dataSobrescritaManualmente) return true;
  final ref = meta.dataReferenciaCronograma;
  final atual = estadio.dataAplicacao;
  if (ref == null || atual == null) return false;
  return !_sameDay(ref, atual);
}

EstadioEntity marcarGeradoDoCronograma(
  EstadioEntity estadio,
  DateTime dataCalculada,
) {
  final cfg = estadio.operacionalConfig ?? const OperacionalEstadioConfig();
  final meta = EstadioCronogramaMetadata(
    geradoDoCronograma: true,
    dataSobrescritaManualmente: cfg.dataSobrescritaManualmente,
    dataReferenciaCronograma: dataCalculada,
  );
  return estadio.copyWith(
    operacionalConfig: cfg.mergeCronograma(meta),
    dataAplicacao: cfg.dataSobrescritaManualmente
        ? estadio.dataAplicacao
        : dataCalculada,
  );
}

EstadioEntity aplicarDataCalculadaRespeitandoOverride(
  EstadioEntity estadio,
  DateTime dataCalculada,
) {
  final cfg = estadio.operacionalConfig ?? const OperacionalEstadioConfig();
  final meta = lerMetadataCronograma(estadio);
  final novoMeta = meta.copyWith(dataReferenciaCronograma: dataCalculada);
  if (cfg.dataSobrescritaManualmente || meta.dataSobrescritaManualmente) {
    return estadio.copyWith(
      operacionalConfig: cfg.mergeCronograma(novoMeta),
    );
  }
  return estadio.copyWith(
    dataAplicacao: dataCalculada,
    operacionalConfig: cfg.mergeCronograma(
      novoMeta.copyWith(geradoDoCronograma: true),
    ),
  );
}

EstadioEntity marcarDataEditadaManualmente(
  EstadioEntity estadio,
  DateTime novaData,
) {
  final cfg = estadio.operacionalConfig ?? const OperacionalEstadioConfig();
  final meta = lerMetadataCronograma(estadio);
  return estadio.copyWith(
    dataAplicacao: novaData,
    operacionalConfig: cfg.mergeCronograma(
      meta.copyWith(
        geradoDoCronograma: meta.geradoDoCronograma,
        dataSobrescritaManualmente: true,
      ),
    ),
  );
}

bool _sameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

extension OperacionalEstadioConfigCronograma on OperacionalEstadioConfig {
  OperacionalEstadioConfig mergeCronograma(EstadioCronogramaMetadata meta) {
    return copyWith(
      geradoDoCronograma: meta.geradoDoCronograma,
      dataSobrescritaManualmente: meta.dataSobrescritaManualmente,
      dataReferenciaCronograma: meta.dataReferenciaCronograma,
    );
  }
}
