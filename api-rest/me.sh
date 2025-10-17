#!/bin/bash
# Obtener el token desde token.sh
token=$(./device-auth.sh)

# echo "$token"

if [ -z "$token" ] || [ "$token" == "null" ]; then
  echo "❌ Error: No se pudo capturar el token desde device-auth.sh"
  exit 1
fi


echo "📡 Consultando información del usuario (/me)..."
curl --silent --location "https://graph.microsoft.com/v1.0/me" \
  --header "Authorization: Bearer $token" | jq