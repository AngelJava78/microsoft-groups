#!/bin/bash
# Add a user to an Azure AD group if not already a member
# Usage: ./add-user-to-group.sh
# Prerequisites: Azure CLI must be installed and logged in with sufficient permissions

set -e

echo "Fetching list of groups..."
az ad group list --query '[].{Name: displayName, ID: id}' --output table

read -p "Enter the Group Name or ID: " GROUP_INPUT
echo "Group Input: $GROUP_INPUT"

# Validar si el input es un GUID (formato estándar de UUID)
if [[ "$GROUP_INPUT" =~ ^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$ ]]; then
    echo "El valor ingresado es un GUID válido."
    GROUP=$(az ad group list -o json | jq -r --arg name "$GROUP_INPUT" '.[] | select(.id | test($name; "i")) | {id, displayName}')
else
    echo "El valor ingresado NO es un GUID. Se intentará resolver como nombre de grupo."
    GROUP=$(az ad group list -o json | jq -r --arg name "$GROUP_INPUT" '.[] | select(.displayName | test($name; "i")) | {id, displayName}')
fi

if [ -z "$GROUP" ]; then
    echo "Group not found: $GROUP_INPUT"
    exit 1
fi


GROUP_NAME=$(echo "$GROUP" | jq -r '.displayName')
GROUP_ID=$(echo "$GROUP" | jq -r '.id')

echo "Resolved Group: $GROUP"
echo "Group Name: $GROUP_NAME"
echo "Group ID: $GROUP_ID"

echo "Fetching list of users..."
az ad user list --query '[].{Name: displayName, UserPrincipalName: userPrincipalName, ID: id}' --output table

read -p "Enter the User Principal Name or ID: " USER_INPUT

# Validar si el input es un GUID (formato estándar de UUID)
if [[ "$USER_INPUT" =~ ^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$ ]]; then
    echo "El valor ingresado es un GUID válido."
    USER=$(az ad user list -o json | jq -r --arg name "$USER_INPUT" '.[] | select(.id | test($name; "i")) | {id, displayName}')
else
    echo "El valor ingresado NO es un GUID. Se intentará resolver como nombre de grupo."
    USER=$(az ad user list -o json | jq -r --arg name "$USER_INPUT" '.[] | select(.displayName | test($name; "i")) | {id, displayName}')
fi

if [ -z "$USER" ]; then
    echo "User not found: $USER_INPUT"
    exit 1
fi

USER_NAME=$(echo "$USER" | jq -r '.displayName')
USER_ID=$(echo "$USER" | jq -r '.id')

echo "Resolved USER: $USER"
echo "User Name: $USER_NAME"
echo "User ID: $USER_ID"

# Check if user is already a member
echo "Checking if user is already a member of the group..."
IS_MEMBER=$(az ad group member check --group "$GROUP_NAME" --member-id "$USER_ID" --query "value" -o tsv)
echo "Is member: $IS_MEMBER"

if [ "$IS_MEMBER" == "true" ]; then
    echo "User is already a member of the group."
else
    echo "Adding user to group..."
    az ad group member add --group "$GROUP_ID" --member-id "$USER_ID"
    echo "User added to group successfully."
fi

az ad group member list --group "$GROUP_ID" --query '[].{Name: displayName, UserPrincipalName: userPrincipalName, ID: id}' --output table