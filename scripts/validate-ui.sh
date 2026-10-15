#!/usr/bin/env bash
# Validação padrão — modo black / lab templates / análise de solo
# Uso (na raiz do repo): bash scripts/validate-ui.sh

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT/agrimind"

resolve_flutter() {
  if command -v flutter >/dev/null 2>&1; then
    command -v flutter
    return 0
  fi

  local candidates=(
    "$ROOT/agrimind/.fvm/flutter_sdk/bin/flutter"
    "$ROOT/.fvm/flutter_sdk/bin/flutter"
    "$HOME/fvm/default/bin/flutter"
    "$HOME/flutter/bin/flutter"
    "$HOME/dev/flutter/bin/flutter"
    "$HOME/development/flutter/bin/flutter"
    "$HOME/Developer/flutter/bin/flutter"
    "/opt/homebrew/bin/flutter"
    "/usr/local/bin/flutter"
  )

  for candidate in "${candidates[@]}"; do
    if [[ -x "$candidate" ]]; then
      echo "$candidate"
      return 0
    fi
  done

  return 1
}

FLUTTER="$(resolve_flutter || true)"

if [[ -z "${FLUTTER:-}" ]]; then
  cat <<'EOF' >&2
❌ Flutter não encontrado no PATH.

No MacBook, instale ou exponha o Flutter e tente de novo:

  # Opção A — já tem Flutter, só falta no PATH (comum no Mac):
  export PATH="$HOME/dev/flutter/bin:$PATH"
  # ou:
  export PATH="$HOME/flutter/bin:$PATH"

  # Opção B — instalar Flutter (primeira vez):
  git clone https://github.com/flutter/flutter.git -b stable "$HOME/flutter"
  export PATH="$HOME/flutter/bin:$PATH"
  flutter doctor

Depois rode novamente:
  bash scripts/validate-ui.sh
EOF
  exit 127
fi

echo "==> Flutter: $FLUTTER"
"$FLUTTER" --version | head -1

echo "==> flutter pub get"
"$FLUTTER" pub get

echo "==> flutter analyze"
"$FLUTTER" analyze

echo "==> flutter test"
"$FLUTTER" test

echo ""
echo "✅ Validação concluída: analyze 0 issues, todos os testes passando."
