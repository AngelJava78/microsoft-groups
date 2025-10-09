#!/bin/bash
# Get details of a user in Azure Active Directory
# Usage: ./get-user.sh <username>
# Example: ./get-user.sh johndoe
# Prerequisites: Azure CLI must be installed and you must be logged in with sufficient permissions
set -e
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <username>"
    exit 1
fi
USERNAME=$1
USER_DETAILS=$(az ad user show --id "$USERNAME" --output json)
if [ -z "$USER_DETAILS" ]; then
    echo "User $USERNAME not found."
    exit 1
fi
echo "User details for $USERNAME:"
echo "$USER_DETAILS" | jq .
# Note: Ensure jq is installed for JSON formatting, or adjust the output method as needed

