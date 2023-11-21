[CmdletBinding()]
param([switch] $debugMode)

if (-Not $env:DEVENV) {& "$PSScriptRoot\setup.ps1"}
if (-Not $?) {exit 1}

$TOOLS = "$env:DEVENV\tools"


if ($debugMode) {
    Clear-Host; Write-Host "Debugging application."
    
    Push-Location $env:DEVENV
    Start-Process gdb "$env:DEVENV\build\debug\main.exe"
    Pop-Location
}

else {
    Clear-Host; Write-Host "Running application."

    Push-Location "$env:DEVENV\build\release"
    & "$env:DEVENV\build\release\main.exe"
    Pop-Location
}
