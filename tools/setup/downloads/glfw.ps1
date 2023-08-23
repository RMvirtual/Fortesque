$TARGET = "$env:DEVENV\devenv"
$ZIP_FILE = "$TARGET\glfw.zip"

$version = "glfw-3.3.8.bin.WIN64"
$url = "https://github.com/glfw/glfw/releases/download/3.3.8/$version.zip"


Invoke-WebRequest -Uri $url -OutFile $ZIP_FILE > $null
Expand-Archive -Path $ZIP_FILE -DestinationPath $TARGET > $null
Rename-Item "$TARGET\$version" "$TARGET\glfw" > $null
