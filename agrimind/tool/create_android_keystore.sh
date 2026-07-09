#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
KEYSTORE="${ROOT}/android/app/upload-keystore.jks"
PROPS="${ROOT}/android/key.properties"

if [[ -f "${KEYSTORE}" ]]; then
  echo "Keystore já existe: ${KEYSTORE}"
  exit 0
fi

STORE_PASS="${ANDROID_KEYSTORE_PASSWORD:-agrimind-dev-keystore-change-me}"
KEY_PASS="${ANDROID_KEY_PASSWORD:-${STORE_PASS}}"

keytool -genkeypair \
  -v \
  -keystore "${KEYSTORE}" \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000 \
  -alias upload \
  -storepass "${STORE_PASS}" \
  -keypass "${KEY_PASS}" \
  -dname "CN=Cultiva Mind, OU=Mobile, O=Cultiva Mind, L=Brasil, ST=BR, C=BR"

cat > "${PROPS}" <<EOF
storePassword=${STORE_PASS}
keyPassword=${KEY_PASS}
keyAlias=upload
storeFile=app/upload-keystore.jks
EOF

echo "Keystore criado: ${KEYSTORE}"
echo "Propriedades gravadas em: ${PROPS}"
echo "Altere as senhas antes de publicar na Play Store."
