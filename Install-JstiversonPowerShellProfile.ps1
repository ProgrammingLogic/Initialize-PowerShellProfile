<#
.SYNOPSIS
Initializes the PowerShell profile.

.DESCRIPTION
Initializes the PowerShell profile for the current user.

Adds a custom profile script to $Profile (usually 
    $env:USERPROFILE\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1)

.EXAMPLE
Install-JstiversonPowerShellProfile.ps1

.NOTES
Author: Jonathyn Stiverson (jlstiverson2002@protonmail.com)
Date: 08/30/2024
#>
[CmdletBinding(SupportsShouldProcess)]
Param (

)

Process {
    # Ensure execution policy is set to "remote signed" for this to work
    Try {
        Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
    } Catch {
        Write-Warning "Unable to set execution policy! Profile might not work."
    }

    # Create the certificate
    $cert = Get-ChildItem cert:\CurrentUser\my -codesigning -ErrorAction SilentlyContinue | Where-Object {$_.subject.equals("CN=Jonathyn Stiverson Profile Cert")}

    If (-not $cert) {
        $params = @{
            Subject = "CN=Jonathyn Stiverson Profile Cert"
            Type = "CodeSigning"
            CertStoreLocation = "Cert:\CurrentUser\My"
            HashAlgorithm = "sha256"
        }
        $cert = New-SelfSignedCertificate @params
    }

    # Sign the script(s)
    Copy-Item -Path "$PSScriptRoot\Microsoft.PowerShell_profile.ps1" -Destination "$Profile" -Force -Verbose:$False -WhatIf:$WhatIfPreference
    Set-AuthenticodeSignature "$Profile" $cert -Verbose:$False -WhatIf:$WhatIfPreference
}
