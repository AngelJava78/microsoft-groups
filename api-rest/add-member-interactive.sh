#!/bin/bash
# Obtener el token desde token.sh
token=$(./token.sh)

# Get all groups
curl --silent --location "https://graph.microsoft.com/v1.0/groups" \
    --header "Authorization: Bearer $token" > temp_groups.json

echo "Fetching all groups:"
echo "ID                                    DisplayName"
echo "--------------------------------------------------------------------------------------------------------------------------------"
jq -r '
  .value[] |
  [ .id, .displayName ] |
  @tsv
' "temp_groups.json" | column -t -s $'\t'

read -p "Enter the Group Name or ID: " GROUP_INPUT
echo "Group Input: $GROUP_INPUT"


curl --silent --location "https://graph.microsoft.com/v1.0/users" \
    --header "Authorization: Bearer $token" > users.json

#echo "Showing all groups:"
#jq '.value[] | {id, displayName}' users.json

echo "Fetching all users:"
echo "ID                                    DisplayName               UserPrincipalName"
echo "--------------------------------------------------------------------------------------------------------------------------------"

jq -r '
  .value[] |
  [ .id, .displayName, .userPrincipalName ] |
  @tsv
' "users.json" | column -t -s $'\t'

read -p "Enter the User Name or ID: " USER_INPUT
echo "User Input: $USER_INPUT"

curl --location -X POST "https://graph.microsoft.com/v1.0/groups/$GROUP_INPUT/members/\$ref" \
    --header "Authorization: Bearer $token" \
    --header "Content-Type: application/json" \
    --data-raw "{\"@odata.id\": \"https://graph.microsoft.com/v1.0/directoryObjects/$USER_INPUT\"}"

echo "Member: $USER_INPUT was successfully added to group: $GROUP_INPUT"


GROUP=$(curl --silent --location "https://graph.microsoft.com/v1.0/groups/$GROUP_INPUT" \
    --header "Authorization: Bearer $token")

GROUP_NAME=$(echo "$GROUP" | jq -r '.displayName')
GROUP_ID=$(echo "$GROUP" | jq -r '.id')
#echo "Resolved Group: $GROUP"
echo "Group Name: $GROUP_NAME"
echo "Group ID: $GROUP_ID"

curl --silent --location "https://graph.microsoft.com/v1.0/groups/$GROUP_ID/members" \
    --header "Authorization: Bearer $token" > members.json

echo "Members of group: "
#cat members.json
#jq '.value[] | {id, displayName}' users.json    
#!/bin/bash

# Archivo JSON
#archivo="members.json"

echo "ID                                    DisplayName               UserPrincipalName"
echo "--------------------------------------------------------------------------------------------------------------------------------"


# Mostrar tabla
jq -r '
  .value[] |
  [ .id, .displayName, .userPrincipalName ] |
  @tsv
' "members.json" | column -t -s $'\t'