#!/usr/bin/env bash
# Build IPA AgriMind — somente MacBook (Xcode + certificados)
# Uso: bash agrimind/scripts/build-ipa.sh [build_number]

set -euo pipefail

BUILD_NUMBER="${1:-135}"
REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
APP_DIR="$REPO_ROOT/agrimind"

cd "$APP_DIR"

echo "==> Build IPA AgriMind — build $BUILD_NUMBER"

# Atualiza pubspec (version name mantém 1.0.0, build number incrementável)
CURRENT_NAME="$(grep '^version:' pubspec.yaml | sed 's/version: //' | cut -d+ -f1)"
sed -i '' "s/^version: .*/version: ${CURRENT_NAME}+${BUILD_NUMBER}/" pubspec.yaml
echo "    pubspec.yaml → version: ${CURRENT_NAME}+${BUILD_NUMBER}"

echo "==> flutter pub get"
flutter pub get

echo "==> flutter analyze"
flutter analyze

echo "==> flutter test"
flutter test

echo "==> flutter build ipa --release"
flutter build ipa --release --build-number="$BUILD_NUMBER"

IPA_PATH="$APP_DIR/build/ios/ipa/agrimind.ipa"
if [[ -f "$IPA_PATH" ]]; then
  DEST="$REPO_ROOT/builds/agrimind-${BUILD_NUMBER}.ipa"
  mkdir -p "$REPO_ROOT/builds"
  cp "$IPA_PATH" "$DEST"
  echo ""
  echo "✅ IPA gerado:"
  echo "   $DEST"
  ls -lh "$DEST"
else
  echo "⚠️  IPA não encontrado em $IPA_PATH"
  echo "    Verifique signing em Xcode → Runner → Signing & Capabilities"
  exit 1
fi
