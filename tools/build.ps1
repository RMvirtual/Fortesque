$BUILD = "$env:DEVENV\build"
$RELEASE = "$BUILD\release"
$TESTS = "$BUILD\tests"
$SRC = "$env:DEVENV\src"
$TEST_SRC = "$env:DEVENV\tests"
$GOOGLETEST = "$env:DEVENV\devenv\GOOGLETEST"
$DEV_LIBS = "$env:DEVENV\devenv"


if (-Not (Test-Path $BUILD)) {New-Item $BUILD -ItemType Directory > $null}

# Release.
if (Test-Path $RELEASE) {Remove-Item $RELEASE -Recurse -Force > $null}
New-Item $RELEASE -ItemType Directory > $null

# Object file?
g++.exe -o "$RELEASE\main.exe" `
    "$SRC\fortesque.cpp" "$DEV_LIBS\glad\src\glad.c" `
    -I"$DEV_LIBS\glad\include" `
    -I"$DEV_LIBS\glfw\include" `
    -L"$DEV_LIBS\glfw\lib-mingw-w64" `
    -lglfw3 -ldl -lgdi32 -luser32 `
    -mwindows -std=c++17

<#
# Tests.
Write-Host "Building tests."

if (Test-Path $TESTS) {Remove-Item $TESTS -Recurse -Force > $null}
New-Item $TESTS -ItemType Directory > $null

$gtestIncludes = "$GOOGLETEST\googletest\include"
$gtestObject = "$GOOGLETEST\gtest-all.o"
$testExecutable = "$TESTS\all_tests.exe"

g++.exe -o $testExecutable `
    -std=c++17 -isystem $gtestIncludes -pthread  -I"$SRC" `
    "$TEST_SRC\test_runner.cpp" "$TEST_SRC\maths\test_vector.cpp" `
    "$SRC\maths\vector.cpp"$gtestObject 
#>