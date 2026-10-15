/// Classificação do bloco no plano: fenológico, operacional ou sementes.
enum EstadioTipo {
  fenologico,
  operacional,
  sementes,
}

extension EstadioTipoParsing on EstadioTipo {
  String get storageValue => name;

  static EstadioTipo fromStorage(String? value, {required String codigo}) {
    if (value == EstadioTipo.operacional.name) {
      return EstadioTipo.operacional;
    }
    if (value == EstadioTipo.sementes.name) {
      return EstadioTipo.sementes;
    }
    if (value == EstadioTipo.fenologico.name) {
      return EstadioTipo.fenologico;
    }
    if (codigo == 'Operacional') return EstadioTipo.operacional;
    if (codigo == 'Sementes') return EstadioTipo.sementes;
    return EstadioTipo.fenologico;
  }
}
