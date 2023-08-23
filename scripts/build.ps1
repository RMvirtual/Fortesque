if (-Not $env:DEVENV) {& "$PSScriptRoot\setup.ps1"}
if (-Not $?) {exit 1}

$TOOLS = "$env:DEVENV\tools"


Clear-Host; Write-Host "Building release."
& "$TOOLS\build.ps1"
