$ZIP_FILE = "$env:DEVENV\lib\glad.zip"
$TARGET = "$env:DEVENV\devenv\glad"

if (-Not (Test-Path $TARGET)) {New-Item $TARGET -ItemType Directory > $null}
Expand-Archive -Path $ZIP_FILE -DestinationPath $TARGET > $null