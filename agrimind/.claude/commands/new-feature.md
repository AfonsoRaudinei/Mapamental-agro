# new-feature

Guia para criar uma nova feature no AgriMind seguindo Clean Architecture + Riverpod.

## Estrutura de pastas

```
lib/features/<nome>/
  data/
    datasources/      # Drift local + Supabase remoto
    models/           # DTOs e extensões .toEntity() / .fromEntity()
    repositories/     # Implementações dos contratos
  domain/
    entities/         # Entidades puras Dart (sem Flutter, sem Drift, sem Supabase)
    repositories/     # Contratos (interfaces abstratas)
    usecases/         # Um use case por arquivo, retorna Either ou throws
  presentation/
    providers/        # Riverpod providers (StateNotifier / AsyncNotifier)
    pages/            # Páginas com go_router
    widgets/          # Widgets pequenos e reutilizáveis
```

## Regras obrigatórias (agente.md + AGENTS.md)

IDs de plataforma: `docs/platform.md`.

1. Domain não importa Flutter, Supabase nem Drift.
2. UI chama providers; providers chamam use cases.
3. Repositórios escondem a origem dos dados (offline-first: Drift primeiro).
4. Use `const` sempre que possível.
5. Widgets não concentram regra de negócio.
6. Fluxo: evento → estado → renderização.

## Visual (agent.md)

- Tokens: `AppColors`, `AppTypography`, `AppSpacing` — nunca hardcode.
- Bottom sheets: shell padrão (radius 20, drag handle, `isScrollControlled: true`).
- Cards: radius ≤ 16.
- Modo dark: `AppColors.backgroundDark`, `surfaceDark`, `borderDark`.
- Sem gradientes ornamentais, sem seções hero, sem layout web.

## Checklist de saída

- [ ] Entidade criada em `domain/entities/`
- [ ] Contrato de repositório em `domain/repositories/`
- [ ] Use case(s) em `domain/usecases/`
- [ ] Datasource local (Drift) em `data/datasources/`
- [ ] Repositório implementado em `data/repositories/`
- [ ] Provider Riverpod criado em `presentation/providers/`
- [ ] Página e widgets em `presentation/`
- [ ] Rota registrada no go_router
- [ ] `flutter analyze` limpo
- [ ] Testes de unidade para use cases
