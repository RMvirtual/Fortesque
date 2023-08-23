if (-Not $env:DEVENV) {& "$PSScriptRoot\working_directory.ps1"}

$SETUP_SCRIPTS = "$env:DEVENV\tools\setup"
$TARGET = "$env:DEVENV\devenv"


if (-Not (Test-Path $TARGET)) {New-Item $TARGET -ItemType Directory > $null}
& "$SETUP_SCRIPTS\configure_libraries.ps1"
