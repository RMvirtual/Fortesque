if (-Not $env:DEVENV) {& "$PSScriptRoot\working_directory.ps1"}
& "$env:DEVENV\tools\setup\configure_libraries.ps1"
