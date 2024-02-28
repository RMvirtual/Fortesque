$LIB = "$env:DEVENV\lib"
$TARGET = "$LIB\glfw"

$VERSION = "3.3.8"
$PLATFORM = "bin.WIN64"
$RELEASE_NAME = "glfw-$VERSION.$PLATFORM"
$URL = "https://github.com/glfw/glfw/releases/download/$VERSION/$RELEASE_NAME.zip"


if (Test-Path $TARGET) {Remove-Item $TARGET -Recurse -Force > $null}

$zipFile = "$LIB\$RELEASE_NAME.zip"

Invoke-WebRequest -Uri $URL -OutFile $zipFile
Expand-Archive -Path $zipFile -DestinationPath $LIB
Remove-Item $zipFile > $null
Rename-Item "$LIB\$RELEASE_NAME" $TARGET > $null
