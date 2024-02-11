[CmdletBinding()]
param([switch] $Textures, [switch] $Lighting)

if (-Not $env:DEVENV) {& "$PSScriptRoot\setup.ps1"}
if (-Not $?) {exit 1}

$RELEASES = "$env:DEVENV\build\release"

$default = "lighting_example"

if ($Textures) {$program = "textures_example"}
elseif ($Lighting) {$program = "lighting_example"}
else {$program = $default}


Clear-Host; Write-Host "Running application."

Push-Location "$RELEASES\$program"
.\main.exe
Pop-Location
