# microsoft-groups

## Instalar el SDK de PowerShell de Microsoft Graph

### Prerequisitos

- Actualice a PowerShell 5.1 o posterior

- Instalar .NET Framework 4.7.2 o posterior

- Actualice PowerShellGet a la última versión usandoInstall-Module PowerShellGet

- La política de ejecución del script de PowerShell debe estar establecida en remote signedo less restrictive
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```
### Instalación
El SDK de PowerShell para Microsoft Graph consta de dos módulos, Microsoft.Graph y Microsoft.Graph.Beta, que se instalan por separado. Estos módulos llaman a los puntos de conexión de Microsoft Graph v1.0 y Microsoft Graph beta, respectivamente. Puede instalar ambos módulos en la misma versión de PowerShell.

El uso del cmdlet Install-Module es el método de instalación preferido para los módulos de PowerShell de Microsoft Graph.

Para instalar el módulo v1 del SDK en PowerShell Core o Windows PowerShell, ejecute el siguiente comando.
```powershell
Install-Module Microsoft.Graph -Scope CurrentUser -Repository PSGallery -Force
```

Opcionalmente, puede cambiar el alcance de la instalación mediante el -Scopeparámetro. Esto requiere permisos de administrador.

```powershell
Install-Module Microsoft.Graph -Scope AllUsers -Repository PSGallery -Force
```

Para instalar el módulo beta, ejecute el siguiente comando.

```powershell
Install-Module Microsoft.Graph.Beta -Repository PSGallery -Force
```

### Verificar la instalación
Una vez completada la instalación, puede verificar la versión instalada con el siguiente comando.

```powershell
Get-InstalledModule Microsoft.Graph
```

## Referencias: 

- [Instalar el SDK de PowerShell de Microsoft Graph](https://learn.microsoft.com/es-mx/powershell/microsoftgraph/installation?view=graph-powershell-1.0)

