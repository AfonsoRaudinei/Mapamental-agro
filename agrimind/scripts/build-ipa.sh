#!/usr/bin/env bash
# Build IPA AgriMind — somente MacBook (Xcode + certificados)
# Uso: bash agrimind/scripts/build-ipa.sh [build_number]
#
# Saída padrão (mesmo padrão v131–v134):
#   <repo>/ipa/Agrimind_v135.ipa

set -euo pipefail

BUILD_NUMBER="${1:-135}"
REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
APP_DIR="$REPO_ROOT/agrimind"
IPA_DIR="$REPO_ROOT/ipa"
EXPORT_PLIST="$IPA_DIR/ExportOptions.plist"
OUTPUT_IPA="$IPA_DIR/Agrimind_v${BUILD_NUMBER}.ipa"

cd "$APP_DIR"

echo "==> Build IPA AgriMind — build $BUILD_NUMBER"
echo "    Saída: $OUTPUT_IPA"

# Atualiza pubspec
CURRENT_NAME="$(grep '^version:' pubspec.yaml | sed 's/version: //' | cut -d+ -f1)"
sed -i '' "s/^version: .*/version: ${CURRENT_NAME}+${BUILD_NUMBER}/" pubspec.yaml
echo "    pubspec.yaml → version: ${CURRENT_NAME}+${BUILD_NUMBER}"

# app_constants.dart (se existir no MacBook)
CONSTANTS="$APP_DIR/lib/core/constants/app_constants.dart"
if [[ -f "$CONSTANTS" ]]; then
  if grep -q "buildNumber" "$CONSTANTS"; then
    sed -i '' "s/buildNumber = [0-9]*/buildNumber = ${BUILD_NUMBER}/" "$CONSTANTS"
    echo "    app_constants.dart → buildNumber = ${BUILD_NUMBER}"
  fi
fi

echo "==> flutter pub get"
flutter pub get

echo "==> flutter analyze"
flutter analyze

echo "==> flutter test"
flutter test

mkdir -p "$IPA_DIR"

BUILD_CMD=(flutter build ipa --release --build-number="$BUILD_NUMBER")
if [[ -f "$EXPORT_PLIST" ]]; then
  echo "    Usando ExportOptions.plist"
  BUILD_CMD+=(--export-options-plist="$EXPORT_PLIST")
fi

echo "==> ${BUILD_CMD[*]}"
"${BUILD_CMD[@]}"

# Flutter gera agrimind.ipa; copiamos com nome versionado
SRC="$APP_DIR/build/ios/ipa/agrimind.ipa"
if [[ ! -f "$SRC" ]]; then
  # fallback: qualquer .ipa em build/ios/ipa
  SRC="$(find "$APP_DIR/build/ios/ipa" -name '*.ipa' -type f 2>/dev/null | head -1)"
fi

if [[ -z "${SRC:-}" || ! -f "$SRC" ]]; then
  echo ""
  echo "❌ IPA não gerado."
  echo "   Verifique: Xcode → Runner → Signing & Capabilities → Team"
  echo "   Log: $APP_DIR/build/ios/ipa/Packaging.log"
  exit 1
fi

cp "$SRC" "$OUTPUT_IPA"
cp "$SRC" "$IPA_DIR/agrimind.ipa"

echo ""
echo "✅ IPA build $BUILD_NUMBER gerado:"
echo "   $OUTPUT_IPA"
ls -lh "$OUTPUT_IPA"
