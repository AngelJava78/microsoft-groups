# Conexión a Microsoft Graph
Connect-MgGraph -Scopes "Group.ReadWrite.All", "Directory.ReadWrite.All" -TenantId $tenantId -NoWelcome

# Obtener el ID del grupo
$group = Get-MgGroup -Filter "displayName eq 'Grupo M365 de Ejemplo'" -ConsistencyLevel eventual
$groupId = $group.Id
Write-Host "Group ID: $groupId"

# Obtener todos los miembros del grupo
$members = Get-MgGroupMember -GroupId $groupId -All

# Eliminar cada miembro
foreach ($member in $members) {
    try {
        $user= Get-MgUser -UserId $member.Id

        Remove-MgGroupMemberByRef -GroupId $groupId -DirectoryObjectId $member.Id
        Write-Host "Eliminado: $(($user).DisplayName) - $($member.Id)"
    } catch {
        Write-Warning "Error al eliminar $($member.Id): $_"
    }
}