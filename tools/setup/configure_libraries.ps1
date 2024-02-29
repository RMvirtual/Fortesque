$LIB = "$env:DEVENV\lib"
$INSTALLERS = "$env:DEVENV\tools\setup\downloads"


if (-Not (Test-Path "$LIB\mingw64")) {& "$INSTALLERS\gcc.ps1"}
if (-Not (Test-Path "$LIB\cmake")) {& "$INSTALLERS\cmake.ps1"}
if (-Not (Test-Path "$LIB\glfw")) {& "$INSTALLERS\glfw.ps1"}
if (-Not (Test-Path "$LIB\assimp-5.3.1")) {& "$INSTALLERS\assimp.ps1"}
# if (-Not (Test-Path "$LIB\googletest")) {& "$INSTALLERS\googletest.ps1"}
