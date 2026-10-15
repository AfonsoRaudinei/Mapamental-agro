import 'package:uuid/uuid.dart';

import '../../../clients/domain/repositories/clients_repository.dart';
import '../entities/estadio_entity.dart';
import '../entities/estadio_tipo.dart';
import '../entities/programa_operacional_entity.dart';
import '../repositories/plans_repository.dart';
import '../talhao_safra/fungicida_aplicacao_label.dart';
import '../talhao_safra/operacional_linha_tempo_map.dart';
import '../talhao_safra/roteiro_plano_template.dart';
import '../talhao_safra/tipo_operacional.dart';

const _uuid = Uuid();
const _operacionalCodigo = 'Operacional';

/// Entrega o roteiro do plano ao talhão: clona templates em cards do talhão.
class InstanciarRoteiroTalhaoUseCase {
  const InstanciarRoteiroTalhaoUseCase(
    this._plansRepository,
    this._clientsRepository,
  );

  final PlansRepository _plansRepository;
  final ClientsRepository _clientsRepository;

  Future<InstanciarRoteiroResultado> call({
    required String planoId,
    required String talhaoId,
    required String talhaoNome,
  }) async {
    var plano = await _plansRepository.getById(planoId);
    if (plano == null) {
      return const InstanciarRoteiroResultado(
        instanciasCriadas: 0,
        programaOperacionalIds: [],
      );
    }

    final programas = await _plansRepository.listProgramasOperacionais(planoId);
    final doTalhao = programas.where((p) => p.talhaoId == talhaoId).toList();
    var criados = 0;
    final now = DateTime.now();
    final programaIdsNovos = <String>[];

    final tiposInstanciaveis = [
      TipoOperacional.dessecacaoPrePlantio,
      TipoOperacional.plantio,
      TipoOperacional.posEmergente,
      TipoOperacional.dessecacaoPreColheita,
    ];

    for (final tipo in tiposInstanciaveis) {
      if (programaTalhaoPorTipo(doTalhao, talhaoId, tipo) != null) continue;
      final template = templateOperacionalPorTipo(plano.estadios, tipo);
      if (template == null) continue;

      final estadioId = _uuid.v4();
      final label = '${tipo.cardLabel} — $talhaoNome';
      final ordem = ordemCanvasParaTipo(tipo);
      final estadio = EstadioEntity(
        id: estadioId,
        planoId: planoId,
        codigo: _operacionalCodigo,
        tipo: EstadioTipo.operacional,
        label: label,
        ordem: ordem,
        tipoOperacional: tipo,
        operacionalConfig: template.operacionalConfig,
        observacao: observacaoInstanciaTalhao(
          talhaoId,
          templateEstadioId: template.id,
        ),
        createdAt: now,
      );
      await _plansRepository.addEstadio(planoId, estadio);
      final programaId = _uuid.v4();
      await _plansRepository.upsertProgramaOperacional(
        ProgramaOperacionalEntity(
          id: programaId,
          planoId: planoId,
          talhaoId: talhaoId,
          tipo: tipo,
          regraCalculo: _regraParaTipo(tipo),
          ordem: ordem,
          estadioId: estadioId,
          createdAt: now,
          updatedAt: now,
        ),
      );
      programaIdsNovos.add(programaId);
      criados++;
    }

    final fungicidaTemplates = templatesFungicidaRoteiro(plano.estadios);
    if (fungicidaTemplates.isNotEmpty) {
      final programaPaiExistente = programaTalhaoPorTipo(
        doTalhao,
        talhaoId,
        TipoOperacional.fungicidaRecorrente,
      );
      var programaPaiId = programaPaiExistente?.id;
      var fungicidaInstanciados = 0;

      for (final template in fungicidaTemplates) {
        final planoAtual = plano;
        if (planoAtual == null) break;
        if (estadioInstanciaExisteParaTemplate(
          planoAtual.estadios,
          talhaoId,
          template.id,
        )) {
          continue;
        }

        final indice = template.operacionalConfig?.aplicacaoIndice ?? 1;

        if (programaPaiId == null) {
          final paiEstadioId = _uuid.v4();
          final ordemPai =
              ordemCanvasParaTipo(TipoOperacional.fungicidaRecorrente);
          await _plansRepository.addEstadio(
            planoId,
            EstadioEntity(
              id: paiEstadioId,
              planoId: planoId,
              codigo: _operacionalCodigo,
              tipo: EstadioTipo.operacional,
              label:
                  '${TipoOperacional.fungicidaRecorrente.cardLabel} — $talhaoNome',
              ordem: ordemPai,
              tipoOperacional: TipoOperacional.fungicidaRecorrente,
              operacionalConfig: template.operacionalConfig,
              observacao: observacaoInstanciaTalhao(talhaoId),
              createdAt: now,
            ),
          );
          programaPaiId = _uuid.v4();
          await _plansRepository.upsertProgramaOperacional(
            ProgramaOperacionalEntity(
              id: programaPaiId,
              planoId: planoId,
              talhaoId: talhaoId,
              tipo: TipoOperacional.fungicidaRecorrente,
              regraCalculo: RegraCalculoOperacional.recorrente,
              ordem: ordemPai,
              estadioId: paiEstadioId,
              createdAt: now,
              updatedAt: now,
            ),
          );
          programaIdsNovos.add(programaPaiId);
          fungicidaInstanciados++;
        }

        final estadioId = _uuid.v4();
        final ordem = template.ordem;
        await _plansRepository.addEstadio(
          planoId,
          EstadioEntity(
            id: estadioId,
            planoId: planoId,
            codigo: _operacionalCodigo,
            tipo: EstadioTipo.operacional,
            label: '${labelAplicacaoFungicida(indice)} — $talhaoNome',
            ordem: ordem,
            tipoOperacional: TipoOperacional.fungicidaRecorrente,
            operacionalConfig: template.operacionalConfig?.copyWith(
              aplicacaoIndice: indice,
              fungicidaPaiEstadioId: null,
            ),
            observacao: observacaoInstanciaTalhao(
              talhaoId,
              templateEstadioId: template.id,
            ),
            createdAt: now,
          ),
        );
        final programaFilhoId = _uuid.v4();
        await _plansRepository.upsertProgramaOperacional(
          ProgramaOperacionalEntity(
            id: programaFilhoId,
            planoId: planoId,
            talhaoId: talhaoId,
            tipo: TipoOperacional.fungicidaRecorrente,
            regraCalculo: RegraCalculoOperacional.recorrente,
            ordem: indice,
            programaPaiId: programaPaiId,
            estadioId: estadioId,
            aplicacaoIndice: indice,
            createdAt: now,
            updatedAt: now,
          ),
        );
        programaIdsNovos.add(programaFilhoId);
        fungicidaInstanciados++;
        plano = await _plansRepository.getById(planoId) ?? plano;
      }

      if (fungicidaInstanciados > 0) {
        criados += fungicidaInstanciados;
      }
    }

    final idsPersistidos =
        await _clientsRepository.anexarProgramasOperacionaisTalhaoSafra(
      planoId: planoId,
      talhaoId: talhaoId,
      programaIds: programaIdsNovos,
    );

    return InstanciarRoteiroResultado(
      instanciasCriadas: criados,
      programaOperacionalIds: idsPersistidos,
    );
  }
}

class InstanciarRoteiroResultado {
  const InstanciarRoteiroResultado({
    required this.instanciasCriadas,
    required this.programaOperacionalIds,
  });

  final int instanciasCriadas;
  final List<String> programaOperacionalIds;
}

RegraCalculoOperacional _regraParaTipo(TipoOperacional tipo) {
  switch (tipo) {
    case TipoOperacional.dessecacaoPrePlantio:
      return RegraCalculoOperacional.dataFixa;
    case TipoOperacional.plantio:
      return RegraCalculoOperacional.referenciaPlantio;
    case TipoOperacional.posEmergente:
    case TipoOperacional.dessecacaoPreColheita:
      return RegraCalculoOperacional.porDae;
    default:
      return RegraCalculoOperacional.porDae;
  }
}
