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
    param ([string] $destPath, [bool] $debuggable = $false)

    if (Test-Path $destPath) {Remove-Item $destPath -Recurse -Force > $null}
    New-Item $destPath -ItemType Directory > $null

    $GLAD = "$DEV_LIBS\glad"
    $GLFW = "$DEV_LIBS\glfw"
       
    $srcFiles = -join(
        "$SRC\fortesque.cpp $SRC\shader.cpp $SRC\stb_image.cpp ",
        "$GLAD\src\glad.c $SRC\camera.cpp"
    )
    
    $compileOptions = "-o $destPath\main.exe "
    if ($debuggable) {$compileOptions += "-g "}

    $includes = "-I$GLAD\include -I$GLFW\include -I$SRC -I$LIB"
    $libraries = "-L$GLFW\lib-mingw-w64 -lglfw3 -ldl -lgdi32 -luser32" 
    $platform = "-mwindows -std=c++17"

    $compileOptions += "$srcFiles $includes $libraries $platform"
    Start-Process g++.exe -ArgumentList $compileOptions -NoNewWindow -Wait

    # Shaders
    Copy-Item "$SRC\texture_shader.fs" $destPath
    Copy-Item "$SRC\texture_shader.vs" $destPath
    
    Copy-Item $RESOURCES $destPath -Recurse
}


if (-Not (Test-Path $BUILD)) {New-Item $BUILD -ItemType Directory > $null}

Write-Host "Compiling Release version."
Compile-Fortesque $RELEASE

Write-Host "Compiling Debug version."
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