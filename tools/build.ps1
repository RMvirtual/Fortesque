$BUILD = "$env:DEVENV\build"
$RELEASE = "$BUILD\release"
$DEBUG = "$BUILD\debug"
$TESTS = "$BUILD\tests"

$SRC = "$env:DEVENV\src"
$LIB = "$env:DEVENV\lib"
$RESOURCES = "$env:DEVENV\resources"
$TEST_SRC = "$env:DEVENV\tests"

$GCC_EXE = "$LIB\mingw64\bin\g++.exe"


# Need to copy all the DLLs used in the same folder as the g++.exe 
# compiler

function Compile-TexturesExample
{
    param ([string] $DestFolder, [bool] $Debuggable = $false)

    if (Test-Path $DestFolder) {Remove-Item $DestFolder -Recurse -Force > $null}
    New-Item $DestFolder -ItemType Directory > $null

    $GLAD = "$LIB\glad"
    $GLFW = "$LIB\glfw"
    
    $srcFiles = -join(
        "$SRC\textures_example\main.cpp $SRC\shader.cpp $SRC\stb_image.cpp ",
        "$GLAD\src\glad.c $SRC\camera.cpp"
    )
    
    $compileOptions = "-o $DestFolder\main.exe "
    if ($Debuggable) {$compileOptions += "-g "}

    $includes = "-I$GLAD\include -I$GLFW\include -I$SRC -I$LIB"

    $libraries = -join(
        "-L$GLFW\lib-mingw-w64 -lglfw3 -static -ldl -static ",
        "-lgdi32 -luser32"
    )

    $platform = "-mwindows -std=c++17"

    $compileOptions += "$srcFiles $includes $libraries $platform"
    Start-Process $GCC_EXE -ArgumentList $compileOptions -NoNewWindow -Wait

    Copy-Item "$SRC\shaders\texture_shader.*" $DestFolder
    Copy-Item $RESOURCES $DestFolder -Recurse
}


function Compile-LightingExample
{
    param ([string] $DestFolder, [bool] $Debuggable = $false)
   
    if (Test-Path $DestFolder) {Remove-Item $DestFolder -Recurse -Force > $null}
    New-Item $DestFolder -ItemType Directory > $null

    $GLAD = "$LIB\glad"
    $GLFW = "$LIB\glfw"
    
    $srcFiles = -join(
        "$SRC\lighting_example\main.cpp $SRC\shader.cpp $SRC\stb_image.cpp ",
        "$GLAD\src\glad.c $SRC\camera.cpp"
    )
    
    $compileOptions = "-o $DestFolder\main.exe "
    if ($Debuggable) {$compileOptions += "-g "}

    $includes = "-I$GLAD\include -I$GLFW\include -I$SRC -I$LIB"

    $libraries = -join(
        "-L$GLFW\lib-mingw-w64 -lglfw3 -static -ldl -static ",
        "-lgdi32 -luser32"
    )

    $platform = "-mwindows -std=c++17"

    $compileOptions += "$srcFiles $includes $libraries $platform"
    Start-Process $GCC_EXE -ArgumentList $compileOptions -NoNewWindow -Wait

    Copy-Item "$SRC\shaders\lighting.*" $DestFolder
    Copy-Item "$SRC\shaders\lamp_cube.*" $DestFolder
    
    Copy-Item $RESOURCES $DestFolder -Recurse
}


if (Test-Path $BUILD) {Remove-Item $BUILD -Recurse -Force > $null}
New-Item $BUILD -ItemType Directory > $null

Write-Host "Compiling Release version."
Compile-TexturesExample "$RELEASE\textures_example"
Compile-LightingExample "$RELEASE\lighting_example"

Write-Host "Compiling Debug version."
 Compile-TexturesExample "$DEBUG\textures_example" -Debuggable $true
Compile-LightingExample "$DEBUG\lighting_example" -Debuggable $true


<#
# Tests.
Write-Host "Building tests."

if (Test-Path $TESTS) {Remove-Item $TESTS -Recurse -Force > $null}
New-Item $TESTS -ItemType Directory > $null

$GOOGLETEST = "$LIB\GOOGLETEST"

$gtestIncludes = "$GOOGLETEST\googletest\include"
$gtestObject = "$GOOGLETEST\gtest-all.o"
$testExecutable = "$TESTS\all_tests.exe"

g++.exe -o $testExecutable `
    -std=c++17 -isystem $gtestIncludes -pthread  -I"$SRC" `
    "$TEST_SRC\test_runner.cpp" "$TEST_SRC\maths\test_vector.cpp" `
    "$SRC\maths\vector.cpp"$gtestObject 
#>