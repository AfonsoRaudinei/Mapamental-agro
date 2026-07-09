# Codex — Corrigir build IPA v135 (MacBook)

> Copie tudo entre `--- INÍCIO ---` e `--- FIM ---` e cole no Codex **no MacBook**.

--- INÍCIO ---

Você é engenheiro Flutter/iOS sênior no MacBook. Repositório: **Cultiva Mind** em `/Users/raudineisilvapereira/dev/Cultiva Mind`.

## Situação atual

1. `git checkout main` **falhou** — há alterações locais não commitadas:
   - `agrimind/ios/Flutter/Debug.xcconfig`, `Release.xcconfig`
   - `agrimind/macos/Flutter/*.xcconfig`
   - `agrimind/pubspec.lock`
   - untracked: `agrimind/ios/Podfile`

2. Build rodou na **branch incompleta** (skeleton cloud):
   - `app_router.dart` existe mas `go_router` não está no `pubspec.yaml`
   - Dependências mínimas (sqflite, riverpod) — **não é o app completo**

3. `flutter build ipa` **falhou no signing**:
   ```
   Building a deployable iOS app requires a selected Development Team
   with a Provisioning Profile
   Developer identity: Apple Development: RAUDINEI AFONSO SILVA PEREIRA (F5285RVKYJ)
   ```

4. `ipa/Agrimind_v135.ipa` **não existe**

## Objetivo

Gerar **`ipa/Agrimind_v135.ipa`** a partir do **app completo na main local** (go_router, auth, phosphor_flutter, 58+ testes), com build number **135** e Circular fungicidas integrado.

---

## Passo 1 — Preservar trabalho local e ir para main

Execute **uma linha por vez**:

```sh
cd "/Users/raudineisilvapereira/dev/Cultiva Mind"
git status
git branch --show-current
```

Commit ou stash **tudo** antes de trocar branch:

```sh
git add -A
git commit -m "wip: snapshot local antes build IPA 135" || git stash push -u -m "wip ipa 135"
```

Se `git checkout main` ainda falhar por Podfile untracked:

```sh
mv agrimind/ios/Podfile agrimind/ios/Podfile.bak 2>/dev/null || true
git checkout main
# Se Podfile.bak era o correto da main, restaure depois: mv agrimind/ios/Podfile.bak agrimind/ios/Podfile
```

Confirme app completo na main:

```sh
grep -E "go_router|phosphor_flutter" agrimind/pubspec.yaml
```

Se **não** aparecer go_router → main local está errada; use `git stash pop` ou branch onde o app completo existia.

---

## Passo 2 — Bump build 135

Em `agrimind/pubspec.yaml`:

```yaml
version: 1.0.0+135
```

(ou mantenha version name atual e só mude o `+135`)

Se existir `agrimind/lib/core/constants/app_constants.dart` com `buildNumber`, setar `135`.

---

## Passo 3 — Corrigir Signing no Xcode (obrigatório)

```sh
cd "/Users/raudineisilvapereira/dev/Cultiva Mind/agrimind"
open ios/Runner.xcworkspace
```

No Xcode:

1. Selecione **Runner** (projeto) → target **Runner**
2. Aba **Signing & Capabilities**
3. Marque **Automatically manage signing**
4. **Team:** selecione sua conta Apple Developer (RAUDINEI / F5285RVKYJ)
5. **Bundle Identifier:** `com.cultivamind.agrimind` (deve ser único na sua conta)
6. Repita para target **RunnerTests** se necessário
7. Feche Xcode

Alternativa CLI (se TEAM_ID conhecido):

```sh
# Descobrir Team ID
security find-identity -v -p codesigning | head -5

# Editar ios/Runner.xcodeproj/project.pbxproj — DEVELOPMENT_TEAM = SEU_TEAM_ID
# Ou usar xcodebuild com -allowProvisioningUpdates
```

---

## Passo 4 — Pods e dependências

```sh
cd "/Users/raudineisilvapereira/dev/Cultiva Mind/agrimind"
flutter clean
flutter pub get
cd ios && pod install && cd ..
```

---

## Passo 5 — Validar app completo (main)

```sh
cd "/Users/raudineisilvapereira/dev/Cultiva Mind/agrimind"
flutter analyze
flutter test
```

Se analyze OK, prossiga. Se falhar, **corrija na main** — não use branch `cursor/macbook-refs-integracao-037a` para build.

---

## Passo 6 — Gerar IPA v135

Atualize script se necessário:

```sh
cd "/Users/raudineisilvapereira/dev/Cultiva Mind"
git fetch origin
git checkout origin/cursor/macbook-refs-integracao-037a -- agrimind/scripts/build-ipa.sh
chmod +x agrimind/scripts/build-ipa.sh
```

Build (com ExportOptions se existir):

```sh
bash agrimind/scripts/build-ipa.sh 135 --skip-checks
```

**Ou manual** (mesmo padrão v131–v134):

```sh
cd agrimind
flutter build ipa --release --build-number=135 \
  --export-options-plist=../ipa/ExportOptions.plist
mkdir -p ../ipa
cp build/ios/ipa/agrimind.ipa ../ipa/Agrimind_v135.ipa
ls -lh ../ipa/Agrimind_v135.ipa
```

Se signing falhar de novo:

```sh
cat build/ios/ipa/Packaging.log | tail -50
flutter build ipa --release --build-number=135 --export-options-plist=../ipa/ExportOptions.plist
```

---

## Passo 7 — Commit e push (opcional)

```sh
cd "/Users/raudineisilvapereira/dev/Cultiva Mind"
git add agrimind/pubspec.yaml agrimind/ios/
git commit -m "chore(release): bump build 135 — IPA Circular fungicidas"
git push origin main
```

**Não commite** o arquivo `.ipa`.

---

## Checklist de sucesso

- [ ] Branch = **main** com `go_router` no pubspec
- [ ] `flutter analyze` = 0 issues
- [ ] Xcode Team selecionado
- [ ] `ipa/Agrimind_v135.ipa` existe
- [ ] Tamanho > 10 MB (não vazio)

## Erros comuns

| Erro | Correção |
|------|----------|
| checkout bloqueado | `git stash push -u` ou commit |
| go_router ausente | voltar para main local completa |
| Development Team | Xcode → Signing → Team |
| Pod install fail | `cd ios && pod deintegrate && pod install` |
| Branch incompleta | **nunca** buildar `cursor/macbook-refs-integracao-037a` skeleton |

## Entregável

Responda com:
1. Branch usada
2. Saída de `ls -lh ipa/Agrimind_v135.ipa`
3. Resultado `flutter analyze` / `test`
4. % conclusão (meta 100%)

--- FIM ---
