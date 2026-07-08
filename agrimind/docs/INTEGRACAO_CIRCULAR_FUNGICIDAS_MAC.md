# Integração MacBook — Circular fungicidas

Guia para trazer o card **Circular fungicidas** ao app completo do MacBook.

## Pré-requisito

Seu Mac tem alterações locais não commitadas. **Commit primeiro**, depois integre.

---

## Passo 1 — Commit local (MacBook)

Cole **uma linha por vez**:

```sh
cd ~/Projects/Mapamental-agro
git status
git add -A
git commit -m "feat(mac): snapshot alterações locais antes integração refs"
```

Se já commitou antes, pule este passo.

---

## Passo 2 — Buscar branch de integração

```sh
git fetch origin
git checkout -b cursor/macbook-refs-integracao-037a origin/cursor/macbook-refs-integracao-037a
```

Se a branch local já existir:

```sh
git checkout cursor/macbook-refs-integracao-037a
git pull origin cursor/macbook-refs-integracao-037a
```

**Alternativa (ficar na sua main local):** traga só os arquivos novos:

```sh
git fetch origin
git checkout origin/cursor/macbook-refs-integracao-037a -- \
  agrimind/.agents/references-prompt.md \
  agrimind/docs/INTEGRACAO_CIRCULAR_FUNGICIDAS_MAC.md \
  agrimind/lib/features/references/data/circular_fungicidas_data.dart \
  agrimind/lib/features/references/domain/reference_models.dart \
  agrimind/lib/features/references/presentation/pages/circular_fungicidas_page.dart \
  agrimind/lib/features/references/presentation/widgets/circular_fungicidas_card.dart \
  agrimind/lib/features/references/presentation/widgets/golden_book_icon.dart \
  agrimind/lib/features/references/presentation/widgets/reference_featured_card.dart \
  agrimind/lib/core/theme/app_colors.dart \
  agrimind/test/references_test.dart
```

> Se `app_colors.dart` conflitar, adicione manualmente as cores `gold`, `goldMuted`, `goldDark`, `goldSurface` em `AppColors`.

---

## Passo 3 — Integrar card na tela Referências

Abra sua página de referências (ex.: `references_page.dart` ou similar).

### 3a. Import

```dart
import '../widgets/circular_fungicidas_card.dart';
```

### 3b. Adicionar card (após o grid 2×2, antes do CESB)

```dart
const SizedBox(height: 12),
const CircularFungicidasCard(),
```

Posição sugerida (igual ao design):

```
[ Grid: Doenças | Insetos ]
[ Nutrição | Fisiologia   ]
[ Circular fungicidas     ]  ← NOVO (livro dourado)
[ Campeões CESB           ]
```

### 3c. Cores douradas em AppColors (se ainda não existirem)

```dart
static const gold = Color(0xFFD4AF37);
static const goldMuted = Color(0xFFCA8A04);
static const goldDark = Color(0xFF92670A);
static const goldSurface = Color(0xFF2A2210);
```

---

## Passo 4 — Validar

```sh
cd agrimind
flutter pub get
flutter analyze
flutter test
```

---

## Passo 5 — Commit e push

```sh
cd ~/Projects/Mapamental-agro
git add -A
git commit -m "feat(refs): integra Circular fungicidas no app MacBook"
git push -u origin cursor/macbook-refs-integracao-037a
```

---

## Arquivos entregues

| Arquivo | Função |
|---------|--------|
| `widgets/circular_fungicidas_card.dart` | Card plug-and-play |
| `pages/circular_fungicidas_page.dart` | Tela detalhe VE→R8 |
| `widgets/golden_book_icon.dart` | Ícone livro dourado |
| `data/circular_fungicidas_data.dart` | Dados Embrapa CT-219 |
| `domain/reference_models.dart` | Modelos extensíveis |

## Script automático

```sh
bash agrimind/scripts/macbook-integrate-refs.sh
```
