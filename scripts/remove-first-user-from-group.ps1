# Conexión a Microsoft Graph
Connect-MgGraph -Scopes "Group.ReadWrite.All", "Directory.ReadWrite.All" -TenantId $tenantId -NoWelcome

$group = Get-MgGroup -Filter "displayName eq 'Grupo M365 de Ejemplo'" -ConsistencyLevel eventual
$groupId = $group.Id
Write-Host "Group ID: $groupId"

$members= Get-MgGroupMember -GroupId $groupId
Write-Host "Members:"
foreach($member in $members) {
    Write-Host $member.Id
}


$member = Get-MgGroupMember -GroupId $groupId -Top 1
Write-Host "Removing member: $($member.Id)"

Remove-MgGroupMemberByRef -GroupId $groupId -DirectoryObjectId $member.Id
Write-Host "Member removed."

$members= Get-MgGroupMember -GroupId $groupId
Write-Host "Members:"
foreach($member in $members) {
    Write-Host $member.Id
}
