$TARGET = "$env:DEVENV\devenv"


$version = "glfw-3.3.8.bin.WIN64"
$url = "https://github.com/glfw/glfw/releases/download/3.3.8/$version.zip"


Invoke-WebRequest -Uri $url -OutFile "$TARGET\glfw.zip" > $null
Expand-Archive -Path "$TARGET\glfw.zip" -DestinationPath $TARGET > $null
Rename-Item "$TARGET\$version" "$TARGET\glfw" > $null
