#!/usr/bin/env bash
set -euo pipefail

if [[ -z "${SUPABASE_PUBLISHABLE_KEY:-}" ]]; then
  echo "Erro: SUPABASE_PUBLISHABLE_KEY nao informada."
  echo "Use: SUPABASE_PUBLISHABLE_KEY=<chave-publica> sh tool/build_ipa.sh"
  exit 64
fi

SUPABASE_URL="${SUPABASE_URL:-https://wugqcowsujyrspkbupxq.supabase.co}"

flutter build ipa --release \
  --dart-define=SUPABASE_URL="${SUPABASE_URL}" \
  --dart-define=SUPABASE_PUBLISHABLE_KEY="${SUPABASE_PUBLISHABLE_KEY}"
