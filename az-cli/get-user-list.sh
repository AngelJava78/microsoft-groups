#!/bin/bash
# Get user list in Azure Active Directory
# Usage: ./user-list.sh
# Example: ./user-list.sh
# Prerequisites: Azure CLI must be installed and you must be logged in with sufficient permissions
output=$1
if [ -z "$output" ]; then
    output="json"
fi # Default output format
echo "Output format: $output"

query='[].{ID: id, DisplayName: displayName, UserPrincipalName: userPrincipalName, GivenName: givenName, Surname: surname, Mail: mail, AccountEnabled: accountEnabled}'
USER_LIST=$(az ad user list --output "$output" --query "$query")
if [ -z "$USER_LIST" ]; then
    echo "No users found."
    exit 1
fi
echo "User list:"
echo "$USER_LIST"
# Note: Ensure jq is installed for JSON formatting, or adjust the output method as needed
# Note: Adjust the output format and filtering as needed for your environment
