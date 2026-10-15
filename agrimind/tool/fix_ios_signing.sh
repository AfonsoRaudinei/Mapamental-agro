#!/usr/bin/env bash
# Corrige assinatura: limpa perfis antigos + abre Xcode (conta Apple obrigatória).
set -euo pipefail

AGRI_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$AGRI_ROOT"

echo "== Limpando perfis de provisionamento antigos =="
sh tool/refresh_ios_profiles.sh

open "$AGRI_ROOT/ios/Runner.xcworkspace"

cat <<'EOF'

Assinatura iOS (obrigatório no Xcode):

  1. Xcode → Settings (⌘,) → Accounts → “+” → Apple ID do time BA2BU25B78.
     (Sem conta aqui o terminal sempre mostra "No Accounts".)

  2. Na conta: clique em “Download Manual Profiles” (se aparecer).

  3. Runner (target) → Signing & Capabilities:
     - Automatically manage signing
     - Team: BA2BU25B78

  4. Product → Clean Build Folder, depois Product → Build (⌘B).
     Se Build passar, feche o Xcode e rode:

       cd agrimind && sh tool/build_ipa.sh

EOF
