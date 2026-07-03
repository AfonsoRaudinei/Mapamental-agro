# Integração — código existente + correções AgriMind

Este guia explica como mesclar um projeto Flutter local (ou do ecossistema SoloForte) com as correções de UX/tema já aplicadas neste repositório.

## O que já está integrado

| Correção | Arquivo |
|----------|---------|
| Tema dark/black padrão | `lib/core/theme/theme_provider.dart` |
| Bridge IDs legados (`dark`/`blue`/`green`) | `lib/core/theme/app_theme.dart` |
| Migração prefs de tema | `lib/core/database/data_importer.dart` |
| Cards escuros na tela Plano | `lib/features/plan/presentation/widgets/stage_card.dart` |
| Controller por estádio | `stage_card.dart` (`ValueKey` + `stage.id`) |
| SQLite persistência | `lib/core/database/app_database.dart` |
| Import JSON de backup | `lib/core/database/data_importer.dart` |

## Passo 1 — Trazer seu código local

```sh
# No seu Mac, dentro do clone Mapamental-agro:
git fetch origin
git checkout cursor/integracao-codigo-cf03   # ou main após merge
git pull

# Copie seus arquivos locais para agrimind/ (exemplo):
rsync -av ~/Projects/AgriMind/lib/ agrimind/lib/
rsync -av ~/Projects/AgriMind/assets/ agrimind/assets/ 2>/dev/null || true
```

## Passo 2 — Aplicar tema escuro (obrigatório)

1. Leia `.agents/dark-mode-designer.md`
2. Substitua cards brancos por `AppColors.surfaceContainer`
3. Use `Theme.of(context).colorScheme` — nunca `Colors.white` em cards no modo escuro
4. Garanta que `main.dart` chama `DataImporter.migrateLegacyThemePreference()`

### IDs de tema legados (SoloForte → AgriMind)

| SoloForte | AgriMind |
|-----------|----------|
| `dark` | `darkBlack` (padrão) |
| `blue` / `green` | `light` |

## Passo 3 — Corrigir tela Plano

Checklist mínimo ao integrar seu `PlanScreen` / `StageCard`:

- [ ] Cada estádio tem `TextEditingController` próprio (keyed por `stage.id`)
- [ ] Label "Nome do estádio" **acima** do input (Column, não Stack)
- [ ] Subtitle "Nenhum produto…" em linha separada do título
- [ ] Cards usam `color: AppColors.surfaceContainer`

## Passo 4 — Importar dados locais

Exporte seu banco/dados como JSON e importe:

```dart
final importer = ref.read(dataImporterProvider);
await importer.importSnapshot({
  'clients': [...],
  'plans': [...],
  'stages': [...],
  'products': [...],
});
```

Formato das chaves: igual às tabelas SQLite (`area_ha`, `plan_id`, `sort_order`, etc.).

## Passo 5 — Validar

```sh
cd agrimind
flutter pub get
flutter analyze    # 0 issues
flutter test       # todos passando
```

## Conflitos comuns

| Conflito | Resolução |
|----------|-----------|
| Dois `ThemeProvider` | Mantenha `lib/core/theme/theme_provider.dart` deste repo |
| Dois bancos (Hive + SQLite) | Migre estádios/produtos via `DataImporter.importSnapshot` |
| Cards brancos persistem | Busque `Colors.white` e `Card(` sem `color` nos widgets Plano |

## Referências

- Agente designer: `.agents/dark-mode-designer.md`
- Platform IDs: `docs/platform.md`
- Validação: `.cursor/skills/agrimind-flutter-check/SKILL.md`
