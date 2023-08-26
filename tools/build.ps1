$BUILD = "$env:DEVENV\build"
$DEV_LIBS = "$env:DEVENV\devenv"
$RELEASE = "$BUILD\release"
$TESTS = "$BUILD\tests"
$SRC = "$env:DEVENV\src"
$TEST_SRC = "$env:DEVENV\tests"


if (-Not (Test-Path $BUILD)) {New-Item $BUILD -ItemType Directory > $null}

# Release.
if (Test-Path $RELEASE) {Remove-Item $RELEASE -Recurse -Force > $null}
New-Item $RELEASE -ItemType Directory > $null

$GLAD = "$DEV_LIBS\glad"
$GLFW = "$DEV_LIBS\glfw"

g++.exe -o "$RELEASE\main.exe" `
    "$SRC\fortesque.cpp" "$GLAD\src\glad.c" `
    -I"$GLAD\include" -I"$GLFW\include" -L"$GLFW\lib-mingw-w64" `
    -lglfw3 -ldl -lgdi32 -luser32 `
    -mwindows -std=c++17

<#
# Tests.
Write-Host "Building tests."

if (Test-Path $TESTS) {Remove-Item $TESTS -Recurse -Force > $null}
New-Item $TESTS -ItemType Directory > $null

$GOOGLETEST = "$DEV_LIBS\GOOGLETEST"

$gtestIncludes = "$GOOGLETEST\googletest\include"
$gtestObject = "$GOOGLETEST\gtest-all.o"
$testExecutable = "$TESTS\all_tests.exe"

g++.exe -o $testExecutable `
    -std=c++17 -isystem $gtestIncludes -pthread  -I"$SRC" `
    "$TEST_SRC\test_runner.cpp" "$TEST_SRC\maths\test_vector.cpp" `
    "$SRC\maths\vector.cpp"$gtestObject 
#>