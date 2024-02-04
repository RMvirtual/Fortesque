if (-Not $env:DEVENV) {& "$PSScriptRoot\setup.ps1"}
if (-Not $?) {Write-Host "Development environment check failed."; exit 1}

$TOOLS = "$env:DEVENV\tools"


Clear-Host; Write-Host "Building release."
& "$TOOLS\build.ps1"
