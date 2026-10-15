#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
KEYSTORE="${ROOT}/android/app/upload-keystore.jks"
PROPS="${ROOT}/android/key.properties"

if [[ -f "${KEYSTORE}" ]]; then
  echo "Keystore já existe: ${KEYSTORE}"
  exit 0
fi

if [[ -z "${ANDROID_KEYSTORE_PASSWORD:-}" ]]; then
  echo "ANDROID_KEYSTORE_PASSWORD é obrigatório para gerar a keystore de release." >&2
  exit 1
fi

STORE_PASS="${ANDROID_KEYSTORE_PASSWORD}"
KEY_PASS="${STORE_PASS}"

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
echo "Guarde a keystore e as senhas em local seguro antes de publicar na Play Store."
