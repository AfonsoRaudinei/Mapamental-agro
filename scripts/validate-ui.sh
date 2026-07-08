#!/usr/bin/env bash
# Validação padrão — modo black / lab templates / análise de solo
# Uso: cd agrimind && ../scripts/validate-ui.sh  (ou bash scripts/validate-ui.sh)

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT/agrimind"

echo "==> flutter pub get"
flutter pub get

echo "==> flutter analyze"
flutter analyze

echo "==> flutter test"
flutter test

echo ""
echo "✅ Validação concluída: analyze 0 issues, todos os testes passando."
