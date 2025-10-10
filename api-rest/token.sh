#!/bin/bash
# Get details of a user in Azure Active Directory using Microsoft Graph API
# Usage: ./get-user.sh <username>
# Example: ./get-user.sh
USER=$1
# Get OAuth2 token from Microsoft identity platform using client credentials flow
client_id="f1a6599f-403e-4c5c-be9c-2f2a9d61cc86"
client_secret="~VI8Q~KqO7Vs8jM_qzvcIsnpJy7ge23e.xCKdaLI"
tenant_id="a948d6d9-5e95-4eef-aad6-ff342954f882"
scope="https://graph.microsoft.com/.default"
grant_type="client_credentials" 
content_type="application/x-www-form-urlencoded"
# Using client credentials flow
response=$(curl --silent --location 'https://login.microsoftonline.com/a948d6d9-5e95-4eef-aad6-ff342954f882/oauth2/v2.0/token' \
    --header "Content-Type: $content_tpe" \
    --data-urlencode "client_id=$client_id" \
    --data-urlencode "client_secret=$client_secret" \
    --data-urlencode "scope=$scope" \
    --data-urlencode "grant_type=$grant_type")
token=$(echo $response | jq -r '.access_token')
# echo "Access Token: $token"
# Get user list in Azure Active Directory using the token

# Exportar el token para que esté disponible en el entorno
echo "$token"