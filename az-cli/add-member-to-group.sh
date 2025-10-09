$!/bin/bash
# Add a member to a group in Azure Active Directory
# Usage: ./add-member-to-group.sh <group-id> <user-id>
# Example: ./add-member-to-group.sh <group-id> <user-id>
# Prerequisites: Azure CLI must be installed and you must be logged in with sufficient permissions
set -e
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <group-id> <user-id>"
    exit 1
fi
GROUP_ID=$1
USER_ID=$2
echo "Group ID: $GROUP_ID"
echo "User ID: $USER_ID"
az ad group member add --group "$GROUP_ID" --member-id "$USER_ID"
echo "User $USER_ID added to group $GROUP_ID successfully." 
# Note: Ensure the group and user IDs are correct and that you have the necessary permissions to add members to the group
