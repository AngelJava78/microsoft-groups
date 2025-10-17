#!/bin/bash
# Get details of a user in Azure Active Directory using Microsoft Graph API
# Usage: ./get-user.sh <username>
# Example: ./get-user.sh

source .env

client_id="$CLIENT_ID"
client_secret="$CLIENT_SECRET"
tenant_id="$TENANT_ID"

scope="https://graph.microsoft.com/.default"

grant_type="client_credentials" 

content_type="application/x-www-form-urlencoded"

# Using client credentials flow
response=$(curl --silent --location "https://login.microsoftonline.com/$tenant_id/oauth2/v2.0/token" \
    --header "Content-Type: $content_type" \
    --data-urlencode "client_id=$client_id" \
    --data-urlencode "client_secret=$client_secret" \
    --data-urlencode "scope=$scope" \
    --data-urlencode "grant_type=$grant_type")
token=$(echo $response | jq -r '.access_token')
# echo "Access Token: $token"
# Get user list in Azure Active Directory using the token

# Exportar el token para que esté disponible en el entorno
echo "$token"