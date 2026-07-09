# Codex — Integrar Circular fungicidas no MacBook

> **Como usar:** copie tudo entre `--- INÍCIO DO PROMPT ---` e `--- FIM DO PROMPT ---` e cole no Codex no MacBook.

---

--- INÍCIO DO PROMPT ---

Você é um engenheiro Flutter/Dart sênior trabalhando **no MacBook local** no repositório **Mapamental-agro** (app AgriMind em `agrimind/`).

## Objetivo

Integrar o card **Circular fungicidas** na aba **Refs → Referências**, com ícone de livro **dourado**, navegando para a tela detalhe (estádio → doença → fungicida, Embrapa CT-219).

**Não quebre** o app MacBook existente (auth, catálogo, clientes, CESB, go_router, drift, etc.). Integre de forma cirúrgica.

## Contexto

- Branch remota com os arquivos prontos: `origin/cursor/macbook-refs-integracao-037a`
- PR #6 no GitHub
- Guia: `agrimind/docs/INTEGRACAO_CIRCULAR_FUNGICIDAS_MAC.md`
- Agente design: `agrimind/.agents/dark-mode-designer.md` (tema dark black, cards `#1E1E1E`)
- O MacBook já tem referências (`cesb_detail_page.dart`, etc.) — **adicione** o card, não substitua a feature inteira

## Restrições

1. **Terminal só no MacBook** — execute todos os comandos localmente
2. **Não faça merge cego** da branch cloud na `main` — traga arquivos específicos ou use o script
3. **Preserve** alterações locais — commit snapshot antes de integrar
4. Cards escuros: `DarkSurfaceCard` ou `AppColors.surfaceContainer` — nunca `Card` M3 branco
5. Escopo mínimo — não refatore código não relacionado

---

## Passo 1 — Snapshot do código local

```sh
cd ~/Projects/Mapamental-agro
git status
git add -A
git commit -m "feat(mac): snapshot alterações locais antes integração refs" || true
git fetch origin
```

Se houver alterações não commitadas e o commit falhar por estar vazio, continue.

---

## Passo 2 — Trazer arquivos da Circular fungicidas

**Opção A (preferida)** — script:

```sh
bash agrimind/scripts/macbook-integrate-refs.sh
```

**Opção B** — checkout manual dos arquivos:

```sh
git checkout origin/cursor/macbook-refs-integracao-037a -- \
  agrimind/.agents/references-prompt.md \
  agrimind/docs/INTEGRACAO_CIRCULAR_FUNGICIDAS_MAC.md \
  agrimind/lib/features/references/data/circular_fungicidas_data.dart \
  agrimind/lib/features/references/domain/reference_models.dart \
  agrimind/lib/features/references/presentation/pages/circular_fungicidas_page.dart \
  agrimind/lib/features/references/presentation/widgets/circular_fungicidas_card.dart \
  agrimind/lib/features/references/presentation/widgets/golden_book_icon.dart \
  agrimind/lib/features/references/presentation/widgets/reference_featured_card.dart \
  agrimind/lib/features/references/presentation/circular_fungicidas_screen.dart \
  agrimind/test/references_test.dart
```

**Conflito em `app_colors.dart`?** Não sobrescreva. Adicione manualmente em `AppColors`:

```dart
static const gold = Color(0xFFD4AF37);
static const goldMuted = Color(0xFFCA8A04);
static const goldDark = Color(0xFF92670A);
static const goldSurface = Color(0xFF2A2210);
```

---

## Passo 3 — Integrar card na tela Referências

1. Localize a página principal de referências (ex.: `references_page.dart`, `references_screen.dart` ou rota `/refs`)
2. Adicione import (ajuste path relativo):

```dart
import '../widgets/circular_fungicidas_card.dart';
// ou path correto conforme estrutura local
```

3. No layout, **após o grid 2×2** e **antes do card Campeões CESB**, insira:

```dart
const SizedBox(height: 12),
const CircularFungicidasCard(),
```

Layout esperado:

```
Referências
[ Doenças  | Insetos   ]
[ Nutrição | Fisiologia ]
[ Circular fungicidas  ]  ← livro dourado, chevron
[ Campeões CESB        ]  ← borda dourada (já existente)
```

4. Se usar **go_router**, registre rota para `CircularFungicidasPage` (opcional — o card já navega via `Navigator.push`)

5. **Não remova** CESB, grid existente nem `stage_references_button.dart` do Plano

---

## Passo 4 — Validar

```sh
cd agrimind
flutter pub get
flutter analyze
flutter test
```

Critérios de aprovação:

| Check | Esperado |
|-------|----------|
| `flutter analyze` | 0 issues |
| `flutter test` | 100% passando |
| Card visível | "Circular fungicidas" na aba Refs |
| Ícone | Livro dourado (`GoldenBookIcon`) |
| Navegação | Toque abre tela com estádios VE→R8 |
| Tema | Cards escuros, sem branco |

---

## Passo 5 — Commit e push

```sh
cd ~/Projects/Mapamental-agro
git add -A
git status
git commit -m "feat(refs): integra Circular fungicidas no app MacBook"
git push -u origin cursor/macbook-refs-integracao-037a
```

Se estiver na `main` local, pode commitar na branch atual ou criar:

```sh
git checkout -b cursor/macbook-refs-integracao-037a
git push -u origin cursor/macbook-refs-integracao-037a
```

---

## Entregável final — check-in em %

Ao terminar, responda com:

1. **% conclusão** (meta: 100%)
2. **Arquivos criados/modificados** (lista)
3. **Resultado** de `flutter analyze` e `flutter test`
4. **Screenshot ou confirmação** de que o card aparece na aba Refs
5. **Plano** se < 100% (o que falta e próximo passo)

## Roadmap (não implementar agora — só preparar terreno)

- Insetos, Nutrientes, Fisiologia/hormônios, CESB completo
- Estrutura extensível já em `reference_models.dart` (`ReferenceKind`)

--- FIM DO PROMPT ---
