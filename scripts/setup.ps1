[CmdletBinding()]
param([switch] $reinstall)

& "$PSScriptRoot\..\tools\setup\working_directory.ps1"
if (-Not $?) {exit 1}

$SETUP_SCRIPTS = "$env:DEVENV\tools\setup"
$TARGET = "$env:DEVENV\devenv"

if ($reinstall) {
    if (Test-Path $TARGET) {Remove-Item $TARGET -Recurse -Force > $null}
}

& "$SETUP_SCRIPTS\configure_environment.ps1"
