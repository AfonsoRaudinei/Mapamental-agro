#!/usr/bin/env bash
# Remove perfis locais antigos do AgriMind para o Xcode baixar de novo (com Apple ID logado).
set -euo pipefail

BUNDLE_ID="${IOS_BUNDLE_ID:-com.cultivamind.agrimind}"
PROFILE_DIR="${HOME}/Library/MobileDevice/Provisioning Profiles"

if [[ ! -d "$PROFILE_DIR" ]]; then
  echo "Nenhuma pasta de perfis em: $PROFILE_DIR"
  exit 0
fi

removed=0
for f in "$PROFILE_DIR"/*.mobileprovision; do
  [[ -f "$f" ]] || continue
  if /usr/bin/security cms -D -i "$f" 2>/dev/null | grep -q "$BUNDLE_ID"; then
    echo "Removendo perfil local: $(basename "$f")"
    rm -f "$f"
    removed=$((removed + 1))
  fi
done

echo "Perfis removidos para ${BUNDLE_ID}: ${removed}"
if [[ "$removed" -gt 0 ]]; then
  echo "Com Apple ID no Xcode, abra Runner.xcworkspace e faça Product → Archive (ou Build) uma vez."
fi
