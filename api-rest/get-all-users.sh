#!/bin/bash
# Get details of a user in Azure Active Directory using Microsoft Graph API
# Usage: ./get-user.sh <username>
# Example: ./get-user.sh

# Obtener el token desde token.sh
token=$(./token.sh)

echo "Fetching all users:"
curl --silent --location "https://graph.microsoft.com/v1.0/users" \
    --header "Authorization: Bearer $token" > users.json

echo "ID                                    DisplayName               UserPrincipalName"
echo "--------------------------------------------------------------------------------------------------------------------------------"

jq -r '
  .value[] |
  [ .id, .displayName, .userPrincipalName ] |
  @tsv
' "users.json" | column -t -s $'\t'