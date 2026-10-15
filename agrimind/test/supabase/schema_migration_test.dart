import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  final migration = File(
    'supabase/migrations/20260620170000_initial_agrimind_schema.sql',
  ).readAsStringSync();

  const protectedTables = [
    'profiles',
    'clients',
    'farms',
    'plots',
    'catalog_products',
    'technical_references',
    'plans',
    'stages',
    'application_products',
  ];

  test('migration cria todas as tabelas e habilita RLS', () {
    for (final table in protectedTables) {
      expect(
        migration,
        contains('create table public.$table'),
        reason: 'Tabela $table ausente',
      );
      expect(
        migration,
        contains('alter table public.$table enable row level security'),
        reason: 'RLS ausente em $table',
      );
    }
  });

  test('tabelas privadas possuem política vinculada ao auth.uid', () {
    const privateTables = [
      'profiles',
      'clients',
      'farms',
      'plots',
      'catalog_products',
      'plans',
      'stages',
      'application_products',
    ];
    for (final table in privateTables) {
      final policyPattern = RegExp(
        'create policy[\\s\\S]+?on public\\.$table[\\s\\S]+?auth\\.uid\\(\\)',
        caseSensitive: false,
      );
      expect(
        policyPattern.hasMatch(migration),
        isTrue,
        reason: 'Política de usuário ausente em $table',
      );
    }
  });

  test('chaves estrangeiras cobrem toda a árvore agronômica', () {
    expect(migration, contains('references public.clients(id)'));
    expect(migration, contains('references public.farms(id)'));
    expect(migration, contains('references public.plans(id)'));
    expect(migration, contains('references public.stages(id)'));
  });
}
