# Conexión a Microsoft Graph
Connect-MgGraph -Scopes "User.ReadWrite.All", "Directory.ReadWrite.All" -TenantId $tenantId  -NoWelcome
# Obtener el grupo
$group = Get-MgGroup -Filter "displayName eq 'Grupo M365 de Ejemplo'" -ConsistencyLevel eventual
$groupId = $group.Id
Write-Host "Group ID: $groupId"

# Obtener todos los miembros actuales del grupo
$currentMembers = Get-MgGroupMember -GroupId $groupId -All | Select-Object -ExpandProperty Id

# Obtener todos los usuarios
$userList = Get-MgUser -All

# Agregar usuarios que no estén ya en el grupo
foreach ($user in $userList) {
    if ($currentMembers -notcontains $user.Id) {
        try {
            $params = @{
                "@odata.id" = "https://graph.microsoft.com/v1.0/directoryObjects/$($user.Id)"
            }
            New-MgGroupMemberByRef -GroupId $groupId -BodyParameter $params
            Write-Host "Agregado: $($user.UserPrincipalName)"
        } catch {
            Write-Warning "Error al agregar $($user.UserPrincipalName): $_"
        }
    } else {
        Write-Host "Ya es miembro: $($user.UserPrincipalName)"
    }
}