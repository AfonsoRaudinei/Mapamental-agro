#!/usr/bin/env bash
# Copia correções modo black/lab de um clone do GitHub para o projeto local (Cultiva Mind).
# Use quando: fatal: refusing to merge unrelated histories
#
# Uso:
#   bash scripts/apply-fixes-to-local.sh "/caminho/para/Cultiva Mind"
#
# Ou, sem ter o repo ainda:
#   git clone -b cursor/macbook-lab-dark-fixes-7428 --depth 1 \
#     https://github.com/AfonsoRaudinei/Mapamental-agro.git /tmp/mapamental-agro
#   bash /tmp/mapamental-agro/scripts/apply-fixes-to-local.sh "$HOME/Cultiva Mind"

set -euo pipefail

SOURCE_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET_ROOT="${1:-}"

if [[ -z "$TARGET_ROOT" ]]; then
  echo "Uso: bash scripts/apply-fixes-to-local.sh \"/caminho/para/Cultiva Mind\"" >&2
  exit 1
fi

if [[ ! -d "$TARGET_ROOT/agrimind" ]]; then
  echo "❌ Pasta agrimind/ não encontrada em: $TARGET_ROOT" >&2
  echo "   Ajuste o caminho — deve ser a raiz onde fica agrimind/" >&2
  exit 1
fi

TARGET_AGRI="$TARGET_ROOT/agrimind"
mkdir -p "$TARGET_ROOT/scripts"
mkdir -p "$TARGET_AGRI/lib/core/widgets"
mkdir -p "$TARGET_AGRI/lib/features/lab/presentation"
mkdir -p "$TARGET_AGRI/lib/features/analysis/presentation"
mkdir -p "$TARGET_AGRI/.agents"
mkdir -p "$TARGET_AGRI/docs"
mkdir -p "$TARGET_AGRI/test"

copy() {
  local src="$1"
  local dst="$2"
  mkdir -p "$(dirname "$dst")"
  cp "$src" "$dst"
  echo "  ✅ $dst"
}

echo "==> Origem:  $SOURCE_ROOT"
echo "==> Destino: $TARGET_ROOT"
echo ""
echo "==> Scripts"
copy "$SOURCE_ROOT/scripts/validate-ui.sh"           "$TARGET_ROOT/scripts/validate-ui.sh"
copy "$SOURCE_ROOT/scripts/check-integration.sh"     "$TARGET_ROOT/scripts/check-integration.sh"
copy "$SOURCE_ROOT/scripts/apply-fixes-to-local.sh"  "$TARGET_ROOT/scripts/apply-fixes-to-local.sh"
chmod +x "$TARGET_ROOT/scripts/"*.sh

echo ""
echo "==> Agentes e docs"
copy "$SOURCE_ROOT/agrimind/.agents/macbook-first-workflow.md" "$TARGET_AGRI/.agents/macbook-first-workflow.md"
copy "$SOURCE_ROOT/agrimind/.agents/dark-mode-designer.md"      "$TARGET_AGRI/.agents/dark-mode-designer.md"
copy "$SOURCE_ROOT/agrimind/docs/MACBOOK-APLICAR-CORRECOES.md" "$TARGET_AGRI/docs/MACBOOK-APLICAR-CORRECOES.md"
copy "$SOURCE_ROOT/agrimind/docs/MACBOOK-INTEGRACAO-GIT.md"     "$TARGET_AGRI/docs/MACBOOK-INTEGRACAO-GIT.md"

echo ""
echo "==> Widgets dark"
for f in dark_surface_card.dart primary_back_link.dart dark_app_bar.dart \
         dark_dropdown_field.dart lab_template_card.dart; do
  copy "$SOURCE_ROOT/agrimind/lib/core/widgets/$f" "$TARGET_AGRI/lib/core/widgets/$f"
done

echo ""
echo "==> Tema"
copy "$SOURCE_ROOT/agrimind/lib/core/theme/theme_dark_black.dart" "$TARGET_AGRI/lib/core/theme/theme_dark_black.dart"
copy "$SOURCE_ROOT/agrimind/lib/core/theme/app_colors.dart"       "$TARGET_AGRI/lib/core/theme/app_colors.dart"

echo ""
echo "==> Telas lab/análise (referência — mesclar com suas telas locais se já existirem)"
copy "$SOURCE_ROOT/agrimind/lib/features/lab/presentation/lab_templates_screen.dart" \
     "$TARGET_AGRI/lib/features/lab/presentation/lab_templates_screen.dart"
copy "$SOURCE_ROOT/agrimind/lib/features/lab/presentation/lab_template_form_screen.dart" \
     "$TARGET_AGRI/lib/features/lab/presentation/lab_template_form_screen.dart"
copy "$SOURCE_ROOT/agrimind/lib/features/analysis/presentation/soil_analysis_screen.dart" \
     "$TARGET_AGRI/lib/features/analysis/presentation/soil_analysis_screen.dart"

echo ""
echo "==> Testes"
copy "$SOURCE_ROOT/agrimind/test/dark_ui_widgets_test.dart"    "$TARGET_AGRI/test/dark_ui_widgets_test.dart"
copy "$SOURCE_ROOT/agrimind/test/lab_analysis_screens_test.dart" "$TARGET_AGRI/test/lab_analysis_screens_test.dart"

echo ""
echo "✅ Arquivos copiados."
echo ""
echo "Próximos passos no Mac:"
echo "  1. export PATH=\"\$HOME/dev/flutter/bin:\$PATH\""
echo "  2. cd \"$TARGET_ROOT\" && bash scripts/check-integration.sh"
echo "  3. cd \"$TARGET_AGRI\" && aplicar widgets nas SUAS telas locais (grep em docs/MACBOOK-APLICAR-CORRECOES.md)"
echo "  4. bash scripts/validate-ui.sh"
echo ""
echo "⚠️  Se você já tem telas de lab/análise locais, use os widgets (PrimaryBackLink, etc.)"
echo "    dentro delas — não substitua seu código inteiro pelas telas de referência."
