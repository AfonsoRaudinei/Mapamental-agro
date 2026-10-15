#!/usr/bin/env bash
set -euo pipefail

if [[ -z "${SUPABASE_PUBLISHABLE_KEY:-}" ]]; then
  echo "Erro: SUPABASE_PUBLISHABLE_KEY nao informada."
  echo "Use: SUPABASE_PUBLISHABLE_KEY=<chave-publica> sh tool/build_ipa.sh"
  exit 64
fi

SUPABASE_URL="${SUPABASE_URL:-https://wugqcowsujyrspkbupxq.supabase.co}"

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
BUILD="$(
  grep '^version:' "$ROOT_DIR/pubspec.yaml" | sed -E 's/.*\+([0-9]+).*/\1/'
)"
if [[ -z "$BUILD" ]]; then
  echo "Erro: nao foi possivel ler o build number em pubspec.yaml"
  exit 65
fi

flutter build ipa --release \
  --dart-define=SUPABASE_URL="${SUPABASE_URL}" \
  --dart-define=SUPABASE_PUBLISHABLE_KEY="${SUPABASE_PUBLISHABLE_KEY}"

IPA_OUT="$ROOT_DIR/build/ios/ipa"
ROOT_IPA_DIR="$ROOT_DIR/../ipa"
NAMED_IPA="Agrimind_v${BUILD}.ipa"

prune_old_ipas() {
  local dir="$1"
  mkdir -p "$dir"
  find "$dir" -maxdepth 1 -type f -name 'Agrimind_v*.ipa' ! -name "$NAMED_IPA" -delete 2>/dev/null || true
}

cp "$IPA_OUT/agrimind.ipa" "$IPA_OUT/$NAMED_IPA"
prune_old_ipas "$IPA_OUT"
prune_old_ipas "$ROOT_IPA_DIR"
cp "$IPA_OUT/$NAMED_IPA" "$ROOT_IPA_DIR/$NAMED_IPA"

echo ""
echo "IPA pronta (somente build $BUILD no disco):"
echo "  $IPA_OUT/$NAMED_IPA"
echo "  $ROOT_IPA_DIR/$NAMED_IPA"
