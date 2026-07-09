# Build IPA v135 — MacBook (app completo na main)

## Problema

A branch `cursor/macbook-refs-integracao-037a` no GitHub está **incompleta**:
tem arquivos do app Mac (`app_router.dart`, `references_home_page.dart`) mas **não** tem
o resto do projeto (`go_router`, auth, phosphor_flutter, etc.).

Por isso `flutter analyze` falha com 206 erros e o IPA **não é gerado**.

**Solução:** buildar a partir da **`main` local** onde o app completo já passava nos testes.

---

## Comandos (MacBook)

```sh
cd "/Users/raudineisilvapereira/dev/Cultiva Mind"

# 1. Voltar para o app completo
git checkout main

# 2. Se perdeu alterações locais, recupere (se tiver stash/commit)
git stash list
git log --oneline -5

# 3. Atualizar script de build
git fetch origin
git checkout origin/cursor/macbook-refs-integracao-037a -- agrimind/scripts/build-ipa.sh
chmod +x agrimind/scripts/build-ipa.sh

# 4. Bump build 135 no pubspec (main local)
cd agrimind
grep "^version:" pubspec.yaml
# Edite para: version: 1.0.0+135  (ou sua versão +135)

# 5. Gerar IPA (pula analyze — app já validado antes)
cd ..
bash agrimind/scripts/build-ipa.sh 135 --skip-checks

# 6. Confirmar
ls -lh ipa/Agrimind_v135.ipa
```

---

## Se Circular fungicidas não estiver na main

Traga só os arquivos de referência da branch de integração:

```sh
git checkout main
git fetch origin
git checkout origin/cursor/macbook-refs-integracao-037a -- \
  agrimind/lib/features/references/data/circular_fungicidas_data.dart \
  agrimind/lib/features/references/presentation/pages/circular_fungicidas_page.dart \
  agrimind/lib/features/references/presentation/widgets/circular_fungicidas_card.dart \
  agrimind/lib/features/references/presentation/widgets/golden_book_icon.dart \
  agrimind/test/features/references/circular_fungicidas_card_test.dart
```

Integre o card na sua `references_home_page.dart` e depois rode o build.

---

## Commit (opcional)

```sh
git add agrimind/pubspec.yaml agrimind/scripts/build-ipa.sh
git commit -m "chore(release): bump build 135"
git push origin main
```
