#!/usr/bin/env bash
# Verifica se a integração lab/dark-mode está completa no Mac.
# Uso: bash scripts/check-integration.sh

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

ok=0
fail=0
warn=0

check_file() {
  local path="$1"
  if [[ -f "$path" ]]; then
    echo "  ✅ $path"
    ok=$((ok + 1))
  else
    echo "  ❌ FALTA: $path"
    fail=$((fail + 1))
  fi
}

echo "==> Estrutura do repo (raiz: $ROOT)"
check_file "scripts/validate-ui.sh"
check_file "scripts/check-integration.sh"
check_file "agrimind/.agents/macbook-first-workflow.md"
check_file "agrimind/.agents/dark-mode-designer.md"
check_file "agrimind/docs/MACBOOK-APLICAR-CORRECOES.md"

echo ""
echo "==> Widgets dark"
check_file "agrimind/lib/core/widgets/primary_back_link.dart"
check_file "agrimind/lib/core/widgets/dark_app_bar.dart"
check_file "agrimind/lib/core/widgets/dark_dropdown_field.dart"
check_file "agrimind/lib/core/widgets/lab_template_card.dart"
check_file "agrimind/lib/core/widgets/dark_surface_card.dart"

echo ""
echo "==> Telas lab/análise"
check_file "agrimind/lib/features/lab/presentation/lab_templates_screen.dart"
check_file "agrimind/lib/features/lab/presentation/lab_template_form_screen.dart"
check_file "agrimind/lib/features/analysis/presentation/soil_analysis_screen.dart"

echo ""
echo "==> Testes"
check_file "agrimind/test/dark_ui_widgets_test.dart"
check_file "agrimind/test/lab_analysis_screens_test.dart"

echo ""
echo "==> Git branch"
BRANCH="$(git branch --show-current 2>/dev/null || echo '?')"
echo "  Branch atual: $BRANCH"
if git merge-base --is-ancestor 7b8cd4c HEAD 2>/dev/null; then
  echo "  ✅ Commit 7b8cd4c (fix validate-ui) presente no histórico"
  ok=$((ok + 1))
elif git cat-file -e 7b8cd4c^{commit} 2>/dev/null; then
  echo "  ⚠️  Commit 7b8cd4c existe mas pode não estar merged — rode: git merge origin/cursor/macbook-lab-dark-fixes-7428"
  warn=$((warn + 1))
else
  echo "  ❌ Branch cursor/macbook-lab-dark-fixes-7428 NÃO integrado — rode os comandos em docs/MACBOOK-APLICAR-CORRECOES.md seção Git"
  fail=$((fail + 1))
fi

echo ""
echo "==> Flutter"
if command -v flutter >/dev/null 2>&1; then
  echo "  ✅ $(which flutter)"
  ok=$((ok + 1))
elif [[ -x "$HOME/dev/flutter/bin/flutter" ]]; then
  echo "  ⚠️  Flutter em ~/dev/flutter mas fora do PATH — rode: export PATH=\"\$HOME/dev/flutter/bin:\$PATH\""
  warn=$((warn + 1))
else
  echo "  ❌ Flutter não encontrado"
  fail=$((fail + 1))
fi

echo ""
TOTAL=$((ok + fail + warn))
if [[ $fail -eq 0 ]]; then
  echo "✅ Integração OK ($ok ok, $warn avisos). Rode: bash scripts/validate-ui.sh"
  exit 0
else
  echo "❌ Integração incompleta ($fail faltando, $ok ok, $warn avisos)."
  exit 1
fi
