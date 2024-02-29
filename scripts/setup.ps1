[CmdletBinding()]
param([switch] $reinstall)

& "$PSScriptRoot\..\tools\setup\working_directory.ps1"
if (-Not $?) {exit 1}

$SETUP_SCRIPTS = "$env:DEVENV\tools\setup"

if ($reinstall) {
    # Need to determine a setup method for checking all the necessary
    # lib folder exist now we have gotten rid of /devenv.
    & "$SETUP_SCRIPTS\configure_libraries.ps1"    
}

& "$SETUP_SCRIPTS\configure_environment.ps1"
