$LIB = "$env:DEVENV\lib"

$VERSION = "3.28.3"
$PLATFORM = "windows-x86_64"
$FOLDER_NAME = "cmake-$VERSION-$PLATFORM"

$URL = "https://github.com/Kitware/CMake/releases/download/" `
    + "v$VERSION/$FOLDER_NAME.zip"


$zipFile = "$LIB\$FOLDER_NAME.zip"

Invoke-WebRequest -Uri $URL -OutFile $zipFile
Expand-Archive -Path $zipFile -DestinationPath $LIB
Remove-Item $zipFile > $null
Rename-Item "$LIB\$FOLDER_NAME" "$LIB\cmake" > $null

