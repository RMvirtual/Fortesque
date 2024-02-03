$BUILD = "$env:DEVENV\build"
$RELEASE = "$BUILD\release"
$DEBUG = "$BUILD\debug"
$TESTS = "$BUILD\tests"

$SRC = "$env:DEVENV\src"
$LIB = "$env:DEVENV\lib"
$DEV_LIBS = "$env:DEVENV\devenv"
$RESOURCES = "$env:DEVENV\resources"
$TEST_SRC = "$env:DEVENV\tests"


function Compile-Fortesque
{
    param ([string] $destFolder, [bool] $debuggable = $false)

    New-Item $destFolder -ItemType Directory > $null

    $GLAD = "$DEV_LIBS\glad"
    $GLFW = "$DEV_LIBS\glfw"
    
    if ($debuggable) {
        g++.exe -o "$destFolder\main.exe" -g `
            "$SRC\fortesque.cpp" "$SRC\shader.cpp" "$SRC\stb_image.cpp" `
            "$GLAD\src\glad.c" `
            -I"$GLAD\include" -I"$GLFW\include" -I"$SRC" -I"$LIB" `
            -L"$GLFW\lib-mingw-w64" `
            -lglfw3 -ldl -lgdi32 -luser32 `
            -mwindows -std=c++17
    }

    else {
        g++.exe -o "$destFolder\main.exe" `
            "$SRC\fortesque.cpp" "$SRC\shader.cpp" "$SRC\stb_image.cpp" `
            "$GLAD\src\glad.c" `
            -I"$GLAD\include" -I"$GLFW\include" -I"$SRC" -I"$LIB" `
            -L"$GLFW\lib-mingw-w64" `
            -lglfw3 -ldl -lgdi32 -luser32 `
            -mwindows -std=c++17
    }

    # Shaders
    Copy-Item "$SRC\3.3.shader.fs" $destFolder
    Copy-Item "$SRC\3.3.shader.vs" $destFolder

    Copy-Item $RESOURCES $destFolder -Recurse
}


if (-Not (Test-Path $BUILD)) {New-Item $BUILD -ItemType Directory > $null}

# Release.
if (Test-Path $RELEASE) {Remove-Item $RELEASE -Recurse -Force > $null}
Compile-Fortesque $RELEASE

# Debug.
if (Test-Path $DEBUG) {Remove-Item $DEBUG -Recurse -Force > $null}
Compile-Fortesque $DEBUG -debuggable $true

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