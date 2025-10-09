#!/bin/bash
# Get group list in Azure Active Directory by group type
# Usage: ./get-group-list.sh [output-format] [group-type]
# Example: ./get-group-list.sh json m365
# Prerequisites: Azure CLI must be installed and you must be logged in with sufficient permissions

output=$1
groupType=$2

if [ -z "$output" ]; then
    output="json"
fi

echo "Output format: $output"
echo "Group type: $groupType"




if [ "$groupType" == "security" ]; then
    filter_query="[?securityEnabled==\`true\`].{ID:id, DisplayName:displayName, Description:description, MailEnabled:mailEnabled, mailNickname:mailNickname, Mail:mail, SecurityEnabled:securityEnabled}"
elif [ "$groupType" == "m365" ]; then
    filter_query="[?securityEnabled==\`false\`].{ID:id, DisplayName:displayName, Description:description, MailEnabled:mailEnabled, mailNickname:mailNickname, Mail:mail, SecurityEnabled:securityEnabled}"
else
    filter_query="[].{ID:id, DisplayName:displayName, Description:description, MailEnabled:mailEnabled, mailNickname:mailNickname, Mail:mail, SecurityEnabled:securityEnabled}"
fi

GROUP_LIST=$(az ad group list --query "$filter_query" --output "$output")


if [ -z "$GROUP_LIST" ] || [ "$GROUP_LIST" == "[]" ]; then
    echo "No groups found for type: $groupType"
    exit 1
fi

echo "Filtered group list:"
echo "$GROUP_LIST" 