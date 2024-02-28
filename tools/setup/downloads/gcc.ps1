$LIB = "$env:DEVENV\lib"
$TARGET = "$LIB\mingw64"

$URL = "https://github.com/brechtsanders/winlibs_mingw/" `
    + "releases/download/13.2.0-16.0.6-11.0.0-ucrt-r1/" `
    + "winlibs-x86_64-posix-seh-gcc" `
    + "-13.2.0-llvm-16.0.6-mingw-w64ucrt-11.0.0-r1.zip"


if (Test-Path $TARGET) {Remove-Item $TARGET -Recurse -Force > $null}

$zipFile = "$LIB\mingw64.zip"
Invoke-WebRequest -Uri $URL -OutFile $zipFile
Expand-Archive -Path $zipFile -DestinationPath $LIB
Remove-Item $zipFile > $null
