$TARGET = "$env:DEVENV\devenv"
$ZIP_FILE = "$env:DEVENV\devenv\mingw64.zip"

$URL = "https://github.com/brechtsanders/winlibs_mingw/" `
    + "releases/download/13.2.0-16.0.6-11.0.0-ucrt-r1/" `
    + "winlibs-x86_64-posix-seh-gcc" `
    + "-13.2.0-llvm-16.0.6-mingw-w64ucrt-11.0.0-r1.zip"

Invoke-WebRequest -Uri $URL -OutFile $ZIP_FILE
Expand-Archive -Path $ZIP_FILE -DestinationPath $TARGET
Remove-Item $ZIP_FILE > $null

