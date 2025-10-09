#!/bin/bash
# Create a new group in Azure Active Directory
# Usage: ./create-group.sh <group-name> <description>
# Example:
# ./create-group.sh "MyGroup" "This is my group"
# Prerequisites: Azure CLI must be installed and you must be logged in with sufficient permissions
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <group-name> <description>"
    exit 1
fi
GROUP_NAME=$1
DESCRIPTION=$2
echo "Group Name: $GROUP_NAME"
echo "Description: $DESCRIPTION"
GROUP_ID=$(az ad group create \
        --display-name "$GROUP_NAME" \
        --mail-nickname "$GROUP_NAME" \
        --description "$DESCRIPTION" \
        --output tsv \
        --query id
    )
if [ -z "$GROUP_ID" ]; then
    echo "Failed to create group $GROUP_NAME."
    exit 1
fi
echo "Group $GROUP_NAME created successfully with ID: $GROUP_ID"
# Note: Adjust parameters as needed for your environment
