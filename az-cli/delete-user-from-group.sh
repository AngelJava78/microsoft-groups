#!/bin/bash
# Delete a user from an Azure AD group
# Usage: ./delete-user-from-group.sh <group-id> <user-id>
# Example: ./delete-user-from-group.sh <group-id> <user-id>
# Prerequisites: Azure CLI must be installed and you must be logged in with sufficient permissions

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

echo "Fetching members of group: $GROUP_NAME (ID: $GROUP_ID)"
az ad group member list --group "$GROUP_ID" -o table --query '[].{Id: id, Name: displayName}'

read -p "Enter the User ID to remove: " USER_ID
echo "Group Input: $USER_ID"

echo "Group ID: $GROUP_ID"
echo "User ID: $USER_ID"
echo "Removing user $USER_ID from group $GROUP_ID..."
az ad group member remove --group "$GROUP_ID" --member-id "$USER_ID"
echo "User $USER_ID removed from group $GROUP_ID successfully."


echo "Fetching members of group: $GROUP_NAME (ID: $GROUP_ID)"
az ad group member list --group "$GROUP_ID" -o table --query '[].{Id: id, Name: displayName}'