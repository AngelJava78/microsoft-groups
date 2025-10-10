#!/bin/bash
# Get details of a user in Azure Active Directory using Microsoft Graph API
# Usage: ./get-user.sh <username>
# Example: ./get-user.sh
USER=$1

# Obtener el token desde token.sh
token=$(./token.sh)

USER=$(curl --silent --location "https://graph.microsoft.com/v1.0/users/$USER" \
    --header "Authorization: Bearer $token")

echo $USER | jq .