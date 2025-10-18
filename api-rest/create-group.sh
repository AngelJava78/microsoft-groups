#!/bin/bash
# Create a group in Azure Active Directory using Microsoft Graph API
# Usage: ./create-group.sh <group-name> <group-description>
# Example: ./create-group.sh "My Group" "This is my group"
# Prerequisites: curl must be installed and you must have a valid token with sufficient permissions
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <group-name> <group-description>"
    exit 1
fi
GROUP_NAME=$1
GROUP_DESCRIPTION=$2
echo "Group Name: $GROUP_NAME"
echo "Group Description: $GROUP_DESCRIPTION"
# Obtener el token desde token.sh
token=$(./token.sh)
# Create group
response=$(curl --silent --location -X POST "https://graph.microsoft.com/v1.0/groups" \
    --header "Authorization: Bearer $token" \
    --header "Content-Type: application/json" \
    --data-raw "{\"displayName\": \"$GROUP_NAME\", \"description\": \"$GROUP_DESCRIPTION\", \"mailEnabled\": false, \"mailNickname\": \"$(echo $GROUP_NAME | tr -d ' ' | tr '[:upper:]' '[:lower:]')\", \"securityEnabled\": true}")
echo "Group created successfully:"
echo "$response" | jq   
