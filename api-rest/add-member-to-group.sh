$!/bin/bash
# Add a member to a group in Azure Active Directory using Microsoft Graph API
# Usage: ./add-member-to-group.sh <group-id> <user-id>
# Example: ./add-member-to-group.sh <group-id> <user-id>
# Prerequisites: curl must be installed and you must have a valid token with sufficient permissions
set -e
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <group-id> <user-id>"
    exit 1
fi
GROUP_ID=$1
USER_ID=$2
echo "Group ID: $GROUP_ID"
echo "User ID: $USER_ID
# Obtener el token desde token.sh
token=$(./token.sh) 
curl --location -X POST "https://graph.microsoft.com/v1.0/groups/$GROUP_ID/members/\$ref" \
    --header "Authorization: Bearer $token" \
    --header "Content-Type: application/json" \
    --data-raw "{\"@odata.id\": \"https://graph.microsoft.com/v1.0/users/$USER_ID\"}"
echo "User $USER_ID added to group $GROUP_ID successfully." 
# Note: Ensure the group and user IDs are correct and that you have the necessary permissions to add members to the group  