#!/usr/bin/env bash
# Gera a IPA de release do AgriMind.
# Uso (de qualquer pasta):  sh agrimind/tool/build_ipa.sh   ou   sh tool/build_ipa.sh
# A chave publicável é lida de ../sup.rtf (pasta "Cultiva Mind") quando
# SUPABASE_PUBLISHABLE_KEY não for informada. Placeholders são recusados.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

SUPABASE_URL="${SUPABASE_URL:-https://wugqcowsujyrspkbupxq.supabase.co}"
SUP_RTF="${SUP_RTF:-$ROOT_DIR/../sup.rtf}"

# ── 1. Chave publicável ──────────────────────────────────────────────────────
KEY="${SUPABASE_PUBLISHABLE_KEY:-}"
if [[ -z "$KEY" && -f "$SUP_RTF" ]]; then
  KEY="$(grep -Eo 'sb_publishable_[A-Za-z0-9_-]+' "$SUP_RTF" | head -1 || true)"
  if [[ -z "$KEY" ]]; then
    KEY="$(grep -Eo 'eyJ[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+' "$SUP_RTF" | head -1 || true)"
  fi
fi
if [[ -z "$KEY" ]]; then
  echo "Erro: chave publicável não encontrada."
  echo "Coloque a chave em $SUP_RTF ou rode:"
  echo "  export SUPABASE_PUBLISHABLE_KEY='sb_publishable_...'"
  exit 64
fi
if [[ "$KEY" == *"<"* || "$KEY" == *">"* || "$KEY" == *" "* ]] ||
   ! [[ "$KEY" =~ ^(sb_publishable_[A-Za-z0-9_-]+|eyJ[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+)$ ]]; then
  echo "Erro: SUPABASE_PUBLISHABLE_KEY parece um placeholder ou está inválida."
  echo "Use a chave real (sb_publishable_... ou eyJ...)."
  exit 64
fi
echo "Chave publicável: ${KEY:0:18}… (ok)"

# ── 2. Build number > último registrado em agentipa.md ──────────────────────
BUILD="$(grep '^version:' pubspec.yaml | sed -E 's/.*\+([0-9]+).*/\1/')"
if [[ -z "$BUILD" ]]; then
  echo "Erro: nao foi possivel ler o build number em pubspec.yaml"
  exit 65
fi
ULTIMO="$(grep -Eo '^\| [0-9]{4}-[0-9]{2}-[0-9]{2} \| [0-9]+ ' agentipa.md |
  awk '{print $4}' | sort -n | tail -1)"
if [[ -n "$ULTIMO" && "$BUILD" -le "$ULTIMO" ]]; then
  echo "Erro: build $BUILD <= último registrado ($ULTIMO) em agentipa.md."
  echo "Ajuste 'version:' em pubspec.yaml para 1.0.0+$((ULTIMO + 1)) ou maior."
  exit 65
fi
echo "Build: $BUILD (último registrado: ${ULTIMO:-—})"

# ── 3. Validação obrigatória ────────────────────────────────────────────────
flutter pub get
flutter analyze
flutter test

# ── 4. IPA ──────────────────────────────────────────────────────────────────
SUPABASE_PUBLISHABLE_KEY="$KEY"
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
