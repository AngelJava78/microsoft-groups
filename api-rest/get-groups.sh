#!/bin/bash
# Get all Microsoft 365 groups from Azure AD using Microsoft Graph API

# Obtener el token desde token.sh
token=$(./token.sh)

# Get all groups
curl --silent --location "https://graph.microsoft.com/v1.0/groups" \
    --header "Authorization: Bearer $token" > temp_groups.json

echo "Showing all groups:"
jq '.value[] | {id, displayName}' temp_groups.json

# Optionally, filter to show only Microsoft 365 groups (Unified groups)
# echo "Showing only Microsoft 365 (Unified) groups:"
# jq '.value[] | select(.groupTypes[]? == "Unified") | {id, displayName}' temp_groups.json    



### BASH NO ADMITE FILTROS AVANZADOS EN LA URL, ASI QUE HAY QUE TRAERLO TODO Y FILTRARLO LUEGO

# Get Microsoft 365 (Unified) groups
# curl --silent --location "https://graph.microsoft.com/v1.0//groups?$filter=groupTypes/any(c:c+eq+'Unified')" \
#     --header "Authorization: Bearer $token" > m365.json

# echo "Showing Microsoft 365 (Unified) groups:"
# jq '.value[] | {id, displayName}' temp_groups.json