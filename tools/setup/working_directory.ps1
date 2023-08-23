$env:DEVENV = $null;
$rootDirectory = Resolve-Path "$PSScriptRoot\..\.."

if (-Not (Test-Path "$rootDirectory\tools\setup\working_directory.ps1")) {
    Write-Host "Could not resolve root development directory."

    exit 1
}

$env:DEVENV = $rootDirectory
