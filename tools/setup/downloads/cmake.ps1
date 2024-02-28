$LIB = "$env:DEVENV\lib"
$TARGET = "$LIB\cmake"

$VERSION = "3.28.3"
$PLATFORM = "windows-x86_64"
$RELEASE_NAME = "cmake-$VERSION-$PLATFORM"

$URL = "https://github.com/Kitware/CMake/releases/download/" `
    + "v$VERSION/$RELEASE_NAME.zip"


if (Test-Path $TARGET) {Remove-Item $TARGET -Recurse -Force > $null}

$zipFile = "$LIB\$RELEASE_NAME.zip"

Invoke-WebRequest -Uri $URL -OutFile $zipFile
Expand-Archive -Path $zipFile -DestinationPath $LIB
Remove-Item $zipFile > $null
Rename-Item "$LIB\$RELEASE_NAME" $TARGET > $null
