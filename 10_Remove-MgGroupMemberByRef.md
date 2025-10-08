# Remove-MgGroupMemberByRef

Eliminar un miembro de un grupo mediante la propiedad de navegación de miembros. No se puede eliminar un miembro de grupos con membresías dinámicas.

```powershell
Remove-MgGroupMemberByRef
    -DirectoryObjectId <string>
    -GroupId <string>
    [-IfMatch <string>]
    [-ResponseHeadersVariable <string>]
    [-Break]
    [-Headers <IDictionary>]
    [-HttpPipelineAppend <SendAsyncStep[]>]
    [-HttpPipelinePrepend <SendAsyncStep[]>]
    [-PassThru]
    [-Proxy <uri>]
    [-ProxyCredential <pscredential>]
    [-ProxyUseDefaultCredentials]
    [-WhatIf]
    [-Confirm]
    [<CommonParameters>]
```

## Permisos
|Permission type|Permissions (from least to most privileged)|
|---|---|
|Delegated (work or school account)	|GroupMember.ReadWrite.All, Group.ReadWrite.All, Directory.ReadWrite.All,|
|Delegated (personal Microsoft account)	|Not supported|
|Application|GroupMember.ReadWrite.All, Group.ReadWrite.All, Directory.ReadWrite.All,|

## Ejemplos

```powershell
Import-Module Microsoft.Graph.Groups

Remove-MgGroupMemberByRef -GroupId $groupId -DirectoryObjectId $directoryObjectId
```

## Ejemplo práctico

```powershell
$tenantId = "//Aquí va tu tenantId"
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
```

En este ejemplo se elimina el primer miembro del grupo.



## Referencias
- [Remove-MgGroupMemberByRef](https://learn.microsoft.com/en-us/powershell/module/microsoft.graph.groups/remove-mggroupmemberbyref?view=graph-powershell-1.0)