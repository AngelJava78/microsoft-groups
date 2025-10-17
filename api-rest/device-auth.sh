#!/bin/bash

source .env

# ========================
# CONFIGURACIÓN DE LA APP
# ========================
client_id="$CLIENT_ID"
client_secret="$CLIENT_SECRET"
tenant_id="$TENANT_ID"
scope="offline_access User.Read Mail.Read"

# ========================
# PASO 1: Solicitar código de dispositivo
# ========================
echo "🔐 Solicitando código de dispositivo..." >&2

device_response=$(curl --silent --request POST \
  --url "https://login.microsoftonline.com/$tenant_id/oauth2/v2.0/devicecode" \
  --header "Content-Type: application/x-www-form-urlencoded" \
  --data "client_id=$client_id" \
  --data "scope=$scope")

device_code=$(echo "$device_response" | jq -r '.device_code')
user_code=$(echo "$device_response" | jq -r '.user_code')
verification_uri=$(echo "$device_response" | jq -r '.verification_uri')
message=$(echo "$device_response" | jq -r '.message')

echo "" >&2
echo "📲 $message" >&2
echo "🔗 URL de verificación: $verification_uri" >&2
echo "🔑 Código de usuario: $user_code" >&2
echo "" >&2

# ========================
# PASO 2: Esperar autenticación del usuario
# ========================
echo "⏳ Esperando autenticación..." >&2

while true; do
  token_response=$(curl --silent --request POST \
    --url "https://login.microsoftonline.com/$tenant_id/oauth2/v2.0/token" \
    --header "Content-Type: application/x-www-form-urlencoded" \
    --data "grant_type=device_code" \
    --data "client_id=$client_id" \
    --data "device_code=$device_code")

  error=$(echo "$token_response" | jq -r '.error')

  if [ "$error" == "authorization_pending" ]; then
    sleep 5
  elif [ "$error" == "slow_down" ]; then
    sleep 10
  elif [ "$error" != "null" ]; then
    echo "❌ Error: $error"
    echo "$token_response" | jq
    exit 1
  else
    break
  fi
done

# ========================
# PASO 3: Extraer el token
# ========================
token=$(echo "$token_response" | jq -r '.access_token')

if [ -z "$token" ] || [ "$token" == "null" ]; then
  echo "❌ No se pudo obtener el token de acceso." >&2
  exit 1
fi

# echo "" >&2
echo "✅ Token de acceso obtenido:" >&2
echo "$token"

