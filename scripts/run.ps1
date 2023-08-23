if (-Not $env:DEVENV) {& "$PSScriptRoot\setup.ps1"}
if (-Not $?) {exit 1}

$TOOLS = "$env:DEVENV\tools"


Clear-Host; Write-Host "Running application."
& "$TOOLS\run.ps1"
