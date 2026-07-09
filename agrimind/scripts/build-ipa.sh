#!/usr/bin/env bash
# Build IPA AgriMind — somente MacBook (Xcode + certificados)
#
# Uso:
#   bash agrimind/scripts/build-ipa.sh 135           # com checks
#   bash agrimind/scripts/build-ipa.sh 135 --skip-checks   # só build (main local)
#
# Saída: <repo>/ipa/Agrimind_v135.ipa

set -euo pipefail

BUILD_NUMBER="${1:-135}"
SKIP_CHECKS=false

for arg in "$@"; do
  if [[ "$arg" == "--skip-checks" || "$arg" == "-y" ]]; then
    SKIP_CHECKS=true
  fi
done

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
APP_DIR="$REPO_ROOT/agrimind"
IPA_DIR="$REPO_ROOT/ipa"
EXPORT_PLIST="$IPA_DIR/ExportOptions.plist"
OUTPUT_IPA="$IPA_DIR/Agrimind_v${BUILD_NUMBER}.ipa"

cd "$APP_DIR"

echo "==> Build IPA AgriMind — build $BUILD_NUMBER"
echo "    Saída: $OUTPUT_IPA"

# Aviso: branch de integração cloud pode estar incompleta
if [[ -f "lib/core/router/app_router.dart" ]] && ! grep -q "go_router" pubspec.yaml 2>/dev/null; then
  echo ""
  echo "⚠️  AVISO: app_router.dart existe mas go_router não está no pubspec.yaml."
  echo "    Esta branch está INCOMPLETA para build."
  echo "    Use a branch main local (app completo) ou passe --skip-checks."
  echo ""
  if [[ "$SKIP_CHECKS" == false ]]; then
    echo "    Exemplo:"
    echo "      git checkout main"
    echo "      bash agrimind/scripts/build-ipa.sh $BUILD_NUMBER --skip-checks"
    exit 1
  fi
fi

# Atualiza pubspec
CURRENT_NAME="$(grep '^version:' pubspec.yaml | sed 's/version: //' | cut -d+ -f1)"
sed -i '' "s/^version: .*/version: ${CURRENT_NAME}+${BUILD_NUMBER}/" pubspec.yaml
echo "    pubspec.yaml → version: ${CURRENT_NAME}+${BUILD_NUMBER}"

CONSTANTS="$APP_DIR/lib/core/constants/app_constants.dart"
if [[ -f "$CONSTANTS" ]] && grep -q "buildNumber" "$CONSTANTS"; then
  sed -i '' "s/buildNumber = [0-9]*/buildNumber = ${BUILD_NUMBER}/" "$CONSTANTS"
  echo "    app_constants.dart → buildNumber = ${BUILD_NUMBER}"
fi

echo "==> flutter pub get"
flutter pub get

if [[ "$SKIP_CHECKS" == false ]]; then
  echo "==> flutter analyze"
  flutter analyze
  echo "==> flutter test"
  flutter test
else
  echo "==> Pulando analyze/test (--skip-checks)"
fi

mkdir -p "$IPA_DIR"

BUILD_CMD=(flutter build ipa --release --build-number="$BUILD_NUMBER")
if [[ -f "$EXPORT_PLIST" ]]; then
  echo "    Usando ExportOptions.plist"
  BUILD_CMD+=(--export-options-plist="$EXPORT_PLIST")
fi

echo "==> ${BUILD_CMD[*]}"
"${BUILD_CMD[@]}"

SRC="$APP_DIR/build/ios/ipa/agrimind.ipa"
if [[ ! -f "$SRC" ]]; then
  SRC="$(find "$APP_DIR/build/ios/ipa" -name '*.ipa' -type f 2>/dev/null | head -1)"
fi

if [[ -z "${SRC:-}" || ! -f "$SRC" ]]; then
  echo ""
  echo "❌ IPA não gerado."
  echo "   Log: $APP_DIR/build/ios/ipa/Packaging.log"
  echo "   Xcode: open ios/Runner.xcworkspace → Signing & Capabilities"
  exit 1
fi

cp "$SRC" "$OUTPUT_IPA"
cp "$SRC" "$IPA_DIR/agrimind.ipa"

echo ""
echo "✅ IPA build $BUILD_NUMBER gerado:"
echo "   $OUTPUT_IPA"
ls -lh "$OUTPUT_IPA"
