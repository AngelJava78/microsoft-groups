# Get-MgGroupMember

Obtenga una lista de los miembros directos del grupo. Un grupo puede tener usuarios, contactos de la organización, dispositivos, directores de servicio y otros grupos como miembros. Esta operación no es transitiva.

```powershell
Get-MgGroupMember
    -GroupId <string>
    [-ExpandProperty <string[]>]
    [-Filter <string>]
    [-Property <string[]>]
    [-Search <string>]
    [-Skip <int>]
    [-Sort <string[]>]
    [-Top <int>]
    [-ConsistencyLevel <string>]
    [-ResponseHeadersVariable <string>]
    [-Break]
    [-Headers <IDictionary>]
    [-HttpPipelineAppend <SendAsyncStep[]>]
    [-HttpPipelinePrepend <SendAsyncStep[]>]
    [-Proxy <uri>]
    [-ProxyCredential <pscredential>]
    [-ProxyUseDefaultCredentials]
    [-PageSize <int>]
    [-All]
    [-CountVariable <string>]
    [<CommonParameters>]
```

## Permisos
|Permission type|Permissions (from least to most privileged)|
|---|---|
|Delegated (work or school account)	|GroupMember.ReadWrite.All, GroupMember.Read.All, Group.ReadWrite.All, Group.Read.All, Directory.Read.All,|
|Delegated (personal Microsoft account)	|Not supported|
|Application|GroupMember.ReadWrite.All, GroupMember.Read.All, Group.ReadWrite.All, Group.Read.All, Directory.Read.All,|

## Ejemplos

```powershell
Get-MgGroupMember -GroupId '7b7be3ab-d2b3-441c-8111-2e89b8493fff'

Id                                   DeletedDateTime
--                                   ---------------
6733b39d-1b5d-46af-adf3-4589718be012
0107d1b2-0402-4ef9-a58c-eb0661c5d596
f9f1bd4f-16ca-4404-925e-5b08b6a3832f
5441e919-583c-4292-aa3f-98250d8d217b
```

## Ejemplos prácticos
1. Get-MgGroupMember -GroupId dcffaf93-adfb-4c82-bf91-db41942ade09

## Referencias
- [Get-MgGroupMember](https://learn.microsoft.com/en-us/powershell/module/microsoft.graph.groups/get-mggroupmember?view=graph-powershell-1.0)