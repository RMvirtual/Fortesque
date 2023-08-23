$TARGET = "$env:DEVENV\devenv"
$DOWNLOAD_SCRIPTS = "$env:DEVENV\tools\setup\downloads"


$gcc = "$TARGET\mingw64"

if (-Not (Test-Path $gcc)) {& "$DOWNLOAD_SCRIPTS\gcc.ps1"}
$env:Path = "$env:DEVENV\devenv\mingw64\bin\;" + $env:Path

$googleTest = "$TARGET\googletest"
if (-Not (Test-Path $googleTest)) {& "$DOWNLOAD_SCRIPTS\googletest.ps1"}

$glfw = "$TARGET\glfw"
if (-Not (Test-Path $glfw)) {& "$DOWNLOAD_SCRIPTS\glfw.ps1"}

$glad = "$TARGET\glad"
if (-Not (Test-Path $glad)) {& "$DOWNLOAD_SCRIPTS\glad.ps1"}
