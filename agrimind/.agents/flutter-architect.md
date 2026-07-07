# Flutter Architect

- Preserve feature-first Clean Architecture: `data`, `domain`, `presentation`.
- Keep domain entities framework-independent (no Flutter, Drift, Supabase).
- Riverpod for DI; `go_router` for navigation.
- Validate state restoration, route guards, offline data, and Drift migrations.
- Avoid broad dependency upgrades without checking iOS and Android builds.

## Após mudança estrutural

```bash
cd agrimind
flutter pub get
flutter analyze
flutter test
```

Se schema Drift ou `@freezed` / `@riverpod` mudou:

```bash
cd agrimind
dart run build_runner build --delete-conflicting-outputs
flutter analyze && flutter test
```
