# Codex — Build IPA #135 (MacBook)

> Copie entre `--- INÍCIO ---` e `--- FIM ---` e cole no Codex **no MacBook**.

--- INÍCIO ---

Você é engenheiro Flutter/iOS no MacBook. Repositório: **Cultiva Mind** (`agrimind/`).

## Objetivo

Commitar versão **build 135** e gerar IPA de release com Circular fungicidas integrado.

## Pré-requisitos

- Branch: `cursor/macbook-refs-integracao-037a` (já sincronizada)
- Xcode instalado + certificado Apple Developer configurado
- `flutter doctor` sem erros iOS

## Passo 1 — Confirmar branch e status

```sh
cd "/Users/raudineisilvapereira/dev/Cultiva Mind"
git status
git pull origin cursor/macbook-refs-integracao-037a
```

## Passo 2 — Bump build number 135

Em `agrimind/pubspec.yaml`:

```yaml
version: 1.0.0+135
```

Se existir `agrimind/lib/core/constants/app_constants.dart` com `buildNumber`, atualize para `135` também.

## Passo 3 — Validar

```sh
cd agrimind
flutter pub get
flutter analyze
flutter test
```

## Passo 4 — Gerar IPA

```sh
cd "/Users/raudineisilvapereira/dev/Cultiva Mind"
bash agrimind/scripts/build-ipa.sh 135
```

**Alternativa manual:**

```sh
cd agrimind
flutter build ipa --release --build-number=135
cp build/ios/ipa/*.ipa ../builds/agrimind-135.ipa
```

Se falhar signing: abra `agrimind/ios/Runner.xcworkspace` no Xcode → Runner → Signing & Capabilities → selecione Team.

## Passo 5 — Commit e push

```sh
cd "/Users/raudineisilvapereira/dev/Cultiva Mind"
git add agrimind/pubspec.yaml
git add agrimind/lib/core/constants/app_constants.dart 2>/dev/null || true
git commit -m "chore(release): bump build 135 — IPA Circular fungicidas"
git push origin cursor/macbook-refs-integracao-037a
```

> Não commite o `.ipa` (binário). Só version bump + código.

## Entregável

- IPA em `builds/agrimind-135.ipa`
- Commit pushado
- Confirme: `flutter build ipa` OK + build number 135 no Xcode/archive

--- FIM ---
