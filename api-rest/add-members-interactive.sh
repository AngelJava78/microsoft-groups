# Obtener el token desde token.sh
token=$(./token.sh)

# Get all groups
curl --silent --location "https://graph.microsoft.com/v1.0/groups" \
    --header "Authorization: Bearer $token" > temp_groups.json

echo "Showing all groups:"
jq '.value[] | {id, displayName}' temp_groups.json

read -p "Enter the Group Name or ID: " GROUP_INPUT
echo "Group Input: $GROUP_INPUT"


curl --silent --location "https://graph.microsoft.com/v1.0/users" \
    --header "Authorization: Bearer $token" > users.json

echo "Showing all groups:"
jq '.value[] | {id, displayName}' users.json

read -p "Enter the User Name or ID: " USER_INPUT
echo "User Input: $USER_INPUT"

curl --silent --location "https://graph.microsoft.com/v1.0/groups/$GROUP_INPUT/members/$USER_INPUT" \
    --header "Authorization: Bearer $token"
echo "Member: $USER_INPUT" was successfully added to group: $GROUP_INPUT"