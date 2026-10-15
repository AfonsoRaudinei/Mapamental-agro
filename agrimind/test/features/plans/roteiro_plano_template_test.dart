import 'package:agrimind/features/plans/domain/entities/estadio_entity.dart';
import 'package:agrimind/features/plans/domain/entities/estadio_tipo.dart';
import 'package:agrimind/features/plans/domain/talhao_safra/roteiro_plano_template.dart';
import 'package:agrimind/features/plans/domain/talhao_safra/tipo_operacional.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('template operacional visível no canvas', () {
    final template = EstadioEntity(
      id: 't1',
      planoId: 'p',
      codigo: 'Operacional',
      tipo: EstadioTipo.operacional,
      label: 'Plantio',
      ordem: 0,
      tipoOperacional: TipoOperacional.plantio,
      observacao: kObservacaoRoteiroTemplate,
      createdAt: DateTime(2026),
    );
    expect(estadioVisivelNoCanvasRoteiro(template), isTrue);
  });

  test('instância do talhão oculta no canvas do roteiro', () {
    final instancia = EstadioEntity(
      id: 'i1',
      planoId: 'p',
      codigo: 'Operacional',
      tipo: EstadioTipo.operacional,
      label: 'Plantio — T1',
      ordem: 0,
      tipoOperacional: TipoOperacional.plantio,
      observacao: observacaoInstanciaTalhao('talhao-1'),
      createdAt: DateTime(2026),
    );
    expect(estadioVisivelNoCanvasRoteiro(instancia), isFalse);
  });

  test('filtro por talhão mostra só instâncias dele', () {
    final instancia = EstadioEntity(
      id: 'i1',
      planoId: 'p',
      codigo: 'Operacional',
      tipo: EstadioTipo.operacional,
      label: 'Plantio — T1',
      ordem: 0,
      tipoOperacional: TipoOperacional.plantio,
      observacao: observacaoInstanciaTalhao('talhao-1'),
      createdAt: DateTime(2026),
    );
    expect(
      estadioVisivelNoCanvasPlano(instancia, filtroTalhaoId: 'talhao-1'),
      isTrue,
    );
    expect(
      estadioVisivelNoCanvasPlano(instancia, filtroTalhaoId: 'outro'),
      isFalse,
    );
  });

  test('rótulo de instância usa nome do talhão', () {
    final instancia = EstadioEntity(
      id: 'i1',
      planoId: 'p',
      codigo: 'Operacional',
      tipo: EstadioTipo.operacional,
      label: 'Plantio — T1',
      ordem: 0,
      tipoOperacional: TipoOperacional.plantio,
      observacao: observacaoInstanciaTalhao('talhao-1'),
      createdAt: DateTime(2026),
    );
    expect(
      rotuloTalhaoInstanciaCanvas(instancia, {'talhao-1': 'Área Norte'}),
      'Área Norte',
    );
    expect(rotuloTalhaoInstanciaCanvas(instancia, const {}), 'Talhão');
  });
}
