$LIB = "$env:DEVENV\lib"
$CMAKE_EXE = "$LIB\cmake\bin\cmake.exe"

$VERSION = "5.3.1"
$URL = "https://github.com/assimp/assimp/archive/refs/tags/v$VERSION.zip"


function Download-Zip
{
    $zipFile = "$LIB\assimp.zip"

    Invoke-WebRequest -Uri $URL -OutFile $zipFile
    Expand-Archive -Path $zipFile -DestinationPath $LIB
    Remove-Item $zipFile > $null
}


function Build-Library
{
    if (-Not (Test-Path $CMAKE_EXE)) {
        Write-Host "Requires cmake executable file.";

        exit 1
    }

    $repo = "$LIB\assimp-$VERSION"

    Push-Location $repo
    & $CMAKE_EXE CMakeLists.txt
    & $CMAKE_EXE --build .
    Pop-Location
}


function Install-Library
{

}

# Download-Zip
# Build-Library

