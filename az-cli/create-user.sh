#!/bin/bash
# Create a new user in Azure Active Directory
# Usage: ./create-user.sh <username> <password> <display-name> <email>
# Example: ./create-user.sh johndoe P@ssw0rd "John Doe"
# Prerequisites: Azure CLI must be installed and you must be logged in with sufficient permissions

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <username> <password> <display-name>"
    exit 1
fi
source ./variables.sh
USERNAME="$1@${domain}"
echo "Username: $USERNAME"
PASSWORD=$2
echo "Password: $PASSWORD"
DISPLAY_NAME=$3
echo "Display Name: $DISPLAY_NAME"

az ad user create \
    --display-name "$DISPLAY_NAME" \
    --password "$PASSWORD" \
    --user-principal-name "$USERNAME" 
echo "User $USERNAME created successfully."
# Note: Adjust --usage-location and other parameters as needed for your environment
