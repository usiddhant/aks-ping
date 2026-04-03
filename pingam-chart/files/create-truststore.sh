#!/bin/sh

set -e

# ---- Config (edit if needed) ----
JAVA_CACERTS="${JAVA_HOME}/lib/security/cacerts"
TEMP_TRUSTSTORE="/tmp/truststore"
#FINAL_PATH="/var/run/secrets/am/truststore"
FINAL_PATH="/shared/truststore"

# Default Java cacerts password
OLD_PASS="changeit"

# New password you want to set
NEW_PASS="${TRUSTSTORE_PASSWORD:-changeit}"

echo "Copying cacerts to temporary truststore..."
cp "${JAVA_CACERTS}" "${TEMP_TRUSTSTORE}"

echo "Changing truststore password (non-interactive)..."
keytool -storepasswd \
  -keystore "${TEMP_TRUSTSTORE}" \
  -storepass "${OLD_PASS}" \
  -new "${NEW_PASS}" \
  -noprompt

#echo "Ensuring destination directory exists..."
#mkdir -p /var/run/secrets/am

echo "Moving truststore to final location..."
mv "${TEMP_TRUSTSTORE}" "${FINAL_PATH}"

echo "Truststore created at: ${FINAL_PATH}"