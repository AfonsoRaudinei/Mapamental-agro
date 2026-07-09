#!/usr/bin/env bash
# Integração Circular fungicidas — MacBook
# Uso: bash agrimind/scripts/macbook-integrate-refs.sh

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$REPO_ROOT"

echo "==> Repositório: $REPO_ROOT"

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "==> Commitando alterações locais..."
  git add -A
  git commit -m "feat(mac): snapshot alterações locais antes integração refs"
else
  echo "==> Working tree limpo, seguindo..."
fi

echo "==> Fetch origin..."
git fetch origin

BRANCH="cursor/macbook-refs-integracao-037a"

FILES=(
  agrimind/.agents/references-prompt.md
  agrimind/docs/INTEGRACAO_CIRCULAR_FUNGICIDAS_MAC.md
  agrimind/lib/features/references/data/circular_fungicidas_data.dart
  agrimind/lib/features/references/domain/reference_models.dart
  agrimind/lib/features/references/presentation/pages/circular_fungicidas_page.dart
  agrimind/lib/features/references/presentation/widgets/circular_fungicidas_card.dart
  agrimind/lib/features/references/presentation/widgets/golden_book_icon.dart
  agrimind/lib/features/references/presentation/widgets/reference_featured_card.dart
  agrimind/lib/features/references/presentation/circular_fungicidas_screen.dart
  agrimind/test/references_test.dart
)

echo "==> Trazendo arquivos de origin/$BRANCH..."
git checkout "origin/$BRANCH" -- "${FILES[@]}" 2>/dev/null || {
  echo "Branch $BRANCH não encontrada. Tentando origin/cursor/circular-fungicidas-refs-037a..."
  git checkout origin/cursor/circular-fungicidas-refs-037a -- "${FILES[@]}"
}

echo ""
echo "✅ Arquivos copiados."
echo ""
echo "Próximo passo manual:"
echo "  1. Abra sua references_page.dart"
echo "  2. Adicione: const CircularFungicidasCard(),"
echo "  3. Veja agrimind/docs/INTEGRACAO_CIRCULAR_FUNGICIDAS_MAC.md"
echo ""
echo "Validar:"
echo "  cd agrimind && flutter pub get && flutter analyze && flutter test"
