$BUILD = "$env:DEVENV\build"
$RELEASE = "$BUILD\release"
$DEBUG = "$BUILD\debug"
$TESTS = "$BUILD\tests"
$SRC = "$env:DEVENV\src"
$TEST_SRC = "$env:DEVENV\tests"
$GOOGLETEST = "$env:DEVENV\devenv\GOOGLETEST"


if (-Not (Test-Path $BUILD)) {New-Item $BUILD -ItemType Directory > $null}

# Release.
if (Test-Path $RELEASE) {Remove-Item $RELEASE -Recurse -Force > $null}
New-Item $RELEASE -ItemType Directory > $null

g++.exe -o "$RELEASE\main.exe" `
    "$SRC\main.cpp" "$SRC\draw.cpp" `
    -std=c++17 -mwindows -luser32 -lgdi32
    
# Debug folder.
if (-Not (Test-Path $DEBUG)) {
    New-Item $DEBUG -ItemType Directory > $null
}

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
