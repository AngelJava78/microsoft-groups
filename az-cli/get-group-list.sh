#!/bin/bash
# Get group list in Azure Active Directory
# Usage: ./get-group-list.sh [output-format]
# Example: ./get-group-list.sh json
# Prerequisites: Azure CLI must be installed and you must be logged in with sufficient permissions
output=$1
if [ -z "$output" ]; then
    output="json"
fi # Default output format
echo "Output format: $output"
#az ad group list --output $output
query='[].{ID: id, DisplayName: displayName, Description: description, MailEnabled: mailEnabled, mailNickname: mailNickname, Mail: mail, SecurityEnabled: securityEnabled}'
GROUP_LIST=$(az ad group list --output "$output" --query "$query")
if [ -z "$GROUP_LIST" ]; then
    echo "No groups found."
    exit 1
fi
echo "Group list:"
echo "$GROUP_LIST"
# Note: Ensure jq is installed for JSON formatting, or adjust the output method as needed
# Note: Adjust the output format and filtering as needed for your environment
