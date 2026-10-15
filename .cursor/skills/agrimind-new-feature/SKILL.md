---
name: agrimind-new-feature
description: >-
  Cria nova feature no AgriMind seguindo Clean Architecture, Riverpod, Drift e
  go_router. Use para implementar telas, módulos ou fluxos novos no app Flutter.
---

# AgriMind — Nova Feature

Espelha `agrimind/.claude/commands/new-feature.md`.

## Estrutura

```
lib/features/<nome>/
  data/{datasources,models,repositories}/
  domain/{entities,repositories,usecases}/
  presentation/{providers,pages,widgets}/
```

## Regras

1. Domain não importa Flutter, Supabase nem Drift.
2. UI → providers → use cases → repositories.
3. Offline-first: Drift primeiro.
4. Tokens visuais: `AppColors`, `AppTypography`, `AppSpacing`.
5. Bottom sheets: shell `AppBottomSheet`, radius 20, drag handle.

## Passos

1. Criar entity + repository interface + use case(s).
2. Implementar datasource Drift + repository impl.
3. Criar provider Riverpod + page + widgets.
4. Registrar rota em `lib/core/router/app_router.dart`.
5. Validar:

```bash
cd agrimind
flutter analyze && flutter test
```

## Checklist de saída

- [ ] Domain completo (entity, repository, use case)
- [ ] Data completo (datasource, repository impl)
- [ ] Presentation completo (provider, page, widgets)
- [ ] Rota registrada
- [ ] `flutter analyze` limpo
- [ ] Testes de use case
