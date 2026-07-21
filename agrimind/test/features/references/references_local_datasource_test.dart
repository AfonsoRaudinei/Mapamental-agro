import 'package:agrimind/core/database/app_database.dart';
import 'package:agrimind/features/references/data/datasources/references_local_datasource.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late ReferencesLocalDatasource datasource;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    datasource = ReferencesLocalDatasource(database);
  });

  tearDown(() => database.close());

  test('seed técnico pode ser consultado por categoria e estádio', () async {
    await datasource.seedIfEmpty();

    expect(await datasource.getByCategoria('doencas'), isNotEmpty);
    expect(await datasource.getByEstadio('doencas', 'R1'), isNotEmpty);
    expect(await datasource.getByEstadio('doencas', 'R8'), isNotEmpty);
    expect(await datasource.getByCategoria('insetos'), isNotEmpty);
    expect(await datasource.getByEstadio('insetos', 'R8'), isNotEmpty);
    expect(await datasource.getByCategoria('nutricao'), isNotEmpty);
    expect(await datasource.getByEstadio('nutricao', 'R5.5'), isNotEmpty);
    expect(await datasource.getByCategoria('fisiologia'), isNotEmpty);
    expect(await datasource.getByEstadio('fisiologia', 'R8'), isNotEmpty);
    expect(await datasource.getCesb(estadio: 'R3'), isNotEmpty);
    expect(await datasource.getCesb(estadio: 'R5.5'), isNotEmpty);
  });

  test('seed de doenças é versionado sem duplicar registros', () async {
    await datasource.seedIfEmpty();
    final primeiraCarga = await datasource.getByCategoria('doencas');

    await datasource.seedIfEmpty();
    final segundaCarga = await datasource.getByCategoria('doencas');

    expect(segundaCarga, hasLength(primeiraCarga.length));
    expect(segundaCarga.map((ref) => ref.id).toSet(), hasLength(18));
    expect(
      segundaCarga.where((ref) => ref.titulo.contains('Ferrugem Asiática')),
      isNotEmpty,
    );
  });

  test('seed de insetos usa somente percentuais para intensidade', () async {
    await datasource.seedIfEmpty();
    final insetos = await datasource.getByCategoria('insetos');
    final texto = insetos
        .map((ref) => '${ref.titulo} ${ref.descricao} ${ref.focoManejo}')
        .join(' ');

    expect(insetos.map((ref) => ref.id).toSet(), hasLength(19));
    expect(insetos.every((ref) => ref.descricao?.contains('%') ?? false), true);
    expect(texto, isNot(contains('indivíduos')));
    expect(texto, isNot(contains('m²')));
    expect(texto, isNot(contains('/m')));
    expect(texto, isNot(contains('NA:')));
  });

  test('seed de nutrição usa percentuais e cobre o ciclo', () async {
    await datasource.seedIfEmpty();
    final nutricao = await datasource.getByCategoria('nutricao');
    final texto = nutricao
        .map((ref) => '${ref.titulo} ${ref.descricao} ${ref.focoManejo}')
        .join(' ');

    expect(nutricao.map((ref) => ref.id).toSet(), hasLength(19));
    expect(nutricao.any((ref) => ref.estadio == 'VE'), true);
    expect(nutricao.any((ref) => ref.estadio == 'R8'), true);
    expect(nutricao.any((ref) => ref.descricao?.contains('%') ?? false), true);
    expect(texto, isNot(contains('kg/t')));
    expect(texto, isNot(contains('L/ha')));
    expect(texto, isNot(contains('kg/ha')));
    expect(texto, isNot(contains('mL/kg')));
  });

  test('seed de fisiologia cobre hormônios por estádio sem doses', () async {
    await datasource.seedIfEmpty();
    final fisiologia = await datasource.getByCategoria('fisiologia');
    final texto = fisiologia
        .map((ref) => '${ref.titulo} ${ref.descricao} ${ref.focoManejo}')
        .join(' ');

    expect(fisiologia.map((ref) => ref.id).toSet(), hasLength(19));
    expect(fisiologia.any((ref) => ref.estadio == 'VE'), true);
    expect(fisiologia.any((ref) => ref.estadio == 'R8'), true);
    expect(texto, contains('Auxinas'));
    expect(texto, contains('Citocininas'));
    expect(texto, contains('Etileno'));
    expect(texto, contains('ABA'));
    expect(texto, isNot(contains('L/ha')));
    expect(texto, isNot(contains('mL/kg')));
  });

  test('seed CESB v3 cobre síntese e cases 2025/2026 sem duplicar', () async {
    await datasource.seedIfEmpty();
    await datasource.seedIfEmpty();

    final cesb = await datasource.getCesb();
    final texto = cesb
        .map(
          (ref) =>
              '${ref.titulo} ${ref.descricao} ${ref.focoManejo} ${ref.praticas} ${ref.padrao} ${ref.destaque} ${ref.fonte} ${ref.safraReferencia} ${ref.resultado} ${ref.local} ${ref.tipoFonte}',
        )
        .join(' ');

    expect(cesb.map((ref) => ref.id).toSet(), hasLength(59));
    expect(cesb.any((ref) => ref.estadio == 'VE'), true);
    expect(cesb.any((ref) => ref.estadio == 'R1'), true);
    expect(cesb.any((ref) => ref.estadio == 'R5.5'), true);
    expect(cesb.any((ref) => ref.estadio == 'V8'), true);
    expect(texto, contains('120 sc/ha'));
    expect(texto, contains('Quase 100%'));
    expect(texto, contains('R1'));
    expect(texto, contains('PMG'));
    expect(texto, contains('Constatação técnica CESB'));
    expect(texto, contains('2025/2026'));
    expect(texto, isNot(matches(RegExp(r'\bNA\b'))));
    expect(texto, isNot(contains('Llenado')));
    expect(texto, isNot(contains('Recomendamos')));
  });

  test('cases CESB 2025/2026 têm fonte, safra e resultado', () async {
    await datasource.seedIfEmpty();
    final cesb = await datasource.getCesb();
    final cases = cesb.where((ref) => ref.id.startsWith('cesb-2026-')).toList();
    final titulos = cases.map((ref) => ref.titulo).join(' ');

    expect(titulos, contains('Case Sul/Nacional'));
    expect(titulos, contains('Case Nordeste'));
    expect(titulos, contains('Case Irrigado Nacional'));
    expect(titulos, contains('Case Norte'));
    expect(titulos, contains('Case Sudeste'));
    expect(titulos, contains('Case Centro-Oeste'));
    expect(cases.every((ref) => ref.fonte?.isNotEmpty ?? false), true);
    expect(cases.every((ref) => ref.safraReferencia == '2025/2026'), true);
    expect(
        cases.every((ref) => ref.resultado?.contains('sc/ha') ?? false), true);
    expect(cases.every((ref) => ref.local?.isNotEmpty ?? false), true);
    expect(cases.every((ref) => ref.tipoFonte == 'Case CESB'), true);
  });

  test('filtros por estádio retornam cases CESB novos', () async {
    await datasource.seedIfEmpty();

    final v4 = await datasource.getCesb(estadio: 'V4');
    final r1 = await datasource.getCesb(estadio: 'R1');
    final r3 = await datasource.getCesb(estadio: 'R3');
    final r53 = await datasource.getCesb(estadio: 'R5.3');

    expect(v4.any((ref) => ref.id.startsWith('cesb-2026-')), true);
    expect(r1.any((ref) => ref.id.startsWith('cesb-2026-')), true);
    expect(r3.any((ref) => ref.id.startsWith('cesb-2026-')), true);
    expect(r53.any((ref) => ref.id.startsWith('cesb-2026-')), true);
  });
}
