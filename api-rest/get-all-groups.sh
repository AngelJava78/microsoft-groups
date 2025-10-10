#!/bin/bash
# Get all groups in Azure Active Directory using Microsoft Graph API

# Obtener el token desde token.sh
token=$(./token.sh)

#$GROUP_ID=$1
echo "\n*************************************************\n"
# Esto si devuelve el json
curl --location "https://graph.microsoft.com/v1.0/groups?$filter=groupTypes/any(c:c+eq+'Unified')" \
    --header "Authorization: Bearer $token"

echo "\n*************************************************\n"
GROUPS=$(curl --location "https://graph.microsoft.com/v1.0/groups?$filter=groupTypes/any(c:c+eq+'Unified')" \
    --header "Authorization: Bearer $token")

echo "Grupos:"
# Esto imprime 1000
echo "$GROUPS" | jq '.value[] | {id, displayName}'