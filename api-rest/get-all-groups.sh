#!/bin/bash
# Get all groups in Azure Active Directory using Microsoft Graph API

# Obtener el token desde token.sh
token=$(./token.sh)

# Get all groups
curl --silent --location "https://graph.microsoft.com/v1.0/groups" \
    --header "Authorization: Bearer $token" > temp_groups.json

echo "Fetching all groups:"
echo "ID                                    DisplayName"
echo "--------------------------------------------------------------------------------------------------------------------------------"
jq -r '
  .value[] |
  [ .id, .displayName ] |
  @tsv
' "temp_groups.json" | column -t -s $'\t'