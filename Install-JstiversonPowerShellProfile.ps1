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
    Copy-Item -Path "$PSScriptRoot\Microsoft.PowerShell_profile.ps1" -Destination "$profile" -Force `
        -VerbosePreference:$VerbosePreference -WhatIfPreference:$WhatIfPreference
}
