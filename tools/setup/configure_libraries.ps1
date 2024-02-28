$LIB = "$env:DEVENV\lib"
$DOWNLOAD_SCRIPTS = "$env:DEVENV\tools\setup\downloads"


$gcc = "$LIB\mingw64"
if (-Not (Test-Path $gcc)) {& "$DOWNLOAD_SCRIPTS\gcc.ps1"}

$env:Path = "$env:DEVENV\lib\mingw64\bin\;" + $env:Path

<#
$googleTest = "$LIB\googletest"
if (-Not (Test-Path $googleTest)) {& "$DOWNLOAD_SCRIPTS\googletest.ps1"}
#>

$glfw = "$LIB\glfw"
if (-Not (Test-Path $glfw)) {& "$DOWNLOAD_SCRIPTS\glfw.ps1"}

