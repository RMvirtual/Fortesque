[CmdletBinding()]
param([switch] $debugMode)

if (-Not $env:DEVENV) {& "$PSScriptRoot\setup.ps1"}
if (-Not $?) {exit 1}

$TOOLS = "$env:DEVENV\tools"


if ($debugMode) {
    Clear-Host; Write-Host "Debugging application."
    Start-Process gdb "$env:DEVENV\build\release\main.exe"
}

else {
    Clear-Host; Write-Host "Running application."
    Start-Process "$env:DEVENV\build\release\main.exe" > $null
}
